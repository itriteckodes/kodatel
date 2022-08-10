import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/constant/firestore_constants.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: padding,
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(Provider.of<AuthProvider>(context)
                .prefs
                .getString(FirestoreConstants.profileUrl)!),
            backgroundColor: widgetColor,
            radius: 35,
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              Provider.of<AuthProvider>(context)
                  .prefs
                  .getString(FirestoreConstants.name)!,
              style: const TextStyle(
                  color: black, fontSize: fontSize + 2, fontWeight: bold),
            ),
            Text(
              "📱 ${Provider.of<AuthProvider>(context).prefs.getString(FirestoreConstants.phone)!}",
              style: const TextStyle(color: Colors.grey, fontSize: fontSize),
            ),
          ]),
          trailing: Column(children: [
            const Text(
              "Registered",
              style: TextStyle(color: Colors.green, fontSize: fontSize),
            ),
            IconButton(
                onPressed: () {},
                constraints: const BoxConstraints(maxHeight: 20),
                icon: const Icon(
                  Icons.edit,
                  color: black,
                ))
          ]),
        ),
        const SizedBox(
          height: padding,
        ),
        Container(
          width: width(context),
          height: 30,
          color: widgetColor,
          child: Center(
            child: Text(
              Provider.of<AuthProvider>(context)
                  .prefs
                  .getString(FirestoreConstants.status)!,
              style: const TextStyle(
                  color: black, fontSize: fontSize, fontWeight: bold),
            ),
          ),
        ),
        const Expanded(child: Center(child: Text("Subcribed Packages")))
      ],
    );
  }
}
