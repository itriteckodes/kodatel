import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class ShowAddedRTC extends StatefulWidget {
  const ShowAddedRTC({Key? key, required this.prefix}) : super(key: key);
  final String prefix;
  @override
  State<ShowAddedRTC> createState() => _ShowAddedRTCState();
}

class _ShowAddedRTCState extends State<ShowAddedRTC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text("Internaltion Call Rates"),
      ),
      body: Column(
        children: [
          Container(
            height: 55,
            padding:
                const EdgeInsets.symmetric(horizontal: padding, vertical: 5),
            margin: const EdgeInsets.all(padding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: backgroundColor,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Prefix',
                  style: TextStyle(fontSize: 12),
                ),
                VerticalDivider(
                  color: backgroundColor,
                ),
                Text(
                  'Call Rate',
                  style: TextStyle(fontSize: 12),
                ),
                VerticalDivider(
                  color: backgroundColor,
                ),
                Text(
                  'Connection fee\nApplies',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('icr')
                    .where('prefix', isEqualTo: widget.prefix)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: ((context, index) {
                          return Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: padding * 3, vertical: padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!.docs[index].get('prefix'),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!.docs[index].get('rate'),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    snapshot.data!.docs[index]
                                        .get('fee')
                                        .toString()
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }));
                  } else {
                    return const Center(
                      child: Text('No Rates Available yet'),
                    );
                  }
                })),
          ),
        ],
      ),
    );
  }
}
