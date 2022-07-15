import 'package:flutter/material.dart';
import 'package:lajmi.net/widgets/GeneralTermsEN.dart';
import 'package:lajmi.net/widgets/GeneralTerms__text.dart';
import 'package:lajmi.net/widgets/questions.dart';

class StartText extends StatefulWidget {
  StartText({
    Key? key,
    required this.title,
    required this.startText,
    required this.endText,
    required this.questions,
    required this.id,
  }) : super(key: key);
  final String title;
  final String startText;
  final String endText;
  final List questions;
  final String id;

  @override
  State<StartText> createState() => _StartTextState();
}

class _StartTextState extends State<StartText> {
  bool isChecked = false;
  bool isEN = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
        centerTitle: true,
        title: Text(
          'lajmi.net',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 700,
            maxWidth: 300,
          ),
          child: SingleChildScrollView(
            child: Card(
              elevation: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                widget.startText,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(250, 140, 140, 140)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              activeColor: const Color.fromRGBO(52, 72, 172, 2),
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Flexible(
                              child: TextButton(
                                child: Text(
                                  'Kushtet e përdorimit dhe Politika e privatësisë',
                                  style: TextStyle(
                                    color: Color.fromRGBO(52, 72, 172, 2),
                                  ),
                                ),
                                onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        StatefulBuilder(
                                          builder: (context, setState) =>
                                              AlertDialog(
                                            title: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: TextButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              isEN = !isEN;
                                                            });
                                                          },
                                                          child: Text(
                                                            isEN == true
                                                                ? 'AL'
                                                                : "EN",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        52,
                                                                        72,
                                                                        172,
                                                                        2),
                                                                fontSize: 18),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: isEN == true
                                                          ? Text(
                                                              'Terms and Conditions and Privacy Policy',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )
                                                          : Text(
                                                              'Kushtet e përdorimit dhe Politika e privatësisë!'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  isEN == true
                                                      ? GeneralTermsEN()
                                                      : GeneralTerms(),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(
                                                  isEN == true
                                                      ? 'Exit'
                                                      : 'Largo',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        52, 72, 172, 2),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 200,
                          height: 40,
                          child: isChecked
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          const Color.fromRGBO(52, 72, 172, 2)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Questions(
                                                title: widget.title,
                                                startText: widget.startText,
                                                endText: widget.endText,
                                                questions: widget.questions,
                                                id: widget.id,
                                              )),
                                    );
                                  },
                                  child: Text('VAZHDO'),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey[400]),
                                  onPressed: () {},
                                  child: Text('VAZHDO'),
                                )),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
