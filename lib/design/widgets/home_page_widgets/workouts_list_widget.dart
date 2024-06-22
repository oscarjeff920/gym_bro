import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/FE_data_models/workout_data_models.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_cubit.dart';
import 'package:gym_bro/state_management/cubits/active_workout_cubit/active_workout_state.dart';

import 'workouts_list_sub-widgets/week_toggle_header_widget.dart';
import 'workouts_list_sub-widgets/weekday_workout_cards_container_widget.dart';

class WorkoutsList extends StatelessWidget {
  final Map<DateTime, Map<int, LoadedWorkoutModel>> allWorkouts;

  const WorkoutsList({super.key, required this.allWorkouts});

  @override
  Widget build(BuildContext context) {
    final workoutMapEntries = allWorkouts.entries.toList();
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: workoutMapEntries.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return BlocBuilder<ActiveWorkoutCubit, ActiveWorkoutState>(
          builder: (context, state) {
            return WorkoutWeekBlockContainer(
              index: index,
              workoutsOfTheWeek: workoutMapEntries[index].value,
              weekStartDate: workoutMapEntries[index].key,
              // weekStartDate: allWorkouts[index].keys.first
            );
            // return ClickableWorkoutListTile(allWorkouts: allWorkouts);
          },
        );
      },
    );
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
  final Map<int, LoadedWorkoutModel> workoutsOfTheWeek;

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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeekToggleHeader(
              headerString: headerString,
              index: index,
              weekStartDate: weekStartDate,
              isCurrentWeek: index == 0,
              isToggledOn: index == 0 || index == 3
          ),
          // WeekToggleHeader(
          //     headerString: headerString,
          //     index: index,
          //     weekStartDate: weekStartDate),
          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            height: index == 0 || index == 0 ? 183 : 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: index == 0 || index == 0 ? 1 : 0,
              child: WeekDayWorkoutCardsAnimatedContainer(
                  weekDayIntegerMap: weekDayIntegerMap,
                  weekStartDate: weekStartDate,
                  workoutsOfTheWeek: workoutsOfTheWeek,

              ),
            ),
          ),
          // ExerciseCountBar()
        ],
      ),
    );
  }
}



// class ClickableWorkoutListTile extends StatelessWidget {
//   const ClickableWorkoutListTile({
//     super.key,
//     required this.allWorkouts,
//   });
//
//   final Map<DateTime, Map<int, LoadedWorkoutModel>> allWorkouts;
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Text(
//                 "${allWorkouts[index].day}/${allWorkouts[index].month}/${allWorkouts[index].year}"),
//             Text(allWorkouts[index].workoutStartTime ?? "- - -")
//           ],
//         ),
//       ),
//       tileColor: Colors.white,
//       onTap: () {
//         // if the selected workout has already been loaded to state
//         // we can just move onto the workout page, no need to re-query
//         if (state is LoadedActiveWorkoutState &&
//             state.id == allWorkouts[index].id) {
//           Navigator.of(context).pushNamed("/workout-page");
//         } else {
//           // query selected workout and load it to ActiveWorkoutState
//           BlocProvider.of<ExerciseTableOperationsBloc>(context).add(
//               QueryAllExerciseByWorkoutEvent(
//                   selectedWorkout: allWorkouts[index]));
//           BlocProvider.of<ActiveWorkoutCubit>(context)
//               .loadWorkoutToState(allWorkouts[index]);
//         }
//       },
//     );
//   }
// }
