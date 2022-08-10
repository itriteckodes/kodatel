import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/pages/contact/all_contact.dart';
import 'package:kodatel/screen/call/keyboard_screen.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  final search = TextEditingController();
  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const KeyBoradScreen()));
          }),
          child: const Icon(
            CupertinoIcons.square_grid_3x2_fill,
            color: foregroundColor,
          )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        seacrhTextForm(),
        Container(
          height: 30,
          width: width(context),
          decoration: const BoxDecoration(color: widgetColor),
          child: TabBar(
            controller: tabcontroller,
            indicatorColor: backgroundColor,
            isScrollable: false,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(fontSize: fontSize),
            indicator: const BoxDecoration(color: backgroundColor),
            tabs: const [
              Tab(
                text: "All Contacts",
              ),
              Tab(
                text: "MeriCall Contacts",
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabcontroller,
            children: const [
              AllContacts(),
              Text("Mericall Contacts"),
            ],
          ),
        ),
      ]),
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
