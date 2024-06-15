import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/state_management/cubits/add_new_movement_cubit/add_new_movement_cubit.dart';

class AddNewMovementNameHeaderWidget extends StatelessWidget {
  const AddNewMovementNameHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Text(
        "Exercise Name:",
        style: TextStyle(
          fontSize: 10,
          color: Color.fromRGBO(10, 10, 10, .6),
        ),
      ),
    );
  }
}

class AddNewMovementNameTextField extends StatelessWidget {
  const AddNewMovementNameTextField({super.key, required this.newMovementName});

  final String? newMovementName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35,
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          controller: TextEditingController()..text = newMovementName ?? "",
          decoration: const InputDecoration(
              prefix: SizedBox(
            width: 10,
          )),
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
          onSubmitted: (String inputText) {
            BlocProvider.of<AddNewMovementCubit>(context)
                .typeMovementName(inputText.trim());
          },
        ));
  }
}
