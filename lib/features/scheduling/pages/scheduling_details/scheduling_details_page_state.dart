part of 'scheduling_details_page_cubit.dart';

class SchedulingDetailsPageState extends Equatable {
  const SchedulingDetailsPageState({
    required this.isLoading,
    required this.scheduling,
  });

  const SchedulingDetailsPageState.initial()
      : isLoading = false,
        scheduling = null;

  final bool isLoading;
  final Scheduling? scheduling;

  @override
  List<Object?> get props => [isLoading, scheduling];

  SchedulingDetailsPageState copyWith({
    bool? isLoading,
    Scheduling? scheduling,
  }) {
    return SchedulingDetailsPageState(
      isLoading: isLoading ?? this.isLoading,
      scheduling: scheduling ?? this.scheduling,
    );
  }
}
