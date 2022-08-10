import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/model/user_model.dart';
import 'package:kodatel/pages/chats/individual_chat.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:kodatel/providers/user_details.dart';
import 'package:provider/provider.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({Key? key}) : super(key: key);

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  final search = TextEditingController();
  late List<Users> users;
  List<Users> perm = [];
  bool isUserInit = false;
  @override
  void initState() {
    super.initState();
    inItUsersList();
  }

  void inItUsersList() {
    setState(() {
      users = Provider.of<UserDetails>(context, listen: false).getUsers();
      perm.addAll(users);
      isUserInit = true;
    });
    log(users.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: black,
            size: 20,
          ),
        ),
        backgroundColor: widgetColor,
        centerTitle: true,
        title: const Text(
          "Select Contact",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
              width: width(context),
              color: widgetColor,
              child: seacrhTextForm()),
          const SizedBox(
            height: padding,
          ),
          Expanded(
            child: isUserInit
                ? ListView.builder(
                    itemCount: users.length,
                    itemBuilder: ((context, index) {
                      if (users[index].phone !=
                          Provider.of<AuthProvider>(context, listen: false)
                              .prefs
                              .getString('phone')) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: widgetColor,
                                radius: 25,
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 35,
                                  color: backgroundColor,
                                ),
                              ),
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      users[index].name!,
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: fontSize + 2,
                                          fontWeight: bold),
                                    ),
                                    Text(
                                      "📱" + users[index].phone!,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: fontSize),
                                    ),
                                  ]),
                              onTap: () async {
                                String chatId = await Provider.of<ChatProvider>(
                                        context,
                                        listen: false)
                                    .resolveId(
                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .prefs
                                            .getString('phone')!,
                                        users[index].phone!);
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (_) => IndividualPage(
                                              chatWith: users[index].phone!,
                                              chatId: chatId,
                                            )));
                              },
                            ),
                            const Divider(),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }))
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget seacrhTextForm() {
    return Center(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.circular(padding + 10)),
        margin:
            const EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        width: width(context) - 60,
        child: TextFormField(
          controller: search,
          onChanged: (value) {
            if (value.trim().isNotEmpty) {
              filterSearchResults(value);
            } else {
              users.clear();
              setState(() {
                users.addAll(perm);
              });
            }
          },
          decoration: const InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(padding + 20)),
                  borderSide: BorderSide(
                    color: backgroundColor,
                  )),
              prefixIcon: Icon(
                Icons.search,
                color: backgroundColor,
              )),
        ),
      ),
    );
  }

  void filterSearchResults(String query) {
    if (query.trim().isNotEmpty) {
      List<Users> dummyListData = [];
      for (var item in users) {
        if (item.name!.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        users.clear();
        users.addAll(dummyListData);
      });
      return;
    }
  }
}
