import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/own_msg_card.dart';
import 'package:kodatel/custom/reply_msg_card.dart';
import 'package:kodatel/model/msg_model.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:kodatel/screen/camera_screen.dart';
import 'package:kodatel/screen/camera_view.dart';
import 'package:marquee/marquee.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:intl/intl.dart' show DateFormat;
import 'package:record/record.dart';

class IndividualPage extends StatefulWidget {
  const IndividualPage({Key? key, required this.chatWith, required this.chatId})
      : super(key: key);
  final String chatWith;
  final String chatId;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  bool keyboardShow = false;
  Timer? timer;
  bool sendButton = false;
  List<MessageModel> msgs = [];
  late ScrollController _scrollController;
  late ImagePicker _imagePicker;
  bool hasMasgs = false;
  final record = Record();
  XFile? image;
  int popTime = 0;

  final audioPlayer = AssetsAudioPlayer();
  String? filePath;
  bool play = false;
  String recorderTxt = '00:00:00';

  @override
  void initState() {
    _scrollController = ScrollController();
    _imagePicker = ImagePicker();

    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          keyboardShow = false;
        }
      });
    });
    super.initState();
  }

  void sendMsg(String msg, String sourceID, String targetID, String path,
      String msgType, BuildContext context) {
    setMsg("source", msg, path, msgType);
    Provider.of<ChatProvider>(context, listen: false).sendMessage(msg, sourceID,
        targetID, DateTime.now().toString().substring(10, 16), msgType);
    setState(() {});
  }

  void setMsg(String type, String msg, String path, String msgType) {
    MessageModel msgmodel = MessageModel(
        type: type,
        msg: msg,
        path: path,
        msgType: msgType,
        time: DateTime.now().toString().substring(10, 16));
    setState(() {
      if (hasMasgs == false) {
        hasMasgs = true;
      }
      msgs.add(msgmodel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: InkWell(
          onTap: (() {}),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatWith,
                  style: const TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  width: 180,
                  height: 30,
                  child: Marquee(
                    text: "last seen today at 9:00 pm",
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 70.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                )
              ]),
        ),
        leadingWidth: 70,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const CircleAvatar(
              radius: 20,
              backgroundColor: foregroundColor,
              child: Icon(
                Icons.person,
                color: backgroundColor,
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    child: Text("Search"),
                    value: "Search",
                  ),
                  const PopupMenuItem(
                    child: Text("Clear chat"),
                    value: "Clear chat",
                  ),
                ];
              }),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          onWillPop: () {
            if (keyboardShow) {
              setState(() {
                keyboardShow = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
          child: Column(children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    Provider.of<ChatProvider>(context).gettMsgs(widget.chatId),
                builder: (_, snaps) {
                  if (snaps.hasData) {
                    msgs.clear();
                    for (var item in snaps.data!.docs) {
                      if (item.get('idFrom') ==
                          Provider.of<AuthProvider>(context, listen: false)
                              .prefs
                              .getString('phone')) {
                        msgs.add(MessageModel(
                            msg: item.get('msg'),
                            time: item.get('time'),
                            msgType: item.get('msgType'),
                            type: 'source'));
                      } else {
                        msgs.add(MessageModel(
                            msg: item.get('msg'),
                            time: item.get('time'),
                            msgType: item.get('msgType'),
                            type: 'other'));
                      }
                    }
                    return ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: msgs.length,
                        itemBuilder: ((context, index) {
                          if (msgs[index].type == "source") {
                            return OwnMessageCard(
                                msg: msgs[index].msg!,
                                msgType: msgs[index].msgType!,
                                time: (msgs[index].time!));
                          } else {
                            return ReplyCard(
                                msg: msgs[index].msg!,
                                msgType: msgs[index].msgType!,
                                time: (msgs[index].time!));
                          }
                        }));
                  } else {
                    return ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          return Container();
                        }));
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 55,
                            child: Card(
                                clipBehavior: Clip.hardEdge,
                                margin: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  focusNode: _focusNode,
                                  controller: _textEditingController,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.all(padding),
                                      hintText: "Message",
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            hoverColor: Colors.grey,
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          bottomSheet());
                                            },
                                            icon: const Icon(Icons.attach_file),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                popTime = 3;
                                              });
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CameraScreen(
                                                            sourceId: Provider.of<
                                                                        ChatProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .prefs
                                                                .getString(
                                                                    'phone')!,
                                                            chatWith:
                                                                widget.chatWith,
                                                          )));
                                            },
                                            icon: const Icon(Icons.camera_alt),
                                          ),
                                        ],
                                      )),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: backgroundColor,
                            child: sendButton
                                ? IconButton(
                                    onPressed: () async {
                                      if (sendButton) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                    .position.maxScrollExtent +
                                                200.0,
                                            duration: const Duration(
                                                microseconds: 300),
                                            curve: Curves.easeOut);

                                        sendMsg(
                                            _textEditingController.text,
                                            Provider.of<ChatProvider>(context,
                                                    listen: false)
                                                .prefs
                                                .getString('phone')!,
                                            widget.chatWith,
                                            "",
                                            'text',
                                            context);
                                        _textEditingController.clear();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: foregroundColor,
                                    ))
                                : GestureDetector(
                                    onTapDown: (t) {
                                      startRecording();
                                      timer = Timer.periodic(
                                          const Duration(milliseconds: 1),
                                          (timer) {
                                        var date =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                timer.tick,
                                                isUtc: true);
                                        var txt =
                                            DateFormat('mm:ss:SS').format(date);

                                        setState(() {
                                          _textEditingController.text =
                                              txt.substring(0, 8);
                                        });
                                      });
                                    },
                                    onTapUp: (t) async {
                                      timer?.cancel();
                                      setState(() {
                                        _textEditingController.clear();
                                      });
                                      stopRecord();
                                      if (filePath!.isNotEmpty) {
                                        log(filePath!);
                                        String? path =
                                            await Provider.of<ChatProvider>(
                                                    context,
                                                    listen: false)
                                                .uploadToStorage(
                                                    File(filePath!), 'audio');
                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .sendMessage(
                                                path!,
                                                Provider.of<ChatProvider>(
                                                        context,
                                                        listen: false)
                                                    .prefs
                                                    .getString('phone')!,
                                                widget.chatWith,
                                                DateTime.now()
                                                    .toString()
                                                    .substring(10, 16),
                                                'audio');
                                      }
                                    },
                                    child: const Icon(
                                      Icons.mic,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return SizedBox(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreate(Icons.insert_drive_file, Colors.indigo, "Document",
                    () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'pptx', 'apk'],
                  );
                  if (result != null) {
                    PlatformFile file = result.files.first;
                    log(file.name);
                    String? path =
                        await Provider.of<ChatProvider>(context, listen: false)
                            .uploadToStorage(File(file.path!), 'document');
                    Provider.of<ChatProvider>(context, listen: false)
                        .sendMessage(
                            path!,
                            Provider.of<ChatProvider>(context, listen: false)
                                .prefs
                                .getString('phone')!,
                            widget.chatWith,
                            DateTime.now().toString().substring(10, 16),
                            'document');
                    Navigator.pop(context);
                  }
                }),
                const SizedBox(
                  width: 40,
                ),
                iconCreate(Icons.camera_alt, Colors.pink, "Camera", () {
                  setState(() {
                    popTime = 2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CameraScreen(
                                sourceId: Provider.of<ChatProvider>(context,
                                        listen: false)
                                    .prefs
                                    .getString('phone')!,
                                chatWith: widget.chatWith,
                              )));
                }),
                const SizedBox(
                  width: 40,
                ),
                iconCreate(Icons.photo, Colors.purple, "Gallery", () async {
                  setState(() {
                    popTime = 2;
                  });
                  image =
                      await _imagePicker.pickImage(source: ImageSource.gallery);
                  if (image!.path.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraViewPage(
                                  isVideo: false,
                                  path: image!.path,
                                  sourceId: Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .prefs
                                      .getString('phone')!,
                                  chatWith: widget.chatWith,
                                )));
                  }
                }),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconCreate(Icons.headset, Colors.orange, "Audio", () {}),
                const SizedBox(
                  width: 40,
                ),
                iconCreate(Icons.location_pin, Colors.teal, "Location", () {}),
                const SizedBox(
                  width: 40,
                ),
                iconCreate(
                  Icons.person,
                  Colors.blue,
                  "Contact",
                  () async {
                    Contact? contact =
                        await ContactsService.openDeviceContactPicker();
                    if (contact != null) {
                      log(contact.phones![0].label!);
                      String msg = contact.displayName! +
                          '&' +
                          contact.phones![0].value!;
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendMessage(
                              msg,
                              Provider.of<ChatProvider>(context, listen: false)
                                  .prefs
                                  .getString('phone')!,
                              widget.chatWith,
                              DateTime.now().toString().substring(10, 16),
                              'contact');
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget iconCreate(
      IconData icon, Color color, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: color,
              radius: 30,
              child: Icon(
                icon,
                size: 29,
                color: Colors.white,
              )),
          const SizedBox(
            height: 05,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  Future<void> startRecording() async {
    startIt();
    Directory dir = Directory(filePath!);

    if (!await dir.exists()) {
      dir.create();
    }
    var recording =
        DateTime.fromMillisecondsSinceEpoch(1000).microsecondsSinceEpoch;
    filePath = filePath! + recording.toString() + '.m4a';

// Check and request permission
    bool result = await record.hasPermission();
    if (result) {
      await record.start(
        path: filePath,
        encoder: AudioEncoder.AAC,
      );
    } else {
      await Permission.microphone.request();
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
  }

  void startIt() async {
    Directory dir = await getApplicationDocumentsDirectory();
    filePath = dir.path + '/Recording/';
  }

  Future<String?> stopRecord() async {
    return await record.stop();
  }

  Future<void> startPlaying() async {
    audioPlayer.open(
      Audio.file(filePath!),
      autoStart: true,
      showNotification: true,
    );
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
  }
}
