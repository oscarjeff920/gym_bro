import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/workout_timer_cubit/workout_timer_cubit.dart';

import '../../../state_management/cubits/workout_timer_cubit/workout_timer_state.dart';

class WorkoutDateTimer extends StatelessWidget {
  const WorkoutDateTimer({
    super.key,
  });

  String formatDateNow() {
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    String year = dateToday.year.toString();
    String month = dateToday.month.toString().length == 1
        ? "0${dateToday.month.toString()}"
        : dateToday.month.toString();
    String date = dateToday.day.toString().length == 1
        ? "0${dateToday.day.toString()}"
        : dateToday.day.toString();

    return "$date / $month / $year";
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
                  formatDateNow(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<WorkoutTimerCubit, WorkoutTimerState>(
                  builder: (context, state) {
                    return Text(
                      state.toString(),
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
