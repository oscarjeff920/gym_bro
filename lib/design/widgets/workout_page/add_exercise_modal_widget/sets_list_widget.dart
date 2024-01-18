import 'package:flutter/material.dart';

class SetsList extends StatelessWidget {
  const SetsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: Container(
          color: Colors.green,
          child: ListView(
            children: const [],
          ),
        ));
  }
}