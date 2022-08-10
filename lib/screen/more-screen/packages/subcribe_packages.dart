import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/screen/more-screen/packages/confir_subcribe.dart';

class SubcribePackaes extends StatelessWidget {
  const SubcribePackaes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        title: Row(
          children: const [
            Icon(
              Icons.subscriptions,
              size: 30,
            ),
            SizedBox(
              width: padding,
            ),
            Text("Subcribe Packages"),
          ],
        ),
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: foregroundColor,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('packages').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: ((context, index) {
                    return Card(
                      margin: const EdgeInsets.all(padding),
                      child: Padding(
                        padding: const EdgeInsets.all(padding),
                        child: ListTile(
                          title: Text(
                            snapshot.data!.docs[index].get('title'),
                            style: const TextStyle(fontWeight: bold),
                          ),
                          subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: padding * 0.5,
                                ),
                                Text(
                                    'Validity: ${snapshot.data!.docs[index].get('validity')}'),
                                const SizedBox(
                                  height: padding * 0.5,
                                ),
                                Text(
                                  'Max Minutes: ${snapshot.data!.docs[index].get('mints')}',
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ]),
                          trailing: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1, color: backgroundColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                  color: Colors.green,
                                  size: padding * 2,
                                ),
                                Text(snapshot.data!.docs[index].get('price')),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ConfirSubcrice(
                                        title: snapshot.data!.docs[index]
                                            .get('title'),
                                        price: snapshot.data!.docs[index]
                                            .get('price'),
                                        validity: snapshot.data!.docs[index]
                                            .get('validity'),
                                        mints: snapshot.data!.docs[index]
                                            .get('mints'))));
                            
                          },
                        ),
                      ),
                    );
                  }));
            } else {
              return const Center(
                child: Text('No Package Available yet'),
              );
            }
          })),
    );
  }
}
