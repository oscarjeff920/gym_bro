import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';

class ComparisonSetCardHeaders extends StatelessWidget {
  const ComparisonSetCardHeaders(
      {super.key,
      required this.date,
      required this.workingSetsCount,
      required this.isPr});

  final bool isPr;
  final String date;
  final int workingSetsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, left: 0, right: 5),
      padding: const EdgeInsets.symmetric(vertical: 4),
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      // height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding:
                const EdgeInsets.only(
                    left: 5,
                    right: 0,
                    bottom: 0,
                    // top: 2
                ),
            // color: Colors.black12,
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
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                  onPressed: () {
                    BlocProvider.of<DisplayPrCubit>(context).togglePr();
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
                  child: IconButton(
                      onPressed: (){}, icon: Icon(Icons.chevron_left, size: 20),
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      // side: WidgetStateProperty.all<BorderSide>(),

                      // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
                Text(
                  date,
                  textScaler: const TextScaler.linear(1),
                ),
                SizedBox(
                  width: 30,
                  // height: 25,
                  child: IconButton(
                      onPressed: (){}, icon: Icon(Icons.chevron_right, size: 20,),
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ])),
          SizedBox(
            width: 90,
            // height: 24,
            // padding: const EdgeInsets.only(left: 5, right: 25, bottom: 5),
            // color: Colors.black12,
            child: isPr
                ? const Text("")
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
