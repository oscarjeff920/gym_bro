import 'package:flutter/material.dart';

class TheAppBar extends StatelessWidget implements PreferredSizeWidget {

  const TheAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed("/");
        },
        child: const Text(
          "Gym Brooo",
          style: TextStyle(color: Colors.white),
        ),
      ),
      elevation: 20,
      backgroundColor: const Color.fromRGBO(7, 99, 133, 1.0),
      iconTheme: null,
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
