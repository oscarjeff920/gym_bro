import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/design/widgets/workout_page_widgets/add_exercise_modal/sets_list/sets_cards/general_set_container_widget.dart';
import 'package:gym_bro/state_management/cubits/add_exercise_cubit/add_exercise_cubit.dart';

import 'set_field_widget.dart';

class ExpandableNotesTextField extends StatefulWidget {
  final TextStyle headerTextStyle;
  final SetType setType;
  final String? notes;
  final double notesContainerHeight;

  const ExpandableNotesTextField({
    super.key,
    required this.headerTextStyle,
    required this.setType,
    required this.notes,
    required this.notesContainerHeight,
  });

  @override
  State<ExpandableNotesTextField> createState() =>
      _ExpandableNotesTextFieldState();
}

class _ExpandableNotesTextFieldState extends State<ExpandableNotesTextField> {
  bool _isExpanded = false;

  // Keeping this here in-case we want to show notes field despite there being none
  // bool showIcon() => widget.setType == SetType.current || widget.notes != null;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  double get opacityValue => 0.5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpanded,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 1, color: Colors.black.withOpacity(0.1)),
              bottom:
                  BorderSide(width: 1, color: Colors.black.withOpacity(0.1)),
            )),
            height: widget.notesContainerHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 35,
                      child: Text(
                        "Notes..",
                        style: TextStyle(
                            color: _isExpanded
                                ? widget.headerTextStyle.color
                                : widget.headerTextStyle.color!
                                    .withOpacity(opacityValue),
                            fontSize: 10),
                      ),
                    ),
                  ),
                const Spacer(flex: 12),
                SizedBox(
                    width: 35,
                    child: Icon(
                      _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                      color: widget.setType == SetType.completed
                          ? _isExpanded
                              ? Colors.black
                              : Colors.black.withOpacity(opacityValue)
                          : _isExpanded
                              ? Colors.white
                              : Colors.white.withOpacity(opacityValue),
                      size: 24,
                    ),
                  ),
                const Spacer()
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.bounceInOut,
          height: _isExpanded ? 35 : 0,
          // Adjust height for expanded/collapsed states
          child: _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SetNumericalField(
                    value: widget.notes,
                    autoFocus: true,
                    setType: widget.setType,
                    inputType: TextInputType.text,
                    updateSetFunction: (notes) {
                      BlocProvider.of<AddExerciseCubit>(context)
                          .updateCurrentSet(CurrentSet(notes: notes));
                    },
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
