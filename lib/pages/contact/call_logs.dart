import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:marquee/marquee.dart';

class CallLogs extends StatefulWidget {
  const CallLogs({Key? key}) : super(key: key);

  @override
  _CallLogsState createState() => _CallLogsState();
}

class _CallLogsState extends State<CallLogs> {
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: (() {}),
          child: const Icon(
            CupertinoIcons.square_grid_3x2_fill,
            color: foregroundColor,
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        seacrhTextForm(),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () async {},
            child: const Padding(
              padding: EdgeInsets.all(padding),
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                radius: 20,
                child: Icon(
                  Icons.delete_forever_rounded,
                  size: 20,
                  color: foregroundColor,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (_, i) => ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: backgroundColor,
                        radius: 20,
                        child: Icon(
                          Icons.delete_forever_rounded,
                          size: 20,
                          color: foregroundColor,
                        ),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: width(context) * 0.35,
                                height: 20,
                                child: Marquee(
                                  text: 'Person 1',
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  velocity: 50.0,
                                  pauseAfterRound: const Duration(minutes: 3),
                                  startPadding: 0.0,
                                  accelerationCurve: Curves.linear,
                                  blankSpace: 100,
                                ),
                              ),
                              const Text(
                                "(2)",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: backgroundColor,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          const Text("01:15 pm"),
                        ],
                      ),
                      trailing: SizedBox(
                          width: width(context) * 0.3, child: history()),
                    ))),
      ]),
    );
  }

  Widget history() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () {},
            padding: const EdgeInsets.only(left: 5),
            constraints: const BoxConstraints(maxWidth: 25),
            icon: const Icon(
              Icons.call,
              size: 25,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {},
            padding: const EdgeInsets.only(left: 5),
            constraints: const BoxConstraints(maxWidth: 25),
            icon: const Icon(
              Icons.chat_rounded,
              size: 25,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {},
            constraints: const BoxConstraints(
              maxWidth: 25,
            ),
            padding: const EdgeInsets.only(left: 5),
            icon: const Icon(
              Icons.videocam,
              size: 30,
              color: Colors.green,
            )),
        IconButton(
            onPressed: () {},
            constraints: const BoxConstraints(maxWidth: 25),
            icon: const Icon(
              Icons.info_outline,
              size: 25,
              color: Colors.grey,
            )),
      ],
    );
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
