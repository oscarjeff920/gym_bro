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

  const ExpandableNotesTextField({
    super.key,
    required this.headerTextStyle,
    required this.setType,
    required this.notes,
  });

  @override
  State<ExpandableNotesTextField> createState() =>
      _ExpandableNotesTextFieldState();
}

class _ExpandableNotesTextFieldState extends State<ExpandableNotesTextField> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  bool showIcon() => widget.setType == SetType.current || widget.notes != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      width: 1, color: Colors.black.withOpacity(0.1)))),
          height: 24,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text("Notes..", style: widget.headerTextStyle),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: showIcon()
                      ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: _toggleExpanded,
                    icon: Icon(
                      _isExpanded
                          ? Icons.arrow_drop_down
                          : Icons.arrow_right,
                      color: widget.setType == SetType.completed
                          ? Colors.black
                          : Colors.white,
                      size: 15,
                    ),
                  )
                      : Container()),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          height: _isExpanded ? 50 : 0,
          // Adjust height for expanded/collapsed states
          child: _isExpanded
              ? SetNumericalField(
            value: widget.notes,
            setType: widget.setType,
            inputType: TextInputType.text,
            updateSetFunction: (notes) {
              BlocProvider.of<AddExerciseCubit>(context)
                  .updateCurrentSet(CurrentSet(notes: notes));
            },
          )
              : null,
        ),
      ],
    );
  }
}