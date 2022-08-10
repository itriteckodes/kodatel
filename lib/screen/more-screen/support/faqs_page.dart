import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class FAQSPAGE extends StatefulWidget {
  const FAQSPAGE({Key? key}) : super(key: key);

  @override
  _FAQSPAGEState createState() => _FAQSPAGEState();
}

class _FAQSPAGEState extends State<FAQSPAGE> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0.1,
        title: Row(
          children: const [
            Icon(
              Icons.question_answer,
              size: 30,
            ),
            SizedBox(
              width: padding,
            ),
            Text("FAQs"),
          ],
        ),
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: foregroundColor,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(216, 43, 43, 43),
       body: const SafeArea(
         child: SingleChildScrollView(
           child:  Text(
             "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                 "Lorem Ipsum has been the industry's standard dummy text ever since the "
                 "1500s, when an unknown printer took a galley of type and scrambled "
                 "it to make a type specimen book.\n    "
                 " It has survived not only five centuries, "
                 "but also the leap into electronic typesetting,"
                 " remaining essentially unchanged. It was popularised in the 1960s "
                 "with the release of Letraset sheets containing Lorem Ipsum passages, "
                 "and more recently with desktop publishing software like Aldus PageMaker "
                 "including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the "
                 "printing and typesetting industry. Lorem Ipsum has been the industry's standard"
                 " dummy text ever since the 1500s, when an unknown printer took a galley of type and "
                 "scrambled it to make a type specimen book. It has survived not only five centuries,"
                 " but also the leap into electronic typesetting, remaining essentially unchanged. It"
                 " was popularised in the 1960s with the release of Letraset sheets containing Lorem "
                 "Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker"
                 " including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and "
                 "typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since "
                 "the 1500s, when an unknown printer took a galley of type and scrambled it to make a type"
                 " specimen book. It has survived not only five centuries, but also the leap into electronic "
                 "typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release"
                 " of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing"
                 " software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy"
                 " text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"
                 " dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled"
                 " it to make a type specimen book. It has survived not only five centuries, but also the leap"
                 " into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s"
                 " with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with "
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                 "desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
             textAlign: TextAlign.justify,
             style: TextStyle(
               color: foregroundColor,
               fontSize: 14,
             ),
           ),
         ),
       ),
    );
  }
}
