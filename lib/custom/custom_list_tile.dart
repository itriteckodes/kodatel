import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key, required this.title, required this.icon, required this.tralig})
      : super(key: key);
  final String title;
  final IconData icon;
  final Icon tralig;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: width(context),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.black,
            ),
            title: Text(title,
                style: const TextStyle(
                  color: Colors.black,
                )),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 15,
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
