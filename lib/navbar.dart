import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/navbar_items/favorites.dart';
import 'package:lajmi.net/navbar_items/sondazhi.dart';
import 'package:lajmi.net/providers/notification_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant/constant.dart';
import 'navbar_items/lajmi.dart';

class NavBar extends StatefulWidget {
  const NavBar(
    this.isSondazh,
  );

  final bool isSondazh;

  @override
  _NavBarState createState() => _NavBarState();
}

var phonenr;
bool login = false;

class _NavBarState extends State<NavBar> {
  int selectedPage = 0;
  bool isBallina = false;
  List _pageOptions = [];

  // getNumber() async {
  //   var number = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('phonenumber', isNotEqualTo: null)
  //       .get();
  //   if (number != '') {
  //     setState(() {
  //       login = true;
  //     });
  //   }
  // }

  
  void foregroundNotificationg(context) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
      var provider = Provider.of<NotificationProvider>(context, listen: false);
      provider.messageReceived();
    });
  }

  Future getUser() async {}
  String? osUserID;
  @override
  void initState() {
    selectedPage = widget.isSondazh ? 2 : 0;
    
    foregroundNotificationg(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pageOptions = [
      Lajmi(
        key: Key(isBallina.toString()),
      ),
      const Favorites(),
      Sondazhi(),
    ];
    return Scaffold(
        backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
        body: _pageOptions[selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30),
              label: 'Ballina',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star, size: 30),
              label: 'Të preferuarat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.how_to_vote, size: 30),
              label: 'Sondazhet',
            ),
          ],
          selectedItemColor: Color.fromRGBO(52, 72, 172, 2),
          elevation: 5.0,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            if (index == 0) {
              setState(() {
                isBallina = !isBallina;
              });
            }
            setState(() {
              selectedPage = index;
            });
          },
        ));
  }
}
