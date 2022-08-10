import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class DrawerListTile extends StatefulWidget {
  final String title;
  final IconData source;
  final VoidCallback press;
  const DrawerListTile({
    Key? key,
    required this.press,
    required this.title,
    required this.source,
  }) : super(key: key);

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        widget.source,
        color: backgroundColor,
      ),
      title: Text(
        widget.title,
        style: const TextStyle(color: black, fontWeight: bold),
      ),
    );
  }
}
