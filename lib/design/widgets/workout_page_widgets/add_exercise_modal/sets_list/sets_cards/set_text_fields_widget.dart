import 'package:flutter/material.dart';

class SetTextFieldsWidget extends StatefulWidget {

  const SetTextFieldsWidget({super.key});

  @override
  State<SetTextFieldsWidget> createState() => _SetTextFieldsWidgetState();
}

class _SetTextFieldsWidgetState extends State<SetTextFieldsWidget> {
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
