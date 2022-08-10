import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/pages/contact/contact_details.dart';
import 'package:kodatel/providers/user_details.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

const iOSLocalizedLabels = false;

class AllContacts extends StatefulWidget {
  const AllContacts({Key? key}) : super(key: key);

  @override
  State<AllContacts> createState() => _AllContactsState();
}

class _AllContactsState extends State<AllContacts> {
  bool permissonGranted = false;
  late PermissionStatus permissionStatus;
  late Iterable<Contact> contactsList;
  bool isListNull = true;
  @override
  void initState() {
    checkPermision();
    super.initState();
  }

  void checkPermision() async {
    bool granted = await checkPermissions();
    setState(() {
      permissonGranted = granted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: permissonGranted
          ? isListNull == false
              ? ListView.builder(
                  itemCount: contactsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = contactsList.elementAt(index);
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 18),
                      leading:
                          (contact.avatar != null && contact.avatar!.isNotEmpty)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar!),
                                )
                              : CircleAvatar(
                                  child: Text(contact.initials()),
                                  backgroundColor: widgetColor,
                                ),
                      title: Text(contact.displayName ?? ''),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContactDetials(
                                      contact: contact,
                                    )));
                      },
                      onLongPress: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) => SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text('Do You want to delete?',
                                          style: TextStyle(
                                              fontWeight: bold,
                                              fontSize: fontSize)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                size: padding * 3,
                                                color: Colors.grey,
                                              )),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          IconButton(
                                              onPressed: () async {
                                                await ContactsService
                                                    .deleteContact(contact);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Deleted Successfully');
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                size: padding * 3,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                      },
                    );
                  },
                )
              : const Center(child: Text("No Contacts Found"))
          : const Center(
              child: Text("Permision Not Granted"),
            ),
    );
  }

  Future<bool> checkPermissions() async {
    permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getContacts();
      return true;
    } else {
      return false;
    }
  }

  //Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getContacts() async {
    Provider.of<UserDetails>(context, listen: false).getAllUsers();
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    if (contacts.isNotEmpty) {
      setState(() {
        isListNull = false;
        contactsList = contacts;
      });
    }
  }
}
