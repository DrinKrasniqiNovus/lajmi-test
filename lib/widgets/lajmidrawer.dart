import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LajmiDrawer extends StatefulWidget {
  const LajmiDrawer({
    required this.indexOfMenu,
    Key? key,
  }) : super(key: key);
  final Function indexOfMenu;
  @override
  State<LajmiDrawer> createState() => _LajmiDrawerState();
}

final db = FirebaseFirestore.instance;

class _LajmiDrawerState extends State<LajmiDrawer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection('categories')
          .orderBy('order', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(52, 72, 172, 2),
            ),
          );
        } else {
          return Container(
              height: MediaQuery.of(context).size.height * 1,
              child: Drawer(
                child: ListView(
                  children:
                      List.generate(snapshot.data!.docs.length, (int index) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListTile(
                          tileColor: Colors.white,
                          leading: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: SvgPicture.network(
                              snapshot.data!.docs[index]['icon'],
                              color: Color.fromRGBO(52, 72, 172, 2),
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docs[index]['name'],
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            widget.indexOfMenu(index);
                          }),
                    );
                  }
                 
                          ),
                ),
              ));
        }
      },
    );
  }
}
