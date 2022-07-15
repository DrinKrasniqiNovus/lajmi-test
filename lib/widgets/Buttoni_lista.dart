import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtoniLista extends StatefulWidget {
  const ButtoniLista({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtoniLista> createState() => _ButtoniListaState();
}

class _ButtoniListaState extends State<ButtoniLista> {
  List myFavs = [];

  var lista = [];
  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = await prefs.getString('favorites');
    Iterable decode_options = jsonDecode(jsonString!);
  }

  @override
  void initState() {
    getfavorites();

    super.initState();
  }

  updateList(QueryDocumentSnapshot<Object?> doc) async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    FirebaseFirestore.instance.collection('users').doc(osUserID).update({
      'favorites': FieldValue.arrayUnion([
        {'url': doc['url'], 'name': doc['name']}
      ])
    });
  }

  remove(QueryDocumentSnapshot<Object?> doc) async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    FirebaseFirestore.instance.collection('users').doc(osUserID).update({
      'favorites': FieldValue.arrayRemove([
        {'url': doc['url'], 'name': doc['name']}
      ])
    });
  }

  getfavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    if (prefs.getString('osUserID') == null) {
      await FirebaseFirestore.instance.collection('users').doc(osUserID!).set({
        'userId': osUserID,
        'favorites': [],
      });
      await prefs.setString('osUserID', osUserID);
    }

    final favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(osUserID)
        .get();
    setState(() {
      myFavs = favorites['favorites'] as List;
    });
  }

  bool value = false;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        width: MediaQuery.of(context).size.width * 0.2,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              primary: const Color.fromRGBO(52, 72, 172, 2)),
          child: const Text("Shto",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () async {
            await getfavorites();

            showDialog(
              context: context,
              builder: (context) {
                return StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('categories')
                      .orderBy('order', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: const Color.fromRGBO(52, 72, 172, 2),
                        ),
                      );
                    } else {
                      return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          backgroundColor: Colors.red,
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(52, 72, 172, 2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: MediaQuery.of(context).size.height * 1,
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ListView(
                                children: snapshot.data!.docs.map((doc) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.08,
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                      ),
                                      tileColor:
                                          const Color.fromRGBO(52, 72, 172, 2),
                                      trailing: StarButton(
                                        isStarred: myFavs.any((element) =>
                                            DeepCollectionEquality().equals(
                                                element, {
                                              'url': doc['url'],
                                              'name': doc['name']
                                            })),
                                        iconSize: 40,
                                        valueChanged: (_isStarred) {
                                          if (_isStarred == true) {
                                            updateList(doc);
                                          } else {
                                            remove(doc);
                                          }
                                        },
                                      ),
                                      leading: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width: MediaQuery.of(context).size.width *
                                            0.07,
                                        child: SvgPicture.network(
                                          doc['icon'],
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text(
                                        doc['name'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ]),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
