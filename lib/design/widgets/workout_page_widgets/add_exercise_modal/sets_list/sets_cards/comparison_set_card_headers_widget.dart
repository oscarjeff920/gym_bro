import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_cubit.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_state.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';

class ComparisonSetCardHeaders extends StatelessWidget {
  const ComparisonSetCardHeaders({
    super.key,
    required this.date,
    required this.workingSetsCount,
    required this.isPr,
    required this.setOrder,
  });

  final bool isPr;
  final String date;
  final int workingSetsCount;
  final int setOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, left: 0, right: 0),
      padding: const EdgeInsets.symmetric(vertical: 4),
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      // height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: SizedBox(
              width: 110,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    isPr ? "Personal Record:" : "Last Workout:",
                    style: const TextStyle(color: Colors.purpleAccent),
                  ),
                  onPressed: () {
                    BlocProvider.of<DisplayPrCubit>(context).togglePr();
                  },
                ),
              ),
            ),
          ),
          BlocBuilder<CurrentComparisonSetTrackerCubit,
              CurrentComparisonSetTrackerState>(
            builder: (context, state) {
              return Container(
                  padding: const EdgeInsets.only(bottom: 4, right: 15),
                  // color: Colors.black12,
                  child: Row(children: [
                    SizedBox(
                      width: 30,
                      // height: 25,
                      child: Visibility(
                        visible: isPr
                            ? state.currentPRExerciseIndex ==
                                    state.maxIndexOfPRExerciseSessions
                                ? false
                                : true
                            : state.currentPreviousExerciseIndex ==
                                    state.maxIndexOfPreviousExerciseSessions
                                ? false
                                : true,
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<CurrentComparisonSetTrackerCubit>(
                                    context)
                                .updateCurrentIndex(
                              isPr: isPr,
                              // as the most recent exercise session is index 0, to go back the index needs to increase
                              isIncrease: true,
                            );
                          },
                          icon: const Icon(Icons.chevron_left, size: 20),
                          style: ButtonStyle(
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.zero),
                            // side: WidgetStateProperty.all<BorderSide>(),

                            // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTap: () {
                        if (isPr) {
                          BlocProvider.of<CurrentComparisonSetTrackerCubit>(
                                  context)
                              .resetPRIndex();
                        } else {
                          BlocProvider.of<CurrentComparisonSetTrackerCubit>(
                                  context)
                              .resetPreviousExerciseSessionIndex();
                        }
                      },
                      child: Text(
                        date,
                        textScaler: const TextScaler.linear(1),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      // height: 25,
                      child: Visibility(
                        visible: isPr
                            ? state.currentPRExerciseIndex == 0
                                ? false
                                : true
                            : state.currentPreviousExerciseIndex == 0
                                ? false
                                : true,
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<CurrentComparisonSetTrackerCubit>(
                                    context)
                                .updateCurrentIndex(
                              isPr: isPr,
                              // as the most recent exercise session is index 0, to go back the index needs to decrease
                              isIncrease: false,
                            );
                          },
                          icon: const Icon(
                            Icons.chevron_right,
                            size: 20,
                          ),
                          style: ButtonStyle(
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ),
                  ]));
            },
          ),
          SizedBox(
            width: 90,
            // height: 24,
            // padding: const EdgeInsets.only(left: 5, right: 25, bottom: 5),
            // color: Colors.black12,
            child: isPr
                ? Text(
                    "Set Number: $setOrder",
                    textScaleFactor: 0.75,
                  )
                : Text(
                    "Working Sets: $workingSetsCount",
                    textScaleFactor: 0.75,
                  ),
          ),
        ],
      ),
    );
  }
}
