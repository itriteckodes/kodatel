import 'package:contacts_service/contacts_service.dart';

class ContactProvider {
  late Iterable<Contact> contactsList;
  bool isListNull = true;
  getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    if (contacts.isNotEmpty) {
      contactsList = contacts;
    }
  }
}
