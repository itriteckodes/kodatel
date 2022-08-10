import 'package:contacts_service/contacts_service.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/components/drawer_handler.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/screen/more-screen/transfer_balance.dart';

class KeyBoradScreen extends StatefulWidget {
  const KeyBoradScreen({Key? key}) : super(key: key);

  @override
  _KeyBoradScreenState createState() => _KeyBoradScreenState();
}

class _KeyBoradScreenState extends State<KeyBoradScreen> {
  String? initCode = "+92";
  bool isSelect = false;
  bool isCountrySelect = false;
  final no = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHandler(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: black),
        backgroundColor: widgetColor,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Available Credit ",
              style: TextStyle(
                color: black,
                fontSize: 14,
              ),
            ),
            Text(
              "\$0.0",
              style: TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: const [
          Center(
            child: Text(
              "Registered",
              style: TextStyle(
                color: Colors.green,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: isSelect ? noTextField() : recentContactWithSearch()),
          Container(
            width: width(context),
            color: widgetColor,
            height: 50,
            child: isCountrySelect
                ? countryCard()
                : InkWell(
                    onTap: () {
                      setState(() {
                        isCountrySelect = true;
                        countryCard();
                      });
                    },
                    child: country()),
          ),
          Expanded(flex: 3, child: keyboard()),
        ],
      ),
    );
  }

  Widget noTextField() {
    return Container(
      color: widgetColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding + 10),
          child: TextFormField(
            controller: no,
            readOnly: true,
            style: TextStyle(
              fontSize: no.text.length < 14
                  ? 40
                  : no.text.length < 20
                      ? 30
                      : 20,
              fontWeight: bold,
            ),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  Widget recentContactWithSearch() {
    return Container(
      color: widgetColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                Contact? contact =
                    await ContactsService.openDeviceContactPicker();
                if (contact != null) {
                  setState(() {
                    isSelect = true;
                    no.text = contact.phones![0].value!;
                  });
                }
              },
              child: Center(
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: backgroundColor,
                      ),
                      color: foregroundColor,
                      borderRadius: BorderRadius.circular(padding + 10)),
                  margin: const EdgeInsets.symmetric(
                      horizontal: padding, vertical: padding),
                  width: width(context) - 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.search,
                        size: 20,
                      ),
                      SizedBox(
                        width: padding,
                      ),
                      Text(
                        "Search Contact",
                        style: TextStyle(
                            fontSize: fontSize,
                            color: Color.fromARGB(255, 128, 127, 127)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: backgroundColor,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: foregroundColor,
                              radius: 20,
                              child: Icon(
                                Icons.person_rounded,
                                color: backgroundColor,
                                size: 30,
                              ),
                            )),
                        const Text(
                          "Person 3 ",
                          style: TextStyle(
                            fontSize: 11,
                            color: black,
                            fontWeight: bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: padding,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: backgroundColor,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: foregroundColor,
                              radius: 20,
                              child: Icon(
                                Icons.person_rounded,
                                color: backgroundColor,
                                size: 30,
                              ),
                            )),
                        const Text(
                          "Person 1",
                          style: TextStyle(
                            fontSize: 11,
                            color: black,
                            fontWeight: bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: padding,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: backgroundColor,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: foregroundColor,
                              radius: 20,
                              child: Icon(
                                Icons.person_rounded,
                                color: backgroundColor,
                                size: 30,
                              ),
                            )),
                        const Text(
                          "Person 2",
                          style: TextStyle(
                            fontSize: 11,
                            color: black,
                            fontWeight: bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: padding,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: backgroundColor,
                              ),
                            ),
                            child: const CircleAvatar(
                              backgroundColor: foregroundColor,
                              radius: 20,
                              child: Icon(
                                Icons.monetization_on,
                                color: backgroundColor,
                                size: 30,
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TransferBalance()));
                          },
                          child: const Text(
                            "Send Mobile Top-Up",
                            style: TextStyle(
                              fontSize: 11,
                              color: black,
                              fontWeight: bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                     /**   const Text(
                          "Send Mobile Top-Up",
                          style: TextStyle(
                            fontSize: 11,
                            color: black,
                            fontWeight: bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )

                        **/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget country() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Row(
        children: [
          const Icon(
            Icons.flag,
            size: 20,
          ),
          const SizedBox(
            width: padding,
          ),
          const Text(
            'Select country',
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            width: padding * 6,
          ),
          const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: backgroundColor,
            size: 30,
          ),
          const Spacer(),
          no.text.length > 4
              ? const Text(
                  "Rate:0.25 \$",
                  style: TextStyle(color: Colors.green, fontSize: fontSize),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget countryCard() {
    return CountryListPick(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Choose country',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // if you need custom picker use this
      pickerBuilder: (context, CountryCode? countryCode) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    countryCode!.flagUri!,
                    package: 'country_list_pick',
                  ),
                ),
                const SizedBox(
                  width: padding,
                ),
                Text(
                  countryCode.name!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: padding * 6,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: backgroundColor,
                  size: 30,
                )
              ],
            ),
          ],
        );
      },
      theme: CountryTheme(
        isShowFlag: true,
        isShowCode: true,
        isDownIcon: true,
        showEnglishName: false,
        labelColor: backgroundColor,
      ),
      initialSelection: initCode,
      // or
      // initialSelection: 'US'
      // Whether to allow the widget to set a custom UI overlay
      useUiOverlay: true,
      // Whether the country list should be wrapped in a SafeArea
      useSafeArea: false,
      onChanged: (CountryCode? code) {
        setState(() {
          initCode = code!.dialCode;
          no.text = initCode!;
          isSelect = true;
          isCountrySelect = true;
        });
      },
    );
  }

  Widget keyboard() {
    return Padding(
      padding: const EdgeInsets.only(
          top: padding * 2, bottom: padding * 2, left: padding, right: padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      if (no.text.length <= 25) {
                        no.text = no.text + '1';
                      }
                      isSelect = true;
                    });
                  },
                  child: const Text(
                    "1",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '2';
                      }
                    });
                  },
                  child: const Text(
                    "2",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '3';
                      }
                    });
                  },
                  child: const Text(
                    "3",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '4';
                      }
                    });
                  },
                  child: const Text(
                    "4",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '5';
                      }
                    });
                  },
                  child: const Text(
                    "5",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '6';
                      }
                    });
                  },
                  child: const Text(
                    "6",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '7';
                      }
                    });
                  },
                  child: const Text(
                    "7",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '8';
                      }
                    });
                  },
                  child: const Text(
                    "8",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '9';
                      }
                    });
                  },
                  child: const Text(
                    "9",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '*';
                      }
                    });
                  },
                  child: const Text(
                    "*",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
              const SizedBox(
                width: padding - 5,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelect = true;
                    if (no.text.length <= 25) {
                      no.text = no.text + '0';
                    }
                  });
                },
                onLongPress: () {
                  setState(() {
                    isSelect = true;
                    no.text = no.text + '+';
                  });
                },
                child: Column(
                  children: const [
                    Text(
                      "0",
                      style: TextStyle(
                          fontWeight: bold, fontSize: 25, color: black),
                    ),
                    Text(
                      "+",
                      style: TextStyle(fontSize: 15, color: black),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: padding - 5,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isSelect = true;
                      if (no.text.length <= 25) {
                        no.text = no.text + '#';
                      }
                    });
                  },
                  child: const Text(
                    "#",
                    style:
                        TextStyle(fontWeight: bold, fontSize: 30, color: black),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () async {
                    if (no.text.isNotEmpty) {
                      List<Item> phones = [
                        Item(label: "Phone", value: no.text)
                      ];
                      Contact contact = Contact(phones: phones);
                      await ContactsService.addContact(contact);
                      await ContactsService.openExistingContact(contact);
                    }
                  },
                  icon: const Icon(
                    Icons.person_add_rounded,
                    size: 40,
                    color: Color.fromARGB(255, 112, 112, 112),
                  )),
              Container(
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(padding * 3)),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.call,
                      color: foregroundColor,
                      size: 30,
                    )),
              ),
              InkWell(
                onTap: () {
                  if (no.text.isNotEmpty) {
                    setState(() {
                      no.text = no.text.substring(0, no.text.length - 1);
                      if (no.text.isEmpty) {
                        isSelect = false;
                        isCountrySelect = false;
                      }
                    });
                  } else {
                    setState(() {
                      isSelect = false;
                      isCountrySelect = false;
                    });
                  }
                },
                onLongPress: () {
                  setState(() {
                    no.clear();
                    isCountrySelect = false;
                    isSelect = false;
                  });
                },
                child: const Icon(
                  Icons.backspace,
                  color: Color.fromARGB(255, 112, 112, 112),
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
