import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/database_data_models/tables/workout/workout_object.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';
import 'package:gym_bro/state_management/cubits/toggle_workout_week_widget_cubit/toggle_workout_week_widget_cubit.dart';
import 'package:gym_bro/state_management/cubits/toggle_workout_week_widget_cubit/toggle_workout_week_widget_state.dart';

import 'workouts_list_sub-widgets/week_toggle_header_widget.dart';
import 'workouts_list_sub-widgets/weekday_workout_cards_animated_container_sub-widgets/weekly_exercise_count_bar_widget.dart';
import 'workouts_list_sub-widgets/weekday_workout_cards_container_widget.dart';

class WorkoutsList extends StatelessWidget {
  final Map<DateTime,
      Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  static int initWeekBlockNumber = 8;

  @override
  Widget build(BuildContext context) {
    final List<
            MapEntry<DateTime,
                Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>>>
        workoutMapEntries = allWorkouts.entries.toList();
    return BlocBuilder<ToggleWorkoutWeekWidgetCubit,
        ToggleWorkoutWeekWidgetState>(builder: (context, state) {
      if (state is ToggleWorkoutWeekWidgetInitState) {
        BlocProvider.of<ToggleWorkoutWeekWidgetCubit>(context)
            .loadWorkoutWeeks(workoutMapEntries);
      }
      return ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: workoutMapEntries.length > initWeekBlockNumber
            ? initWeekBlockNumber
            : workoutMapEntries.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 40,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
            builder: (context, state) {
              return WorkoutWeekBlockContainer(
                index: index,
                workoutsOfTheWeek: workoutMapEntries[index].value,
                weekStartDate: workoutMapEntries[index].key,
              );
            },
          );
        },
      );
    });
  }
}

class WorkoutWeekBlockContainer extends StatelessWidget {
  const WorkoutWeekBlockContainer(
      {super.key,
      required this.index,
      required this.workoutsOfTheWeek,
      required this.weekStartDate});

  final int index;
  final DateTime weekStartDate;
  final Map<int, List<WorkoutTableWithExercisesWorkedMuscleGroups>>
      workoutsOfTheWeek;

  @override
  Widget build(BuildContext context) {
    Map<int, String> weekDayIntegerMap = {
      0: "Monday",
      1: "Tuesday",
      2: "Wednesday",
      3: "Thursday",
      4: "Friday",
      5: "Saturday",
      6: "Sunday"
    };

    String headerString = index == 0 ? "Current Week" : "Week Beginning";

    return Container(
      color: Colors.white,
      child: BlocBuilder<ToggleWorkoutWeekWidgetCubit,
          ToggleWorkoutWeekWidgetState>(
        builder: (context, state) {
          bool isToggled = index == 0 ? true : false;
          if (state is ToggleWorkoutWeekWidgetLoadedWeeksState) {
            isToggled = state.isExpandedArray[index];
          }

          return Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeekToggleHeader(
                  headerString: headerString,
                  index: index,
                  weekStartDate: weekStartDate,
                  isCurrentWeek: index == 0,
                  isToggledOn: isToggled),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                height: isToggled ? 223 : 0, //183 : 0,
                curve: Curves.easeInOutQuart,
                child: SingleChildScrollView(
                  child: WeekDayWorkoutCardsAnimatedContainer(
                    weekDayIntegerMap: weekDayIntegerMap,
                    weekStartDate: weekStartDate,
                    workoutsOfTheWeek: workoutsOfTheWeek,
                  ),
                ),
              ),
              WeeklyExerciseCountBar(
                workoutsOfTheWeek: workoutsOfTheWeek,
              )
            ],
          );
        },
      ),
    );
  }
}
