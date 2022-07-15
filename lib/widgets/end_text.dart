import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/navbar.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class EndText extends StatefulWidget {
  EndText({
    Key? key,
    required this.title,
    required this.endText,
    required this.Answers,
    required this.DeviceId,
    required this.questionId,
    required this.sondazhiId,
  }) : super(key: key);
  final String title;
  final String endText;
  final Map Answers;
  final String DeviceId;
  final String questionId;
  final String sondazhiId;

  @override
  State<EndText> createState() => _StartTextState();
}

class _StartTextState extends State<EndText> {
  setSingleAnswer(
      String questionID, String sondazhiId, String _deviceId) async {
    var answersId = FirebaseFirestore.instance.collection('answers').doc();
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    var answer = await FirebaseFirestore.instance
        .collection('answers')
        .where('sondazhiId', isEqualTo: sondazhiId)
        .where('deviceId', isEqualTo: widget.DeviceId)
        .get();
    var valbona = answer.docs;
    if (valbona.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('answers')
          .doc(answer.docs[0]['id'])
          .update({
        'answers': {'answer': widget.Answers}
      });
    } else {
      answersId.set({
        'sondazhiId': sondazhiId,
        'userId': osUserID,
        'id': answersId.id,
        'deviceId': widget.DeviceId,
        'answers': {
          'answer': widget.Answers 
        },
      });
    }
  }

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
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              insetPadding: EdgeInsets.zero,
              content: Container(
                width: 100,
                height: 40,
                child: const Text(
                  'A jeni të sigurt që te largohuni\nkëtë pyetësor?',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Jo'),
                      child: const Text(
                        'Jo',
                        style: TextStyle(
                          color: const Color.fromRGBO(52, 72, 172, 2),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavBar(
                                    true,
                                  )),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Po',
                        style: TextStyle(
                          color: const Color.fromRGBO(52, 72, 172, 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              elevation: 24.0,
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 400,
            minHeight: 300,
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
                    children: [
                      Flexible(
                        child: Text(
                          'lajmi.net',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(52, 72, 172, 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.endText,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Color.fromARGB(250, 140, 140, 140),
                            ),
                          ),
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
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(52, 72, 172, 2)),
                            onPressed: () {
                           
                              setSingleAnswer(widget.questionId,
                                  widget.sondazhiId, widget.DeviceId);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavBar(
                                          true,
                                        )),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text('Perfundo')),
                      ),
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
