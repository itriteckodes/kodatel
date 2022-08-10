import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/custom/button.dart';
import 'package:kodatel/pages/login_page.dart';
import 'package:kodatel/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key, required this.phone, required this.password})
      : super(key: key);
  final String phone;
  final String password;
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final name = TextEditingController();
  String dropdownValue = 'Add Status';
  final ImagePicker _picker = ImagePicker();
  final _key = GlobalKey<FormState>();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(children: [
                image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(File(image!.path)),
                        radius: 80,
                      )
                    : const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 204, 204, 204),
                        radius: 80,
                        child: Icon(
                          Icons.person,
                          color: backgroundColor,
                          size: 150,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomsheet()));
                  },
                  child: const CircleAvatar(
                    radius: padding + 10,
                    child: Icon(
                      Icons.camera_alt,
                      color: foregroundColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                nameTextForm(),
                const SizedBox(
                  height: padding + 10,
                ),
                statusButton(),
                const SizedBox(
                  height: padding + 10,
                ),
                InkWell(
                  onTap: () async {
                    if (image!.path.isNotEmpty &&
                        _key.currentState!.validate()) {
                      String? url = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .uploadToStorage(File(image!.path));
                      if (url!.isNotEmpty) {
                        bool isCreate = await Provider.of<AuthProvider>(context,
                                listen: false)
                            .createProfile({
                          'name': name.text,
                          'password': encryptText(widget.password),
                          'phone': widget.phone,
                          'status': dropdownValue,
                          'profileUrl': url,
                          'lastSeen': 'online'
                        });

                        if (isCreate) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()),
                              (route) => false);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Failed to create profile");
                        }
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Select an Profile Image your name");
                    }
                  },
                  child: Provider.of<AuthProvider>(context).isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          height: 40,
                          width: width(context) * 0.5,
                          text: "Done"),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: width(context),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(children: [
        const Text(
          "Choose Profile Photo",
          style: TextStyle(fontWeight: bold, fontSize: fontSize),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () async {
                  image = await _picker.pickImage(source: ImageSource.camera);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.camera,
                  color: backgroundColor,
                ),
                label: const Text("Camera")),
            TextButton.icon(
                onPressed: () async {
                  image = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.image,
                  color: backgroundColor,
                ),
                label: const Text("Gallery")),
          ],
        )
      ]),
    );
  }

  Widget nameTextForm() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Cant't be empty";
        }
        return null;
      },
      controller: name,
      decoration: const InputDecoration(
          labelText: "Name",
          hintText: "Full name",
          helperText: "Name can't be empty",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                color: backgroundColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(padding)),
              borderSide: BorderSide(
                color: backgroundColor,
                width: 2,
              )),
          prefixIcon: Icon(
            Icons.person,
            color: backgroundColor,
          )),
    );
  }

  Widget statusButton() {
    return Container(
        height: 55,
        width: width(context),
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(padding)),
            border: Border.all(width: 2, color: backgroundColor)),
        child: DropdownButton<String>(
          value: dropdownValue,
          underline: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(padding)),
                border: Border.all(width: 1, color: foregroundColor)),
          ),
          hint: const Text("Status"),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 30,
            color: backgroundColor,
          ),
          elevation: 16,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
          onChanged: (String? newValue) {
            setState(() {
              setState(() {
                dropdownValue = newValue!;
              });
            });
          },
          items: <String>[
            'Add Status',
            'Available',
            'Busy',
            'Send me a message',
            'In a meeting',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: SizedBox(width: width(context) * 0.60, child: Text(value)),
            );
          }).toList(),
        ));
  }
}
