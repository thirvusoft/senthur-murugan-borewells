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
      backgroundColor: (title == "Senthur Murugan")
          ? const Color(0xFF752FFF)
          : const Color(0xFFFFFFFF),
      leading: leading,
      elevation: 0,
      automaticallyImplyLeading: false,

      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: .3,
              color: Color(0xFF000000))),
      // actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
