import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  const TimerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),),
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Time the Set", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 12
          ),),
          Icon(Icons.timer_outlined)
        ],
      ),
    );
  }
}
