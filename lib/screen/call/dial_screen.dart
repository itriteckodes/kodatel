import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class DialScreen extends StatefulWidget {
  const DialScreen({
    Key? key,
    this.flag,
    this.name,
    this.num,
    this.countryName,
  }) : super(key: key);
  final String? flag;
  final String? name;
  final String? num;
  final String? countryName;

  @override
  State<DialScreen> createState() => _DialScreenState();
}

class _DialScreenState extends State<DialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: padding - 5, vertical: padding * 3),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              widget.countryName != null && widget.flag != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: padding * 2,
                          child: Image.asset(
                            widget.flag!,
                            package: 'country_list_pick',
                          ),
                        ),
                        const SizedBox(
                          width: padding - 5,
                        ),
                        Text(
                          widget.countryName!.toUpperCase(),
                        )
                      ],
                    )
                  : Container(),
              const SizedBox(
                height: padding * 2,
              ),
              callerInfo()
            ]),
      ),
    );
  }

  Widget callerInfo() {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            backgroundColor: widgetColor,
            radius: 50,
            child: Icon(
              Icons.person_rounded,
              size: 80,
            ),
          ),
          const SizedBox(
            height: padding,
          ),
          widget.name != null
              ? Text(
                  widget.name!,
                  style: const TextStyle(fontSize: fontSize),
                )
              : Container(),
          const SizedBox(
            height: padding,
          ),
          Text(
            widget.num!,
            style: const TextStyle(fontWeight: bold, fontSize: fontSize * 1.2),
          ),
          const SizedBox(
            height: padding,
          ),
          dots(),
          const SizedBox(
            height: padding,
          ),
          buttons(),
        ],
      ),
    );
  }

  Widget dots() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircleAvatar(
          radius: 3,
          backgroundColor: backgroundColor,
        ),
        SizedBox(
          height: padding - 5,
        ),
        CircleAvatar(
          radius: 4,
          backgroundColor: backgroundColor,
        ),
        SizedBox(
          height: padding - 5,
        ),
        CircleAvatar(
          radius: 6,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }

  Widget buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 35,
                      spreadRadius: 1,
                      offset: Offset(1, 1))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: backgroundColor,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.mic_fill,
                          size: 30,
                          color: foregroundColor,
                        )),
                  ),
                  const SizedBox(
                    height: padding,
                  ),
                  const Text(
                    "Mute",
                    style: TextStyle(fontSize: fontSize),
                  )
                ],
              ),
            ),
            buttonWithText("Keypad", CupertinoIcons.square_grid_4x3_fill),
            buttonWithText("Speaker", CupertinoIcons.speaker_3_fill),
          ],
        ),
        const SizedBox(
          height: padding * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonWithText("Contact", Icons.contact_phone),
            buttonWithText("Message", CupertinoIcons.chat_bubble_fill),
          ],
        ),
        const SizedBox(
          height: padding * 2,
        ),
        Container(
          width: 150,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(padding * 3),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 35,
                    spreadRadius: 1,
                    offset: Offset(1, 1))
              ]),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
                color: foregroundColor,
                size: 30,
              )),
        ),
      ],
    );
  }

  Widget buttonWithText(String text, IconData icon) {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 35,
                spreadRadius: 0.5,
                offset: Offset(1, 1))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: backgroundColor,
                child: Icon(
                  icon,
                  size: 30,
                  color: foregroundColor,
                )),
            const SizedBox(
              height: padding,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: fontSize),
            )
          ],
        ));
  }
}
