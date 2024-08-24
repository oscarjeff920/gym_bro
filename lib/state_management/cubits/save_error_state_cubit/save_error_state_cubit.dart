import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/save_error_state_cubit/save_error_state_state.dart';
import 'package:path_provider/path_provider.dart';

class SaveErrorStateCubit extends Cubit<SaveErrorStateState> {
  SaveErrorStateCubit() : super(const SaveErrorStateState());

  collectErrorState(Map<String, dynamic> erroredWorkoutMap) {
    emit(SaveErrorStateState(errorStateData: erroredWorkoutMap));
  }

  writeErrorState(
      {required Map<String, dynamic> erroredWorkoutMap,
      required String error,
      bool isDebug = false}) async {
    String filePath;
    if (isDebug) {
      filePath = '/.debug-error-workouts';
    } else {
      Directory rootDirectory = await getApplicationDocumentsDirectory();
      filePath = '${rootDirectory.path}/error_state';
    }
    File errorStateFile = File('$filePath/saved_error_state.json');

    Map<String, dynamic> stateData = erroredWorkoutMap;

    // TODO: saving error in state so that it can be viewed on reload
    erroredWorkoutMap['error'] = error;

    await Directory(filePath).create(recursive: true);

    await errorStateFile.writeAsString(json.encode(stateData));

    print('saved at ${errorStateFile.path}');
  }

  loadErroredWorkoutToState({bool isDebug = false}) async {
    Directory rootDirectory = await getApplicationDocumentsDirectory();

    Directory errorStateDirectory =
        Directory("${rootDirectory.path}/error_state");

    File errorStateFile =
        File("${errorStateDirectory.path}/saved_error_state.json");

    if (await errorStateDirectory.exists() && await errorStateFile.exists()) {
      try {
        String jsonString = await errorStateFile.readAsString();

        Map<String, dynamic> jsonAsMap = jsonDecode(jsonString);

        String? errorMessageString = jsonAsMap.remove('error');

        SaveErrorStateState errorStateState = SaveErrorStateState(
            errorStateData: jsonAsMap, errorMessageString: errorMessageString);

        emit(errorStateState);
      } catch (err) {
        print("there was an error retrieving the saved data state: $err");
      }
    }
  }
}
