import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

import 'package:kodatel/pages/chats/individual_chat.dart';
import 'package:kodatel/pages/chats/select_contact.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final search = TextEditingController();
  String chatId = 'ChatID';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SelectContact()));
            }),
            child: const Icon(
              Icons.add_comment_rounded,
              size: 30,
              color: foregroundColor,
            )),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          seacrhTextForm(),
          Expanded(
              child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('messages').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    height: padding * 2,
                    width: padding * 3,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        if (Provider.of<ChatProvider>(context)
                                    .prefs
                                    .getString('phone') ==
                                snapshot.data!.docs
                                    .elementAt(index)
                                    .id
                                    .split('&')
                                    .first ||
                            Provider.of<ChatProvider>(context)
                                    .prefs
                                    .getString('phone') ==
                                snapshot.data!.docs
                                    .elementAt(index)
                                    .id
                                    .split('&')
                                    .last) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: widgetColor,
                              radius: 30,
                              child: Icon(
                                Icons.person_rounded,
                                size: 35,
                                color: backgroundColor,
                              ),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Provider.of<ChatProvider>(context)
                                              .prefs
                                              .getString('phone') ==
                                          snapshot.data!.docs
                                              .elementAt(index)
                                              .id
                                              .split('&')
                                              .first
                                      ? snapshot.data!.docs
                                          .elementAt(index)
                                          .id
                                          .split('&')
                                          .last
                                      : snapshot.data!.docs
                                          .elementAt(index)
                                          .id
                                          .split('&')
                                          .first,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                    stream: Provider.of<ChatProvider>(context,
                                            listen: false)
                                        .firebaseFirestore
                                        .collection('messages')
                                        .doc(snapshot.data!.docs
                                            .elementAt(index)
                                            .id)
                                        .snapshots(),
                                    builder: (context, data) {
                                      if (data.hasData) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        IndividualPage(
                                                          chatWith: Provider.of<
                                                                              ChatProvider>(
                                                                          context)
                                                                      .prefs
                                                                      .getString(
                                                                          'phone') ==
                                                                  snapshot.data!
                                                                      .docs
                                                                      .elementAt(
                                                                          index)
                                                                      .id
                                                                      .split(
                                                                          '&')
                                                                      .first
                                                              ? snapshot
                                                                  .data!.docs
                                                                  .elementAt(
                                                                      index)
                                                                  .id
                                                                  .split('&')
                                                                  .last
                                                              : snapshot
                                                                  .data!.docs
                                                                  .elementAt(
                                                                      index)
                                                                  .id
                                                                  .split('&')
                                                                  .first,
                                                          chatId: data.data!.id,
                                                        )));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: width(context) * 0.5,
                                                height: 20,
                                                child: data.data!
                                                            .get('lastMsg')
                                                            .toString()
                                                            .length >
                                                        30
                                                    ? Marquee(
                                                        text: data.data!
                                                            .get('lastMsg'),
                                                        scrollAxis:
                                                            Axis.horizontal,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        velocity: 30.0,
                                                        pauseAfterRound:
                                                            const Duration(
                                                                minutes: 1),
                                                        accelerationCurve:
                                                            Curves.linear,
                                                        blankSpace: 180,
                                                      )
                                                    : Text(data.data!
                                                        .get('lastMsg')),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                data.data!
                                                    .get('time')
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          );
                        } else {
                          return Container();
                        }
                      });
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          )),
        ]));
  }

  Widget seacrhTextForm() {
    return Center(
      child: Container(
        height: 45,
        margin:
            const EdgeInsets.symmetric(horizontal: padding, vertical: padding),
        width: width(context) - 60,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "Cant't be empty";
            }
            return null;
          },
          controller: search,
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
}
   // stream:
                              //     Provider.of<ChatProvider>(context).gettMsgs(
                              //   context
                              //       .watch<ChatProvider>()
                              //       .prefs
                              //       .getString('phone')!,
                              //   Provider.of<ChatProvider>(context)
                              //               .prefs
                              //               .getString('phone') ==
                              //           snapshot.data!.docs
                              //               .elementAt(index)
                              //               .id
                              //               .split('&')
                              //               .first
                              //       ? snapshot.data!.docs
                              //           .elementAt(index)
                              //           .id
                              //           .split('&')
                              //           .last
                              //       : snapshot.data!.docs
                              //           .elementAt(index)
                              //           .id
                              //           .split('&')
                              //           .first,
                              // ),