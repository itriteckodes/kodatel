import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/custom/custom_list_tile.dart';
import 'package:kodatel/custom/payment_bottom_sheet.dart';
import 'package:kodatel/screen/more-screen/notification.dart';
import 'package:kodatel/screen/more-screen/packages/subcribe_packages.dart';
import 'package:kodatel/screen/more-screen/reset_password.dart';
import 'package:kodatel/screen/more-screen/show_icr.dart';
import 'package:kodatel/screen/more-screen/support/support_screen.dart';
import 'package:kodatel/screen/more-screen/transaction_histroy.dart';
import 'package:kodatel/screen/more-screen/transfer_balance.dart';
import 'package:kodatel/screen/more-screen/voucher_recharge.dart';
import 'package:share_plus/share_plus.dart';

class MoreSettings extends StatefulWidget {
  const MoreSettings({Key? key}) : super(key: key);

  @override
  State<MoreSettings> createState() => _MoreSettingsState();
}

class _MoreSettingsState extends State<MoreSettings> {
  createAlertDialog(BuildContext context) {
    final customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 4,
            title: const Center(child: Text("Please Enter a Number")),
            content: TextFormField(
              controller: customController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Can't be empty";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Code",
                  hintText: "Enter Country Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      )),
                  prefixIcon: const Icon(
                    Icons.phone_android,
                  )),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CustomButton(
                        height: 35, width: 120, text: "Cancel"),
                  )),
                  InkWell(
                    onTap: () {
                      if (customController.text.trim().isNotEmpty) {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ShowAddedRTC(
                                    prefix: customController.text)));
                      }
                    },
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "More Settings",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context, builder: (_) => bottomSheet(_));
          },
          child: const CustomListTile(
            title: "Make Payments/Add Funds",
            icon: Icons.payment,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const VoucherRecharge()));
          },
          child: const CustomListTile(
            title: 'Voucher Recharge',
            icon: Icons.published_with_changes_rounded,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SubcribePackaes()));
          },
          child: const CustomListTile(
            title: 'Subscribe Packages',
            icon: Icons.subscriptions,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TransferBalance()));
          },
          child: const CustomListTile(
            title: 'Share(or) Transfer Balance',
            icon: Icons.share,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            createAlertDialog(context);
          },
          child: const CustomListTile(
            title: 'International Call Rates',
            icon: Icons.inbox,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TransactionHistroy()));
          },
          child: const CustomListTile(
            title: 'Transaction History',
            icon: Icons.history_edu_rounded,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Supportpage()));
          },
          child: const CustomListTile(
            title: 'Support',
            icon: Icons.support,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NotificationPage()));
          },
          child: const CustomListTile(
            title: 'Notifications',
            icon: Icons.notifications,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Share.share('check out my website https://protocoderspoint.com/',
                subject: 'Sharing on Email');
          },
          child: const CustomListTile(
            title: 'Invite a friend',
            icon: Icons.person_add_rounded,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ResetPassword()));
          },
          child: const CustomListTile(
            title: 'Reset Password',
            icon: Icons.password_outlined,
            tralig: Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ]),
    ));
  }
}
