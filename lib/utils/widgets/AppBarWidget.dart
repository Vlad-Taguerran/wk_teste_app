import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      centerTitle: true,
      elevation: 1,
      backgroundColor: Colors.red,
    );
  }

  @override
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
