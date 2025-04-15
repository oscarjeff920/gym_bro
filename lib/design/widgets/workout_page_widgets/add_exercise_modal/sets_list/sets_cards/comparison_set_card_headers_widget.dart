import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_cubit.dart';
import 'package:gym_bro/state_management/cubits/current_comparison_set_tracking_cubit/current_comparison_set_tracker_state.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_state.dart';

class ComparisonSetCardHeaders extends StatelessWidget {
  const ComparisonSetCardHeaders({
    super.key,
    required this.exerciseSetsByMovementReturnData,
  });

  final Map<ComparisonDisplayType, List<Map<String, dynamic>>>
      exerciseSetsByMovementReturnData;

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
      child: BlocBuilder<DisplayPrCubit, DisplayPrState>(
        builder: (displayPrContext, displayPrState) {
          // TODO: bad name -> displayedComparisonSetType
          List displayedComparisonSetType = exerciseSetsByMovementReturnData[
              displayPrState.currentDisplayedComparisonSetType]!;

          return BlocBuilder<CurrentComparisonSetTrackerCubit,
              CurrentComparisonSetTrackerState>(
            builder: (currentComparisonSetTrackerContext,
                currentComparisonSetTrackerState) {
              Map currentlyDisplayedComparisonSetData =
                  displayedComparisonSetType.elementAt(
                      currentComparisonSetTrackerState.getIndexByDisplayType(
                          displayPrState.currentDisplayedComparisonSetType));

              return Row(
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
                            padding:
                                WidgetStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.zero),
                            // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            displayPrState.isPRDisplayed
                                ? "Personal Record:"
                                : "Last Workout:",
                            style: const TextStyle(color: Colors.purpleAccent),
                          ),
                          onPressed: () {
                            displayPrContext
                                .read<DisplayPrCubit>()
                                .toggleComparisonType();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(bottom: 4, right: 15),
                      // color: Colors.black12,
                      child: Row(children: [
                        SizedBox(
                          width: 30,
                          // height: 25,
                          child: Visibility(
                            visible: currentComparisonSetTrackerState
                                .indexNotAtMax(displayPrState
                                    .currentDisplayedComparisonSetType),
                            child: IconButton(
                              onPressed: () {
                                currentComparisonSetTrackerContext
                                    .read<CurrentComparisonSetTrackerCubit>()
                                    .updateCurrentIndex(
                                        currentDisplayType: displayPrState
                                            .currentDisplayedComparisonSetType,
                                        isIncrease: true);
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
                            if (displayPrState.isPRDisplayed) {
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
                            currentlyDisplayedComparisonSetData['dateString'],
                            textScaler: const TextScaler.linear(1),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          // height: 25,
                          child: Visibility(
                            visible: currentComparisonSetTrackerState
                                .indexNotAtMin(displayPrState
                                    .currentDisplayedComparisonSetType),
                            child: IconButton(
                              onPressed: () {
                                currentComparisonSetTrackerContext
                                    .read<CurrentComparisonSetTrackerCubit>()
                                    .updateCurrentIndex(
                                        currentDisplayType: displayPrState
                                            .currentDisplayedComparisonSetType,
                                        isIncrease: false);
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
                      ])),
                  SizedBox(
                    width: 90,
                    // height: 24,
                    // padding: const EdgeInsets.only(left: 5, right: 25, bottom: 5),
                    // color: Colors.black12,
                    child: displayPrState.isPRDisplayed
                        ? Text(
                            "Set Number: ${currentlyDisplayedComparisonSetData['PR_set'].exerciseSetOrder}",
                            textScaleFactor: 0.75,
                          )
                        : Text(
                            // "Working Sets: $workingSetsCount",
                            "Working Sets: ERR",
                            textScaleFactor: 0.75,
                          ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
