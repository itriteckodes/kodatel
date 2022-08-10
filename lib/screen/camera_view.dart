import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/pages/chats/individual_chat.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/providers.dart';

class CameraViewPage extends StatefulWidget {
  const CameraViewPage({
    Key? key,
    required this.path,
    required this.isVideo,
    required this.sourceId,
    required this.chatWith,
  }) : super(key: key);
  final String path;
  final bool isVideo;
  final String sourceId;
  final String chatWith;

  @override
  State<CameraViewPage> createState() => _CameraViewPageState();
}

class _CameraViewPageState extends State<CameraViewPage> {
  late VideoPlayerController _controller;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.file(File(widget.path))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isVideo) _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          widget.isVideo
              ? _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Container()
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.file(File(widget.path), fit: BoxFit.cover),
                ),
          Positioned(
            bottom: 1.5,
            right: 1.5,
            child: InkWell(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                String chatId =
                    await Provider.of<ChatProvider>(context, listen: false)
                        .resolveId(
                            Provider.of<ChatProvider>(context, listen: false)
                                .prefs
                                .getString('phone')!,
                            widget.chatWith);

                if (widget.path.split('.').last == 'mp4') {
                  String? vidPath =
                      await Provider.of<ChatProvider>(context, listen: false)
                          .uploadToStorage(File(widget.path), 'video');
                  Provider.of<ChatProvider>(context, listen: false).sendMessage(
                      vidPath!,
                      widget.sourceId,
                      widget.chatWith,
                      DateTime.now().toString().substring(10, 16),
                      'video');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => IndividualPage(
                              chatWith: widget.chatWith, chatId: chatId)),
                      (route) => false);
                } else {
                  String? imgPath =
                      await Provider.of<ChatProvider>(context, listen: false)
                          .uploadToStorage(File(widget.path), 'image');
                  Provider.of<ChatProvider>(context, listen: false).sendMessage(
                      imgPath!,
                      widget.sourceId,
                      widget.chatWith,
                      DateTime.now().toString().substring(10, 16),
                      'image');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => IndividualPage(
                              chatWith: widget.chatWith, chatId: chatId)),
                      (route) => false);
                }
              },
              child: CircleAvatar(
                radius: 27,
                backgroundColor: backgroundColor,
                child: loading == false
                    ? const Icon(
                        Icons.check,
                        size: 27,
                        color: Colors.white,
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          widget.isVideo
              ? Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: CircleAvatar(
                      radius: 33,
                      backgroundColor: Colors.black38,
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    );
  }
}
