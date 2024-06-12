import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/display_pr_cubit/display_pr_cubit.dart';

class PreviousSetCardHeaders extends StatelessWidget {
  const PreviousSetCardHeaders(
      {super.key,
      required this.date,
      required this.workingSetsCount,
      required this.isPr});

  final bool isPr;
  final String date;
  final int workingSetsCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 2),
            // color: Colors.black12,
            child: SizedBox(
              width: 110,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(isPr ? "Personal Record:" : "Last Workout:"),
                  onPressed: () {
                    BlocProvider.of<DisplayPrCubit>(context).togglePr();
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            // color: Colors.black12,
            child: Text(
              date,
              textScaleFactor: 1,
            ),
          ),
          SizedBox(
            height: 20,
            width: 100,
            // padding: const EdgeInsets.only(left: 5, right: 25, bottom: 5),
            // color: Colors.black12,
            child: isPr ? const Text("") :Text(
              "Working Sets: $workingSetsCount",
              textScaleFactor: 0.75,
            ),
          ),
        ],
      ),
    );
  }
}
