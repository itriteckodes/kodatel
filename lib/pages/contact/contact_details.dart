import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class ContactDetials extends StatelessWidget {
  const ContactDetials({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: widgetColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: backgroundColor,
              )),
          actions: [
            InkWell(
              onTap: () async {
                await ContactsService.openExistingContact(contact);
              },
              child: const CircleAvatar(
                backgroundColor: backgroundColor,
                radius: 20,
                child: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: foregroundColor,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ]),
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 150,
            width: width(context),
            color: widgetColor,
            child: Column(children: [
              const CircleAvatar(
                backgroundColor: foregroundColor,
                radius: 50,
                child: Icon(
                  Icons.person_rounded,
                  size: 100,
                  color: backgroundColor,
                ),
              ),
              const SizedBox(
                height: padding,
              ),
              Text(
                contact.displayName!,
                style: const TextStyle(color: Colors.black),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contact.phones!.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: backgroundColor,
                    radius: 20,
                    child: Icon(
                      Icons.phone_android_rounded,
                      size: 20,
                      color: foregroundColor,
                    ),
                  ),
                  title: Text(contact.phones![index].value!),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
