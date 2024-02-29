import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_event.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';

class WorkoutsList extends StatelessWidget {
  final List<WorkoutModel_HomePage> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: allWorkouts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Center(
            child: Text(
                "${allWorkouts[index].day}/${allWorkouts[index].month}/${allWorkouts[index].year}"),
          ),
          tileColor: Colors.white,
          onTap: () {
            BlocProvider.of<ExerciseTableOperationsBloc>(context).add(
                QueryAllExerciseByWorkoutEvent(
                    selectedWorkout: allWorkouts[index]));
            BlocProvider.of<WorkoutPageWorkoutCubit>(context)
                .loadWorkout(allWorkouts[index]);
            Navigator.of(context).pushNamed("/workout-page");
          },
        );
      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 12,); },
    );
  }
}
