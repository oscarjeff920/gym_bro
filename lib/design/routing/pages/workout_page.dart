import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_bloc.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise/exercise_table_operations_state.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/data_model_cubits/workout_page/workout_page_workout_cubit/workout_page_workout_state.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_cubit.dart';
import 'package:gym_bro/state_management/cubits/open_exercise_modal_cubit/open_exercise_modal_state.dart';
import '../../widgets/the_app_bar_widget.dart';
import '../../widgets/workout_page_widgets/add_exercise_modal/add_exercise_modal_widget.dart';
import '../../widgets/workout_page_widgets/completed_exercises_scaffold/completed_exercises_scaffold_widget.dart';
import '../../widgets/workout_page_widgets/exercise_count_bar/exercise_count_bar_widget.dart';
import '../../widgets/workout_page_widgets/workout_date_timer_widget.dart';

class WorkoutOverviewPage extends StatelessWidget {
  const WorkoutOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // CHANGE!!!
    double tileSpacingValue = 12;
    return BlocBuilder<ExerciseTableOperationsBloc,
        ExerciseTableOperationsState>(builder: (context, state) {
      switch (state) {
        case ExerciseTableSuccessfulQueryAllByWorkoutIdState():
          BlocProvider.of<WorkoutPageWorkoutCubit>(context)
              .loadExercisesToWorkout(
                  state.selectedWorkout, state.allExercisesQuery);
        case ExerciseTableQueryErrorState():
          Navigator.of(context).pushNamed("/");
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TheAppBar(),
        body: BlocBuilder<WorkoutPageWorkoutCubit, WorkoutPageWorkoutState>(
          builder: (context, state) {
            switch (state) {
              case WorkoutPageDetailsState():
                return Column(
                  children: [
                    Material(
                        elevation: 2,
                        child: WorkoutDateTimer(
                          year: state.year,
                          month: state.month,
                          day: state.day,
                          workoutDuration: state.workoutDuration,
                        )),
                    Expanded(
                      child: Container(
                        // COMBINE-SPACING!
                        child: Stack(children: [
                          Positioned.fill(
                              child: CompletedExercisesScaffold(
                            tileSpacingValue: tileSpacingValue,
                            exercises: state.exercises,
                            isCurrentWorkout: state.id == null,
                          )),
                          BlocBuilder<OpenExerciseModalCubit,
                              OpenExerciseModalState>(
                            builder: (context, state) {
                              double fadedValue;
                              switch (state) {
                                case ExerciseModalOpenedState():
                                  fadedValue = 0.8;
                                default:
                                  fadedValue = 0;
                              }
                              return IgnorePointer(
                                child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    color:
                                        Colors.black.withOpacity(fadedValue)),
                              );
                            },
                          ),
                          BlocBuilder<OpenExerciseModalCubit,
                                  OpenExerciseModalState>(
                              builder: (context, state) {
                            return IgnorePointer(
                              ignoring: !state.isOpen,
                              child: AnimatedOpacity(
                                opacity: state.isOpen ? 1 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: const AddExerciseModal(),
                              ),
                            );
                          }),
                        ]),
                      ),
                    ),
                    const ExerciseCountBar()
                  ],
                );
              default:
                return Container();
            }
          },
        ),
      );
    });
  }
}
