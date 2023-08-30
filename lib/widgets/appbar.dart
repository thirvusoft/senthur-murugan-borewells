import 'package:flutter/material.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  const ReusableAppBar(
      {super.key, required this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle: true,
      elevation: 0,
      backgroundColor: const Color(0xFFF6F6F6),
      title: Text(title,
          style: const TextStyle(
              color: Color(0xFF752FFF),
              fontWeight: FontWeight.bold,
              letterSpacing: .3)),
      // actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}