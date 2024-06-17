import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'backup_current_workout_state.dart';

class BackupCurrentWorkoutCubit extends Cubit<BackupCurrentWorkoutState> {
  BackupCurrentWorkoutCubit() : super(const BackupCurrentWorkoutState());

  collectErrorState(Map<String, dynamic> backupWorkoutData) {
    emit(BackupCurrentWorkoutState(backupWorkoutData: backupWorkoutData));
  }

  writeCurrentWorkoutState(Map<String, dynamic> backupWorkoutData) async {
    Directory rootDirectory = await getApplicationDocumentsDirectory();
    File backupFile =
    File('${rootDirectory.path}/backup_state/backup_workout_state.json');
    Map<String, dynamic> stateData = backupWorkoutData;

    try {
      await Directory('${rootDirectory.path}/backup_state')
          .create(recursive: true);

      await backupFile.writeAsString(json.encode(stateData));

      print('backup saved at ${backupFile.path}');
    }
    catch (err) {
      print("there was an error backing up current workout: $err");
      emit(BackupCurrentWorkoutErrorState(error: err));

    }
  }

  clearBackedUpWorkout() async {
    Directory rootDirectory = await getApplicationDocumentsDirectory();
    File backupFile = File('${rootDirectory.path}/backup_state/backup_workout_state.json');

    try {
      if (await backupFile.exists()) {
        await backupFile.delete();
        print("successfully deleted backup file");
      }
    } catch (err) {
        print("error in wiping backup workout: $err");
        emit(BackupCurrentWorkoutErrorState(error: err));
    }

  }

  loadBackupState() async {
    print("Retrieving backup workout.");
    Directory rootDirectory = await getApplicationDocumentsDirectory();

    Directory backupStateDirectory =
    Directory("${rootDirectory.path}/backup_state");

    File backupStateFile =
    File("${backupStateDirectory.path}/backup_workout_state.json");

    if (await backupStateDirectory.exists() && await backupStateFile.exists()) {
      try {
        String jsonString = await backupStateFile.readAsString();

        Map<String, dynamic> jsonAsMap = jsonDecode(jsonString);

        emit(BackupCurrentWorkoutState(backupWorkoutData: jsonAsMap));
      } catch (err) {
        emit(BackupCurrentWorkoutErrorState(error: err));
        print("there was an error retrieving the backed up data state: $err");
      }
    } else {
      emit(const BackupCurrentWorkoutState());
    }
  }
}
