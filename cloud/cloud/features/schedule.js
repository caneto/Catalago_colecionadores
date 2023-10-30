const Professional = Parse.Object.extend('Professional');
const Schedule = Parse.Object.extend('Schedule');
const Service = Parse.Object.extend('Service');

const notification = require("./notification.js");

Parse.Cloud.define('v1-get-scheduling-slots', async (req) => {
	const duration = req.params.duration;
	const professionalId = req.params.professionalId;
	const startDate = new Date(req.params.startDate);
	const endDate = new Date(req.params.endDate);

	return getAvailableSlots(duration, professionalId, startDate, endDate);
}, {
	fields: {
		duration: {
			required: true,
		},
		professionalId: {
			required: true
		}
	}
});

Parse.Cloud.define('v1-schedule-services', async (req) => {
    const professionalId = req.params.professionalId;
    const serviceIds = req.params.serviceIds;
    const startDate = new Date(req.params.startDate);
	const endDate = new Date(req.params.endDate);

    const queryProfessional = new Parse.Query(Professional);
    queryProfessional.include('services');
    const professional = await queryProfessional.get(professionalId, {useMasterKey: true});

    const services = professional.get('services').filter((s) => serviceIds.includes(s.id));

    if(services.length != serviceIds.length) throw 'INVALID_SERVICES';

    const duration = services.reduce((partialSum, s) => partialSum + s.get('duration'), 0)

    const availableSlots = await getAvailableSlots(duration, professionalId, startDate, endDate);
    const isAvailable = availableSlots.some((d) => d.slots.some((s) => s.startDate == startDate.toISOString() && s.endDate == endDate.toISOString()));

    if(!isAvailable) throw 'SLOT_UNAVAILABLE';

    const schedule = new Schedule();
    schedule.set('startDate', startDate);
    schedule.set('endDate', endDate);
    schedule.set('professional', professional);
    schedule.set('user', req.user);
    schedule.set('status', 'active');
    schedule.set('services', services);
    await schedule.save(null, {useMasterKey: true});

    return formatSchedule(schedule.toJSON());
}, {
    requireUser: true,
});

Parse.Cloud.define('v1-get-user-schedules', async (req) => {
    const querySchedules = new Parse.Query(Schedule);
	querySchedules.equalTo('user', req.user);

	let query;

	if(req.params.futures != null) {
		if(req.params.futures) {
			querySchedules.greaterThanOrEqualTo('startDate', new Date());
			querySchedules.equalTo('status', 'active');

			query = querySchedules;
			query.ascending('startDate');
		} else {
			querySchedules.lessThanOrEqualTo('startDate', new Date());

			const querySchedulesCanceled = new Parse.Query(Schedule);
			querySchedulesCanceled.equalTo('status', 'canceled');
			querySchedulesCanceled.equalTo('user', req.user);

			query = Parse.Query.or(querySchedules, querySchedulesCanceled);
			query.descending('startDate');
		}
	} else {
		query = querySchedules;
	}

	query.limit(20);
	query.skip(20 * req.params.page);
	query.include('services', 'professional', 'professional.specialties');

    const schedules = await query.find({useMasterKey: true});
    return schedules.map((s) => formatSchedule(s.toJSON()));
}, {
    requireUser: true,
});

Parse.Cloud.define('v1-cancel-schedule', async (req) => {
	const schedule = new Schedule();
	schedule.id = req.params.scheduleId;
	await schedule.fetchWithInclude(['services', 'professional', 'professional.specialties'], {useMasterKey: true});

	if(req.user.id != schedule.get('user').id) throw 'INVALID_USER';

	schedule.set('status', 'canceled');
	await schedule.save(null, {useMasterKey: true});

	return formatSchedule(schedule.toJSON());
}, {
	requireUser: true,
	fields: {
		scheduleId: {
			required: true
		}
	}
});

Parse.Cloud.define('v1-get-schedule', async (req) => {
	const schedule = new Schedule();
	schedule.id = req.params.scheduleId;
	await schedule.fetchWithInclude(['services', 'professional', 'professional.specialties'], {useMasterKey: true});

	if(req.user.id != schedule.get('user').id) throw 'INVALID_USER';

	return formatSchedule(schedule.toJSON());
}, {
	requireUser: true,
	fields: {
		scheduleId: {
			required: true
		}
	}
});

Parse.Cloud.define('v1-professional-cancel-schedule', async (req) => {
	const querySchedule = new Parse.Query(Schedule);
	querySchedule.include('professional');
	const schedule = await querySchedule.get(req.params.scheduleId, {useMasterKey: true});
	
	if(req.user.id != schedule.get('professional').get('owner').id && !schedule.get('professional').get('users').some((u) => u.id == req.user.id)) throw 'INVALID_USER';

	schedule.set('status', 'canceled');
	await schedule.save(null, {useMasterKey: true});

	notification.sendPushNotification(
		schedule.get('user').id, 
		'cancel_schedule_by_professional', 
		{
			professional_name: schedule.get('professional').get('name'),
			schedule_id: schedule.id,
		}
	);
}, {
	requireUser: true,
	fields: {
		scheduleId: {
			required: true
		}
	}
});

Parse.Cloud.define('v1-get-professional-agenda', async (req) => {
	const queryProfessional = new Parse.Query(Professional);
    queryProfessional.equalTo('owner', req.user);
    const professional = await queryProfessional.first({useMasterKey: true});

    if(!professional) throw 'INVALID_PROFESSIONAL';

	const querySchedules = new Parse.Query(Schedule);
	querySchedules.equalTo('professional', professional);
	querySchedules.greaterThanOrEqualTo('startDate', new Date(req.params.startDate));
	querySchedules.lessThanOrEqualTo('startDate', new Date(req.params.endDate));
	querySchedules.equalTo('status', 'active');
	querySchedules.ascending('startDate');
	querySchedules.include('user', 'services');
	querySchedules.exclude('professional');
	
	const schedules = await querySchedules.find({useMasterKey: true});

	return schedules.map((s) => formatSchedule(s.toJSON()));
}, {
	requireUser: true,
	fields: {
		startDate: {
			required: true,
		},
		endDate: {
			required: true,
		},
	}
});

function formatSchedule(s) {
    return {
        id: s.objectId,
        startDate: s.startDate.iso,
        endDate: s.endDate.iso,
        status: s.status,
        professional: s.professional != null ? formatProfessional(s.professional) : undefined,
        services: s.services.map(formatService),
		user: s.user != null ? {
			id: s.user.objectId,
			fullname: s.user.fullname,
			phone: s.user.phone
		} : null,
    }
}

function formatService(s) {
    return {
        id: s.objectId,
        name: s.name,
        price: s.price,
		duration: s.duration,
		available: s.available,
    }
}

function formatSpecialty(s) {
	return {
		id: s.objectId,
		name: s.name
	}
}

function formatProfessional(p) {
	return {
		id: p.objectId,
		name: p.name,
		specialties: p.specialties.map((s) => formatSpecialty(s)),
		crm: p.crm,
        rating: p.rating,
        ratingCount: p.ratingCount,
        picture: p.profilePicture != null ? p.profilePicture?.url : null,
		location: p.location,
	};
}

async function getAvailableSlots(duration, professionalId, startDate, endDate) {
	const professional = new Professional();
	professional.id = professionalId;
	await professional.fetch({useMasterKey: true});

	const schedulingsQuery = new Parse.Query(Schedule);
	schedulingsQuery.equalTo('professional', professional);
	schedulingsQuery.greaterThanOrEqualTo('startDate', new Date(startDate.getTime() - 24*60*60*1000));
	schedulingsQuery.lessThanOrEqualTo('endDate', new Date(endDate.getTime() + 24*60*60*1000));
	schedulingsQuery.ascending('startDate');
	schedulingsQuery.equalTo('status', 'active');
	const schedulings = await schedulingsQuery.find({useMasterKey: true});

	let days = 0;
	const availableSlots = [];

	while(days < 60) {
		let currentDate = new Date(startDate.getTime() + days * 24 * 60 * 60 * 1000);
        currentDate.setHours(0, 0, 0, 0);

		days += 1;

		if(currentDate >= endDate) break;

		let weekday = currentDate.getDay();
		if(weekday == 0) weekday = 7;

		const workSlots = professional.get('scheduleRule').filter((s) => s.weekday == weekday);

		const availableSlotsInDay = [];

		for(const workSlot of workSlots) {
			const diffStart = new Date(workSlot.startTime) - new Date('2000-01-01T00:00:00.000Z');
			const diffEnd = new Date(workSlot.endTime) - new Date('2000-01-01T00:00:00.000Z');

			let workSlotStart = new Date(currentDate.getTime() + diffStart);
			let workSlotEnd = new Date(currentDate.getTime() + diffEnd);

            if(workSlotStart < startDate && workSlotEnd > startDate) {
                workSlotStart = startDate;
            } else if(workSlotStart < startDate && workSlotEnd < startDate) {
                continue;
            }
            if(workSlotStart < endDate && workSlotEnd > endDate) {
                workSlotEnd = endDate;
            } else if(workSlotStart > endDate && workSlotEnd > endDate) {
                continue;
            }

			let minutes = 0;

			while(minutes < 24 * 60) {
				const testSlotStart = new Date(workSlotStart.getTime() + minutes * 60 * 1000);
				const testSlotEnd = new Date(testSlotStart.getTime() + duration * 60 * 1000);

				minutes += professional.get('slotInterval');

				if(testSlotEnd > workSlotEnd) {
					console.error('Não coube 2');
					break;
				}

				if(schedulings.length == 0) {
					availableSlotsInDay.push(
						{
							startDate: testSlotStart.toISOString(),
							endDate: testSlotEnd.toISOString()
						}
					);
					continue;
				}

				for(const schedule of schedulings) {
					if(testSlotEnd <= schedule.get('startDate')) {
						availableSlotsInDay.push(
							{
								startDate: testSlotStart.toISOString(),
								endDate: testSlotEnd.toISOString()
							}
						);
						break;
					} else if(testSlotEnd <= schedule.get('endDate') || testSlotStart < schedule.get('endDate')){
						break;
					} else if(schedule === schedulings[schedulings.length - 1]) {
						availableSlotsInDay.push(
							{
								startDate: testSlotStart.toISOString(),
								endDate: testSlotEnd.toISOString()
							}
						);
						break;
					}
				}
			}
		}

		availableSlots.push(
			{
				date: currentDate.toISOString(),
				slots: availableSlotsInDay,
			}
		)
	}

	return availableSlots;
}