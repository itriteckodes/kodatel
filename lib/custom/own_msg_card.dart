import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kodatel/constant.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class OwnMessageCard extends StatefulWidget {
  const OwnMessageCard(
      {Key? key, required this.msg, required this.time, required this.msgType})
      : super(key: key);
  final String msg;
  final String time;
  final String msgType;

  @override
  State<OwnMessageCard> createState() => _OwnMessageCardState();
}

class _OwnMessageCardState extends State<OwnMessageCard> {
  late VideoPlayerController controller;
  bool isPlaying = false;
  double value = 0.0;
  double max = 100;
  bool audioDownload = false;
  AudioPlayer audioPlayer = AudioPlayer();
  String path = '';

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.msg)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
          color: const Color(0xffdcf8c6),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 55, top: 5, bottom: 20),
              child: widget.msgType != 'image' &&
                      widget.msgType != 'video' &&
                      widget.msgType != 'document' &&
                      widget.msgType != 'contact' &&
                      widget.msgType != 'audio'
                  ? Text(
                      widget.msg,
                      style: const TextStyle(fontSize: 16),
                    )
                  : widget.msgType == 'image'
                      ? InkWell(
                          onTap: () {
                            openFile(url: widget.msg, filename: 'image.jpeg');
                            Fluttertoast.showToast(msg: 'Wait a While');
                          },
                          child: Image.network(
                            widget.msg,
                            fit: BoxFit.fill,
                            height: 200,
                            width: 300,
                          ),
                        )
                      : widget.msgType == 'video' &&
                              controller.value.isInitialized
                          ? SizedBox(
                              height: 200,
                              width: 300,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: VideoPlayer(controller),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        openFile(
                                            url: widget.msg,
                                            filename: 'vid.mp4');
                                        Fluttertoast.showToast(
                                            msg: 'Wait a While');
                                      },
                                      child: const CircleAvatar(
                                        radius: 33,
                                        backgroundColor: Colors.black38,
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : widget.msgType == 'document'
                              ? InkWell(
                                  onTap: () {
                                    openFile(
                                        url: widget.msg, filename: 'document');
                                    Fluttertoast.showToast(msg: 'Wait a While');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.document_scanner,
                                        size: padding * 3,
                                      ),
                                      Text(
                                        widget.msgType,
                                        style: const TextStyle(
                                            fontSize: fontSize * 1.2),
                                      ),
                                    ],
                                  ))
                              : widget.msgType == 'contact'
                                  ? InkWell(
                                      onTap: () {
                                        Contact contact = Contact(
                                            displayName:
                                                widget.msg.split('&').first,
                                            phones: [
                                              Item(
                                                  label: 'mobile',
                                                  value: widget.msg
                                                      .split('&')
                                                      .last)
                                            ]);

                                        ContactsService.addContact(contact)
                                            .then((value) async {
                                          List<Contact> contc =
                                              await ContactsService.getContacts(
                                                  query: widget.msg
                                                      .split('&')
                                                      .last);
                                          ContactsService.openExistingContact(
                                              contc[0]);
                                        });

                                        Fluttertoast.showToast(
                                            msg: 'Contact Saved Successfully');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.contact_page,
                                            size: padding * 3,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                widget.msg.split('&').first,
                                                style: const TextStyle(
                                                    fontWeight: bold,
                                                    fontSize: fontSize),
                                              ),
                                              Text(widget.msg.split('&').last)
                                            ],
                                          ),
                                        ],
                                      ))
                                  : widget.msgType == 'audio'
                                      ? Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 20,
                                                backgroundColor:
                                                    backgroundColor,
                                                child: IconButton(
                                                    onPressed: () async {
                                                      if (!isPlaying) {
                                                        if (path.isEmpty) {
                                                          path =
                                                              (await downloadFile(
                                                                      widget
                                                                          .msg,
                                                                      'a.mp3'))!
                                                                  .path;
                                                        }

                                                        setState(() {
                                                          isPlaying = true;
                                                        });
                                                        startPlaying(path);
                                                      } else {
                                                        setState(() {
                                                          isPlaying = false;
                                                        });

                                                        audioPlayer.pause();
                                                      }
                                                    },
                                                    icon: Icon(
                                                      path.isEmpty
                                                          ? Icons
                                                              .download_rounded
                                                          : isPlaying
                                                              ? Icons.pause
                                                              : Icons
                                                                  .play_arrow,
                                                      size: padding * 2.5,
                                                      color: Colors.white,
                                                    ))),
                                            Expanded(
                                              child: Slider(
                                                  activeColor: backgroundColor,
                                                  inactiveColor: Colors.grey,
                                                  min: 0,
                                                  max: max,
                                                  value: value,
                                                  onChanged: (change) {
                                                    audioPlayer.seek(Duration(
                                                        seconds:
                                                            change.toInt()));
                                                  }),
                                            ),
                                          ],
                                        )
                                      : const CircularProgressIndicator(),
            ),
            Positioned(
              bottom: 04,
              right: 10,
              child: Row(
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.done_all,
                    size: 20,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future openFile({required String url, required String? filename}) async {
    final file = await downloadFile(url, filename!);
    if (file == null) return;

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      setState(() {
        audioDownload = false;
      });
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<void> startPlaying(String path) async {
    audioPlayer.play(path, isLocal: true, volume: 100);
    audioPlayer.onDurationChanged.listen((Duration duration) {
      max = (duration.inSeconds).toDouble();
    });

    audioPlayer.onAudioPositionChanged.listen((event) async {
      setState(() {
        value = event.inSeconds.toDouble();
      });
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      stopPlaying();
    });
  }

  Future<void> stopPlaying() async {
    audioPlayer.stop();
    setState(() {
      isPlaying = false;
      value = 0.0;
    });
  }
}
