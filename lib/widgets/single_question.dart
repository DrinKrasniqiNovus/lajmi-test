import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:platform_device_id/platform_device_id.dart';

class SingleQuestion extends StatefulWidget {
  SingleQuestion({
    Key? key,
    required this.question,
    required this.sondazhiId,
    required this.saveAnswers,
    required this.getValidator,
  }) : super(key: key);

  final Map question;
  final String sondazhiId;
  Function(dynamic, String) saveAnswers;
  Function(bool) getValidator;

  @override
  State<SingleQuestion> createState() => _SingelQuestionState();
}

var ss_value = null;
var value;
var valueValidator;
var itsTrue = false;

class _SingelQuestionState extends State<SingleQuestion> {
  var answers;
  var _deviceId;
  int indexchange = 0;

  @override
  void initState() {
    answers = List.generate(
        (widget.question['question'] as List).length, (index) => '0');
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
  
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    if (!mounted) return;

    setState(() {
      _deviceId = deviceId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('answers').doc().get(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            child: Column(
              children: List.generate(
                (widget.question['question'] as List).length,
                (i) => Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200)),
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    (widget.question['question'] as List)[i]
                                        ['text'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Mund të zgjidhni vetëm një përgjigjie!',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromARGB(250, 140, 140, 140),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      ...(widget.question['options'] as List)
                          .map(
                            (opt) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                               
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: Colors.blueGrey.shade50),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0.05),
                                  child: RadioListTile(
                                    key: Key(
                                        '${(widget.question['question'] as List)[i]['id']}:${opt['value']}'
                                            .toString()),
                                    title: Align(
                                      alignment: Alignment(-1.1, 0),
                                      child: Text(
                                        opt['text'],
                                        style: TextStyle(fontSize: 14),
                                        maxLines: 3,
                                      ),
                                    ),
                                    dense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 1.0),
                                    activeColor:
                                        const Color.fromRGBO(52, 72, 172, 2),
                                    value: '${opt['value']}',
                                    groupValue: answers[i].toString(),
                                    onChanged: (String? option) {
                                      setState(() {
                                        answers[i] = option;
                                        value = answers[i];
                                        valueValidator = answers[i];
                                      });
                                      if (valueValidator != null) {
                                        itsTrue = true;
                                        valueValidator = null;
                                      }
                                      if (itsTrue == true) {
                                        widget.saveAnswers(
                                            widget.question['question'][i]
                                                ['id'],
                                            value);
                                        widget.getValidator(itsTrue);
                                      }
                                      itsTrue = false;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
