import 'dart:io';
import 'dart:io' show Platform;

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lajmi.net/navbar_items/njoftitmet.dart';
import 'package:lajmi.net/providers/notification_provider.dart';
import 'package:lajmi.net/widgets/lajmidrawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lajmi extends StatefulWidget {
  const Lajmi({
    Key? key,
  }) : super(key: key);
  // final Function goToHome;
  @override
  _LajmiState createState() => _LajmiState();
}

class _LajmiState extends State<Lajmi>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  static final bool isIOS = Platform.isIOS;

  var _youtubeURL = 'https://www.youtube.com/c/Lajminetofficial/videos';

  Future<void> _launchYoutubeVideo(String _youtubeUrl) async {
    if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
      if (await canLaunch(_youtubeUrl)) {
        final bool _nativeAppLaunchSucceeded = await launch(
          _youtubeUrl,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
        if (!_nativeAppLaunchSucceeded) {
          await launch(_youtubeUrl, forceSafariVC: true);
        }
      }
    }
  }

  _launchURL() async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'youtube://www.youtube.com/c/Lajminetofficial/videos')) {
        await launch('youtube://www.youtube.com/c/Lajminetofficial/videos',
            forceSafariVC: false);
      } else {
        if (await canLaunch(
            'https://www.youtube.com/c/Lajminetofficial/videos')) {
          await launch('https://www.youtube.com/c/Lajminetofficial/videos');
        } else {
          throw 'Could not launch https://www.youtube.com/c/Lajminetofficial/videos';
        }
      }
    } else {
      const url = 'https://www.youtube.com/c/Lajminetofficial/videos';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  late SharedPreferences shP;
  bool rebuild = false;
  bool isLoading = true;
  bool _showBackButton = false;
  List categoriesList = [];
  List notificationList = [];
  bool initialFinished = false;
  late WebViewController _controller;
  TabController? _tabController;
  int testIndex = 0;

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

  indexOfMenu(int index) {
    _tabController!.animateTo(index);
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
    return FutureBuilder(
        future: getCategories(testIndex),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DefaultTabController(
              length: categoriesList.length,
              child: WillPopScope(
                onWillPop: () async {
                  if (_key.currentState!.isEndDrawerOpen) {
                    Navigator.of(context).pop();
                    return false;
                  }
                  if (await _controller.canGoBack() == true) {
                    await _controller.goBack();
                    return false;
                  } else {
                    return false;
                  }
                },
                child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                  child: Scaffold(
                    key: _key,
                    endDrawer: LajmiDrawer(indexOfMenu: indexOfMenu),
                    body: Stack(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 62),
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: List<Widget>.generate(categoriesList.length,
                              (int index) {
                            return new WebView(
                              zoomEnabled: false,
                              onProgress: (progress) {
                                if (progress > 50) {
                                  try {
                                    _controller.runJavascript(
                                        'document.getElementsByClassName("header-bottom")[0].style.display="none"; document.getElementsByClassName("pre-header")[0].style.display="hide";');
                                  } catch (e) {}
                                }
                              },
                              userAgent:
                                  'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1',
                              initialUrl: categoriesList[index]['url'].toString(),
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated: (controller) {
                                this._controller = controller;
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
                              onPageFinished: (finish) {
                                isLoading = false;
                              },
                            );
                          }),
                        ),
                      ),
                      Center(),
                      Container(
                        child: AppBar(
                          bottom: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            indicatorColor: Colors.white,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: List<Widget>.generate(categoriesList.length,
                                (int index) {
                              return new Tab(
                                  text: '${categoriesList[index]['name']}');
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
                          title: Text(
                            
                            'lajmi.net',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        height: 122,
                        width: double.infinity,
                      ),
                    ]),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
