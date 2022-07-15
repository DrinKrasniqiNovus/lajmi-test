import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/widgets/Buttoni_lista.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/notification_provider.dart';
import 'njoftitmet.dart';

class Favorites extends StatefulWidget  {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> with TickerProviderStateMixin, WidgetsBindingObserver{
  List myFavs = [];
  bool isLoading = true;
  WebViewController? _controller;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];
  List<Tab> childs = <Tab>[];

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  late SharedPreferences shP;
  bool _showBackButton = false;
  int testIndex = 0;
  List notificationList = [];
  TabController? _tabController;
  List categoriesList = [];

  getfavorites() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    final favorites = await FirebaseFirestore.instance
        .collection('users')
        .doc(osUserID)
        .get();
    setState(() {
      myFavs = favorites['favorites'] as List;
    });
  }

  bool showBackButton(String url) {
    if(Platform.isAndroid){
      return false;
    }
    var patterns = [
      'https://lajmi.net/',
      'https://www.youtube.com/c/Lajminetofficial/videos',
      'https://lajmi.net/kategoria/'
    ];
    if (url == patterns[0] ||
        url == patterns[1] ||
        url.startsWith(patterns[2])) {
      return false;
    }
    return true;
  }

   getNotifications() async {
    var notifications = await FirebaseFirestore.instance
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    notificationList = notifications.docs;
  }

  Future<List> getCategories(int index) async {
    var categories = await FirebaseFirestore.instance
        .collection('categories')
        .orderBy('order', descending: false)
        .get();
    _tabController = TabController(length: categories.docs.length, vsync: this);
    _tabController!.index = index;
    shP = await SharedPreferences.getInstance();

    return categoriesList = categories.docs;
  }

  getLength() {}
  @override
  void initState() {
    getNotifications();
    getCategories(0);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    () async {
      shP = await SharedPreferences.getInstance();
    }();
  }

  @override
  Widget build(BuildContext context) {
    getfavorites();
    if (myFavs.length != 0) {
      return DefaultTabController(
        length: myFavs.length,
        child: WillPopScope(
          onWillPop: () async {
            if (await _controller!.canGoBack() == true) {
              await _controller!.goBack();
              return false;
            } else {
              return false;
            }
          },
          child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Scaffold(
              body: Stack(children: [
                Container(
                  padding: EdgeInsets.only(top: 62),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(myFavs.length, (int index) {
                      return new WebView(
                        zoomEnabled: false,
                              onProgress: (progress) {
                                if (progress > 50) {
                                  try {
                                    _controller?.runJavascript(
                                        'document.getElementsByClassName("header-bottom")[0].style.display="none"; document.getElementsByClassName("pre-header")[0].style.display="hide";');
                                  } catch (e) {}
                                }
                              },
                              userAgent:
                                  'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1',
                        initialUrl: myFavs[index]['url'].toString(),
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) {
                          this._controller = controller;
                        },
                        onPageFinished: (finish) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                        onPageStarted: (url) {
                                if (showBackButton(url)) {
                                  setState(() {
                                    _showBackButton = true;
                                  });
                                } else {
                                  setState(() {
                                    _showBackButton = false;
                                  });
                                }
                                testIndex = index;
                              },
                      );
                    }),
                  ),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            color: Color.fromRGBO(52, 72, 172, 2)),
                      )
                    : Center(),
                Container(
                  height: 122,
                  width: double.infinity,
                  child: AppBar(
                    bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      tabs: List<Widget>.generate(myFavs.length, (int index) {
                        return new Tab(text: '${myFavs[index]['name']}');
                      }),
                    ),
                    leading: _showBackButton
                              ? BackButton()
                              : Badge(
                                  stackFit: StackFit.passthrough,
                                  position: BadgePosition.topEnd(top: 8, end: 18),
                                  badgeColor: Colors.red,
                                  showBadge: shP.getString('id') !=
                                          notificationList[0]['id'] ||
                                      Provider.of<NotificationProvider>(context,
                                              listen: true)
                                          .isReceived,
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.notifications),
                                    onPressed: () {
                                      Provider.of<NotificationProvider>(context,
                                              listen: false)
                                          .messageOpened();
                                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Njoftimet(false)))
                                          .then((value) {
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ),
                    backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
                    centerTitle: true,
                    title: const Text(
                      'lajmi.net',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtoniLista(),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    } else {
      return WillPopScope(
        onWillPop: () async {
          if (await _controller!.canGoBack() == true) {
            await _controller!.goBack();
            return false;
          } else {
            return false;
          }
        },
        child:MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
              centerTitle: true,
              title: Text(
                'lajmi.net',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                // decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black, width: 8)),
                width: MediaQuery.of(context).size.width * 0.6,
                child: const Image(
                  image: NetworkImage(
                      'https://lajmi.net/wp-content/uploads/2022/03/cropped-274911459_510490313991928_5833048493577778828_n.jpg'),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0, top: 30),
                  child: const Text(
                    'Shto kategoritë e preferuara',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ButtoniLista(),
            ]),
          ),
        ),
      );
    }
  }
}
