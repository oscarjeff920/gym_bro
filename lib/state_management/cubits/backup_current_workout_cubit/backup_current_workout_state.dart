import 'package:equatable/equatable.dart';

class BackupCurrentWorkoutState extends Equatable {
  final Map<String, dynamic> backupWorkoutData;

  const BackupCurrentWorkoutState({this.backupWorkoutData = const {}});

  @override
  List<Object?> get props => [backupWorkoutData];
}

class BackupCurrentWorkoutErrorState extends BackupCurrentWorkoutState {
  final Object error;

  const BackupCurrentWorkoutErrorState(
      {super.backupWorkoutData, required this.error});

  @override
  List<Object?> get props => [super.backupWorkoutData, error];
}
