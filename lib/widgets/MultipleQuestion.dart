
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

class MultipleQuestion extends StatefulWidget {
  MultipleQuestion({
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
  State<MultipleQuestion> createState() => _MultipleQuestionState();
}

var value;
var valueValidator;
var itsTrue = false;
int indexchange = 0;

class _MultipleQuestionState extends State<MultipleQuestion> {
  var answers;
  Map<int, String> ans = {};
  var _deviceId;

  @override
  void initState() {
    answers = List.generate(
        (widget.question['options'] as List).length, (index) => false);

    for (var option in (widget.question['options'] as List)) {
      ans[option['value']] = '0';
    }
    ;
    for (var k = 0;
        k < ((widget.question['question'] as List).first['id'] as List).length;
        k++) {
      widget.saveAnswers('${widget.question['question'][0]['id'][k]}', '0');
    }
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (widget.question['question'] as List).length,
            (i) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200)),
              padding: EdgeInsets.only(top: 15),
              child: Column(
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Mund të zgjidhni më shumë se një përgjigjie!',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(250, 140, 140, 140),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ...List.generate(
                          (widget.question['options'] as List).length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                            
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.blueGrey.shade50),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.05),
                                child: CheckboxListTile(
                                  title: Align(
                                    alignment: Alignment(-1.2, 0),
                                    child: Text(
                                      widget.question['options'][index]['text'],
                                      style: TextStyle(fontSize: 14),
                                      maxLines: 3,
                                    ),
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 1.0),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: answers[index],
                                  activeColor:
                                      const Color.fromRGBO(52, 72, 172, 2),
                                  onChanged: (bool? v) {
                                    setState(() {
                                      int myValue = widget.question['options']
                                          [index]['value'];
                                      answers[index] = v;
                                      ans[myValue] = v! ? '1' : '0';
                                      value = answers[index] ? '1' : '0';
                                      valueValidator = answers[index];
                                    });
                                    if (valueValidator != null) {
                                      itsTrue = true;
                                      valueValidator = null;
                                    }
                                    if (itsTrue == true) {
                                      widget.saveAnswers(
                                          '${widget.question['question'][i]['id'][index]}',
                                          value.toString());
                                      widget.getValidator(itsTrue);
                                    }
                                    itsTrue = false;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
