// import 'package:flutter/material.dart';
// import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
// import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/set_numerical_fields_widget.dart';
//
// import '../duration_text_field_widget.dart';
// import '../warm_up_check_box.dart';
//
// class CompletedSetContainer extends StatelessWidget {
//   // final bool isPrevious;
//   // final bool isCompleted;
//   // final GeneralExerciseSetModel? completedSet;
//   // final CurrentSet? currentSet;
//   final GeneralExerciseSetModel completedSet;
//
//   // final int? setNumber;
//
//   const CompletedSetContainer({
//     super.key,
//     // this.isPrevious = false,
//     // this.isCompleted = false,
//     required this.completedSet,
//     // this.currentSet,
//     // required this.comparisonSet,
//     // this.setNumber,
//   });
//
//   static const textStyle = TextStyle(fontSize: 9, color: Colors.black);
//   static const textFieldStyle = TextStyle(color: Colors.black);
//
//   // bool get isCurrent => currentSet != null;
//   //
//   // bool get isPrevious => comparisonSet != null && currentSet == null;
//   //
//   // bool get isCompleted => completedSet != null;
//
//   // GeneralExerciseSetModel? get set =>
//   //     isCurrent ? null : isPrevious ? comparisonSet : completedSet;
//
//   Color get setColour {
//     if (false) {
//       return const Color.fromRGBO(0, 0, 0, 1);
//     } else if (false) {
//       return const Color.fromRGBO(124, 124, 124, 1);
//     } else {
//       return const Color.fromRGBO(255, 255, 255, 0.9);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(left: 5),
//       color: setColour,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // if (false)
//           //   Padding(
//           //     padding: const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
//           //     child: Row(
//           //       mainAxisAlignment: MainAxisAlignment.start,
//           //       children: [
//           //         Text(
//           //           setNumber == null ? "Warm up Set" : "Working Set: ",
//           //           style: const TextStyle(
//           //             color: Color.fromRGBO(255, 255, 255, 0.6),
//           //             fontSize: 11,
//           //           ),
//           //         ),
//           //         Text(
//           //           setNumber == null ? "" : "$setNumber",
//           //           style: const TextStyle(
//           //             fontWeight: FontWeight.bold,
//           //             color: Color.fromRGBO(255, 255, 255, 1),
//           //             fontSize: 11,
//           //           ),
//           //         ),
//           //         const Spacer(),
//           //         if (false)
//           //           Padding(
//           //             padding: const EdgeInsets.only(right: 15.0),
//           //             child: SizedBox(
//           //                 width: 20,
//           //                 height: 20,
//           //                 child: IconButton(
//           //                     padding: const EdgeInsets.all(0),
//           //                     onPressed: () {},
//           //                     icon: const Icon(
//           //                       Icons.check,
//           //                       size: 20,
//           //                     ))),
//           //           )
//           //       ],
//           //     ),
//           //   ),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   children: [
//                     const SetFieldHeader(header: "Rest Time:", textStyle: textStyle),
//                     DurationTextFieldWidget(
//                       displayDuration: completedSet.setDuration, textStyle: textFieldStyle,
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     const SetFieldHeader(header: "Warm Up:", textStyle: textStyle),
//                     WarmupCheckbox(
//                         isBoxChecked: completedSet.isWarmUp,
//                         updateSetFunction: null,
//                         // (value) {
//                         //                     BlocProvider.of<AddExerciseCubit>(context)
//                         //                         .updateCurrentSet(CurrentSet(isWarmUp: value));
//                         //                   },
//                         )
//                   ],
//                 ),
//               ),
//               // Expanded(
//               //   child: Column(
//               //     children: [
//               //       const SetFieldHeader(header: "Weight:", textStyle: textStyle),
//               //       SetNumericalFields(
//               //         value: completedSet.weight,
//               //         textStyle: textFieldStyle,
//               //       )
//               //     ],
//               //   ),
//               // ),
//               // Expanded(
//               //   child: Column(
//               //     children: [
//               //       const SetFieldHeader(header: "Reps:", textStyle: textStyle),
//               //       SetNumericalFields(value: completedSet.reps, textStyle: textFieldStyle,)
//               //     ],
//               //   ),
//               // ),
//               // Expanded(
//               //   child: Column(
//               //     children: [
//               //       const SetFieldHeader(header: "+ Reps:", textStyle: textStyle),
//               //       SetNumericalFields(
//               //         value: completedSet.extraReps, textStyle: textFieldStyle,
//               //       )
//               //     ],
//               //   ),
//               // ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     const SetFieldHeader(header: "Duration:", textStyle: textStyle),
//                     DurationTextFieldWidget(
//                         displayDuration: completedSet.setDuration, textStyle: textFieldStyle,)
//                   ],
//                 ),
//               ),
//               const Expanded(
//                 child: Column(
//                   children: [
//                     SetFieldHeader(header: "Effort:", textStyle: textStyle),
//                     TextField(readOnly: true, style: textFieldStyle)
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           AnimatedContainer(
//             duration: const Duration(seconds: 1),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 22,
//                   child: Stack(
//                     children: [
//                       const Align(
//                           alignment: Alignment.center,
//                           child: SetFieldHeader(header: "Notes..", textStyle: textStyle)),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: IconButton(
//                           padding: EdgeInsets.zero,
//                           // iconSize: 15,
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.arrow_right,
//                             // TODO: isComplete
//                             color: Colors.black,
//                             size: 15,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class SetFieldHeader extends StatelessWidget {
//   final String header;
//   final TextStyle textStyle;
//
//   const SetFieldHeader(
//       {super.key,
//       required this.header,
//       this.textStyle = const TextStyle(
//         fontSize: 9,
//         color: Colors.white,
//       )});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       header.toString(),
//       // textAlign: TextAlign.center,
//       style: textStyle,
//     );
//   }
// }
