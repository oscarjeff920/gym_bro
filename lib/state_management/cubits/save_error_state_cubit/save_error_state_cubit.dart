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

  writeErrorState(Map<String, dynamic> erroredWorkoutMap) async {
    Directory rootDirectory = await getApplicationDocumentsDirectory();
    File errorStateFile =
        File('${rootDirectory.path}/error_state/saved_error_state.json');
    Map<String, dynamic> stateData = erroredWorkoutMap;

    await Directory('${rootDirectory.path}/error_state')
        .create(recursive: true);

    await errorStateFile.writeAsString(json.encode(stateData));

    print('saved at ${errorStateFile.path}');
  }

  loadErroredWorkoutToState() async {
    Directory rootDirectory = await getApplicationDocumentsDirectory();

    Directory errorStateDirectory =
        Directory("${rootDirectory.path}/error_state");

    File errorStateFile =
        File("${errorStateDirectory.path}/saved_error_state.json");

    if (await errorStateDirectory.exists() && await errorStateFile.exists()) {
      try {
        String jsonString = await errorStateFile.readAsString();

        Map<String, dynamic> jsonAsMap = jsonDecode(jsonString);

        emit(SaveErrorStateState(errorStateData: jsonAsMap));
      } catch (err) {
        print("there was an error retrieving the saved data state: $err");
      }
    }
  }
}
