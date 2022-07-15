import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/widgets/lista_sondazheve.dart';
import 'package:lajmi.net/widgets/sondazhiNull.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Sondazhi extends StatefulWidget {
  Sondazhi({Key? key}) : super(key: key);

  @override
  State<Sondazhi> createState() => _SondazhiState();
}

List answeredS = [];

getAnswers() async {
  final status = await OneSignal.shared.getDeviceState();
  final String? osUserID = status?.userId;

  var pergjigjet = await FirebaseFirestore.instance
      .collection('answers')
      .where('userId', isEqualTo: osUserID)
      .get();

  answeredS = pergjigjet.docs.map((e) => e['sondazhiId']).toList();
}

getActive(element) {
  if (element == Null) {
    return false;
  }
  return ((DateTime.parse(element['startDate'].toDate().toString()))
          .isBefore(DateTime.now()) &&
      (DateTime.parse(element['endDate'].toDate().toString()))
          .isAfter(DateTime.now()));
}

bool itsTrue = false;

class _SondazhiState extends State<Sondazhi> {
  @override
  void initState() {
    getAnswers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getAnswers();
    });
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
            centerTitle: true,
            title: const Text(
              'lajmi.net',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('sondazhet')
                          .orderBy('startDate')
                          .snapshots(),
                      builder: (ctx, AsyncSnapshot<QuerySnapshot> userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final userDocs = userSnapshot.data!.docs;
                        List active = userDocs
                            .where((element) => getActive(element))
                            .toList();
      
                        List activeIf = userDocs
                            .where((element) => getActive(element))
                            .map((e) => e.id)
                            .toList();
      
                        bool isActive;
                        if (answeredS.length != activeIf.length) {
                          isActive = false;
                        } else {
                          isActive = answeredS
                              .every((element) => activeIf.contains(element));
                        }
      
                        if (active.isNotEmpty && isActive == false)
                          return ListView.builder(
                            itemBuilder: (ctx, index) {
                              if (!answeredS.contains(userDocs[index]['id']) &&
                                  active.contains(userDocs[index])) {
                                return ListaSondazheve(
                                  title: userDocs[index]['title'],
                                  startText: userDocs[index]['startText'],
                                  endText: userDocs[index]['endText'],
                                  questions: userDocs[index]['questions'],
                                  id: userDocs[index]['id'],
                                );
                              }
                              return Container();
                            },
                            itemCount: userDocs.length,
                          );
                        return sondazhiNull();
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
