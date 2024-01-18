import 'package:flutter/material.dart';

class TheAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool hasBackButton;

  const TheAppBar({
    super.key,
    this.hasBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Gym Brooo",
        style: TextStyle(color: Colors.white),
      ),
      elevation: 20,
      backgroundColor: const Color.fromRGBO(230, 120, 50, 1),
      iconTheme: hasBackButton ? const IconThemeData() : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
