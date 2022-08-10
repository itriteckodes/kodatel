import 'package:flutter/material.dart';
import 'package:kodatel/components/drawer_handler.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/pages/contact/call_logs.dart';
import 'package:kodatel/pages/contact_page.dart';
import 'package:kodatel/screen/chat_screen.dart';
import 'package:kodatel/screen/more-screen/transfer_balance.dart';
import 'package:kodatel/screen/more_settings.dart';
import 'package:kodatel/screen/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  @override
  void initState() {
    tabcontroller = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHandler(),
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          "MeriCall",
          style: TextStyle(
            color: foregroundColor,
            fontSize: 20,
            fontWeight: bold,
          ),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(padding - 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.attach_money_sharp,
                        color: foregroundColor,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TransferBalance()));
                          },
                          child: const Text(
                            "Send Mobile Top-Up",
                            style:
                                TextStyle(color: foregroundColor, fontSize: 9),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MoreSettings()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(padding - 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.settings,
                        color: foregroundColor,
                      ),
                      Text(
                        "More Settings",
                        style: TextStyle(color: foregroundColor, fontSize: 9),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: TabBarView(
        controller: tabcontroller,
        children: const [
          ContactPage(),
          CallLogs(),
          ChatScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 45,
        width: width(context),
        decoration:
            const BoxDecoration(color: Color.fromARGB(60, 175, 175, 175)),
        child: TabBar(
          controller: tabcontroller,
          indicatorColor: backgroundColor,
          unselectedLabelColor: Colors.black,
          labelStyle: const TextStyle(fontSize: 12),
          indicator: const BoxDecoration(color: backgroundColor),
          tabs: const [
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              icon: Icon(Icons.contact_phone_rounded),
              text: "Contacts",
            ),
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              icon: Icon(Icons.restore),
              text: "Call Logs",
            ),
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              icon: Icon(Icons.chat_rounded),
              text: "Chats",
            ),
            Tab(
              iconMargin: EdgeInsets.only(bottom: 2),
              icon: Icon(Icons.person_rounded),
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
