import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';
import 'package:kodatel/screen/login_or_signup_screen.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({Key? key, required this.isBeforeLogin}) : super(key: key);
  final bool isBeforeLogin;

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int currentIndex = 0;
  List cardList = [
    const Item1(),
    const Item2(),
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                height: height(context) - 80,
                autoPlay: false,
                enableInfiniteScroll: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.9,
                aspectRatio: 2.0,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              items: cardList.map((card) {
                return Builder(builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      child: card,
                    ),
                  );
                });
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginOrSignUpScreen()));
                  },
                  child: widget.isBeforeLogin
                      ? const Text(
                          "Skip",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: fontSize,
                              fontWeight: bold),
                        )
                      : Container(),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: map<Widget>(cardList, (index, url) {
                    return Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: backgroundColor),
                        color: currentIndex == index
                            ? backgroundColor
                            : foregroundColor,
                      ),
                    );
                  }),
                )),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (currentIndex < 1) {
                        buttonCarouselController.animateToPage(1);
                        currentIndex = 1;
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginOrSignUpScreen()));
                      }
                    });
                  },
                  child: widget.isBeforeLogin
                      ? const Text(
                          "Next",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: fontSize,
                              fontWeight: bold),
                        )
                      : Container(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  const Item1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/blue_logo.png',
                  height: 120,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(padding),
            child: Container(
              height: 200,
              width: width(context),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 25, 34, 25),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Be-in-Touch with Friends & Family",
                    style: TextStyle(color: foregroundColor),
                  ),
                  Text(
                    "All-the-Time",
                    style: TextStyle(color: foregroundColor),
                  ),
                  SizedBox(
                    width: 150,
                    child: Divider(
                      thickness: 1,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Call landlines and mobiles for exteremely low-rates",
                    style: TextStyle(color: foregroundColor, fontSize: 13),
                  ),
                  Text(
                    "around the world",
                    style: TextStyle(color: foregroundColor, fontSize: 13),
                  ),
                  Text(
                    "Free app-to-app audio,instant...",
                    style: TextStyle(color: foregroundColor, fontSize: 13),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/blue_logo.png',
                  height: 120,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: Container(
              height: 200,
              width: width(context),
              decoration: BoxDecoration(
                //  borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 25, 34, 25),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Simple & secure E-Wallet",
                    style: TextStyle(color: foregroundColor),
                  ),
                  Text(
                    "All-the-Time",
                    style: TextStyle(color: foregroundColor),
                  ),
                  SizedBox(
                    width: 150,
                    child: Divider(
                      thickness: 1,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Call landlines and mobiles for exteremely low-rates",
                    style: TextStyle(color: foregroundColor, fontSize: 13),
                  ),
                  Text(
                    "around the world",
                    style: TextStyle(color: foregroundColor, fontSize: 13),
                  ),
                  Text(
                    "Free app-to-app audio,instant...",
                    style: TextStyle(color: foregroundColor, fontSize: 13),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
