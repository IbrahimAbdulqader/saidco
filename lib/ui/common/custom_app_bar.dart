import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, this.title = 'None'});

  final String title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 120),
        child: Padding(
          padding: const EdgeInsets.only(top: 25, right: 10),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
