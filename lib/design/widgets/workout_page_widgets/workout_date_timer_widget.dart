import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';

import '../../../state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class WorkoutDateTimer extends StatelessWidget {
  final int year;
  final int month;
  final int day;
  final String? workoutDuration;

  const WorkoutDateTimer({
    super.key,
    required this.year,
    required this.month,
    required this.day,
    this.workoutDuration,
  });

  String formatDate() {
    print("formatDate: $year/$month/$day");
    String formatYear = year.toString();
    String formatMonth = month.toString().length == 1
        ? "0${month.toString()}"
        : month.toString();
    String formatDay =
        day.toString().length == 1 ? "0${day.toString()}" : day.toString();

    return "$formatDay / $formatMonth / $formatYear";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  formatDate(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<WorkoutTimerCubit, WorkoutTimerState>(
                  builder: (context, state) {
                    return Text(
                      workoutDuration == null
                          ? state.toString()
                          : workoutDuration!,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
