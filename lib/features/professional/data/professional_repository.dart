import 'package:app_agendamento/core/device/app_location.dart';
import 'package:app_agendamento/core/helpers/result.dart';
import 'package:app_agendamento/features/professional/data/professional_datasource.dart';
import 'package:app_agendamento/features/professional/models/professional.dart';
import 'package:app_agendamento/features/professional/models/professional_details.dart';
import 'package:app_agendamento/features/professional/models/rating.dart';

class ProfessionalRepository {
  ProfessionalRepository(this._datasource);

  final ProfessionalDatasource _datasource;

  Future<Result<void, ProfessionalDetails>> getProfessional(
      {required String id}) {
    return _datasource.getProfessional(id: id);
  }

  Future<Result<void, List<Rating>>> getProfessionalRatings({
    required String professionalId,
    required int itemsPerPage,
    required int page,
  }) {
    return _datasource.getProfessionalRatings(
      professionalId: professionalId,
      itemsPerPage: itemsPerPage,
      page: page,
    );
  }

  Future<Result<void, List<ProfessionalDetails>>> getProfessionals({
    required Location southwest,
    required Location northeast,
  }) {
    return _datasource.getProfessionals(southwest: southwest, northeast: northeast);
  }
}
