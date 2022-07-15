import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/navbar.dart';
import 'package:lajmi.net/navbar_items/web_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Njoftimet extends StatefulWidget {
  Njoftimet(this.isOpen);
  final bool isOpen;
  @override
  _NjoftimetState createState() => _NjoftimetState();
}

class _NjoftimetState extends State<Njoftimet> {
  bool rebuild = false;
  late SharedPreferences shP;
  String imageurl = '';
  @override
  void initState() {
    super.initState();
    () async {
      shP = await SharedPreferences.getInstance();
    }();
  }

  @override
  Widget build(BuildContext context) {
  
    return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: widget.isOpen
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar(false)),
                      );
                    }
                  : () {
                      Navigator.pop(
                        context,
                      );
                    },
            ),
            toolbarHeight: 45,
            backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
            centerTitle: true,
            title: Text(
              'lajmi.net',
              style: TextStyle(color: Colors.white),
            ),
            //
          ),
          body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('notifications')
                  .orderBy('createdAt', descending: true)
                  .limit(30)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  final njoftimet = snapshot.data!.docs;
                  if (shP.getString('id') != njoftimet.first['id']) {
                    shP.setString('id', njoftimet.first['id']);
                   
                  }
    
                  return Stack(
                    children: [
                      ListView.builder(
                          itemCount: njoftimet.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Image(
                                        image: NetworkImage(
                                            njoftimet[index]['imageUrl']))),
                                title: Text(njoftimet[index]['content']),
                                onTap: () {
                                  if (njoftimet[index]['url'] as String == '') {
                                    
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavBar(
                                                true,
                                              )),
                                      (Route<dynamic> route) => false,
                                    );
                                  } else {
                                 
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WebScreen(
                                              url: njoftimet[index]['url']
                                                  .toString())),
                                    );
                                  }
                                },
                              ),
                            );
                          })
                    ],
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                }
              })),
    );
  }
}
