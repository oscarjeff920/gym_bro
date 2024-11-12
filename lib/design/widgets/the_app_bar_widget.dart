import 'package:flutter/material.dart';

class TheAppBar extends StatelessWidget implements PreferredSizeWidget {
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
      backgroundColor: const Color.fromRGBO(7, 99, 133, 1.0),
      iconTheme:
          hasBackButton ? const IconThemeData(color: Colors.white) : null,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/settings-page");
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
