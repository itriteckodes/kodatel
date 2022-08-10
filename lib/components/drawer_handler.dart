import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/custom/payment_bottom_sheet.dart';
import 'package:kodatel/providers/providers.dart';
import 'package:kodatel/screen/more-screen/transaction_histroy.dart';
import 'package:kodatel/screen/more-screen/transfer_balance.dart';
import 'package:kodatel/screen/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'drawer_list_tile.dart';

class DrawerHandler extends StatefulWidget {
  const DrawerHandler({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerHandler> createState() => _DrawerHandlerState();
}

class _DrawerHandlerState extends State<DrawerHandler> {
  createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Please Enter a Number")),
            content: TextFormField(
              controller: customController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Can't be empty";
                }
                return null;
              },
              // controller: username,
              decoration: InputDecoration(
                  labelText: "Please Enter a Code",
                  hintText: "Enter Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: backgroundColor,
                      )),
                  prefixIcon: const Icon(
                    Icons.code,
                    color: backgroundColor,
                  )),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (InkWell(
                    onTap: () {},
                    child: const CustomButton(
                        height: 35, width: 120, text: "Cancel"),
                  )),
                  InkWell(
                    onTap: () {},
                    child: const CustomButton(
                        height: 35, width: 120, text: "Get Call Rates"),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
              child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: padding, vertical: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 45,
                    child: Image.asset(
                      'assets/trans_logo.png',
                      height: 120,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: padding,
                ),
                const Text(
                  "Balance: 0.0 USD",
                  style: TextStyle(color: backgroundColor),
                )
              ],
            ),
          )),
          DrawerListTile(
            title: "Make Payments/Add Funds",
            source: Icons.payment,
            press: () {
              showModalBottomSheet(
                  context: context, builder: (_) => bottomSheet(context));
            },
          ),
          DrawerListTile(
            title: "Share(or) Transfer Balance",
            source: Icons.share,
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TransferBalance()));
            },
          ),
          DrawerListTile(
            title: "International Call Rates",
            source: Icons.inbox,
            press: () {
              createAlertDialog(context);
            },
          ),
          DrawerListTile(
            title: "Transaction History",
            source: Icons.history_edu_rounded,
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TransactionHistroy()));
            },
          ),
          DrawerListTile(
            title: "Invite frined",
            source: Icons.person_add_rounded,
            press: () {
              Share.share('check out my website https://mericall.com/',
                  subject: 'Sharing on Email');
            },
          ),
          DrawerListTile(
            title: "Signout",
            source: Icons.exit_to_app,
            press: () {
              Provider.of<AuthProvider>(context, listen: false).handleSignOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SpalshScreen(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
