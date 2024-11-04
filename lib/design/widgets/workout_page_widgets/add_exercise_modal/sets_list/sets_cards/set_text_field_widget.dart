import 'package:flutter/material.dart';

import 'general_set_container_widget.dart';

class SetTextField extends StatefulWidget {
  final SetType setType;

  const SetTextField({super.key, required this.setType});

  Color get activeColour =>
      setType == SetType.completed ? Colors.black : Colors.white;

  @override
  State<SetTextField> createState() => _SetTextFieldState();
}

class _SetTextFieldState extends State<SetTextField> {
  // bool isReadOnly = widget.isReadOnly;

  // _makeEditable() {
  //   isReadOnly = true;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: const Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text('data'),
                    TextField(),
                  ],
                ),
                
              ],
            ),
          ],
        ));
  }
}
