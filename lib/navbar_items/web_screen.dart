import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatefulWidget {
  WebScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  _WebScreenState createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  bool isLoading = true;
  late WebViewController _controller;
  final userAgent = 'Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3';
  final controller = Completer<WebViewController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack() == true) {
          await _controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top:59 ),
         
            child: WebView(
              userAgent: 'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.133 Mobile Safari/535.19',
              zoomEnabled: false,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller = controller;
              },
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: const Color.fromRGBO(52, 72, 172, 2)),
                )
              : Center(),
          Container(
            child: AppBar(
              leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () async {
                    if (await _controller.canGoBack() == true) {
                      await _controller.goBack();
                    } else {
                      Navigator.pop(context);
                    }
                  }),
              backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
              centerTitle: true,
              title: const Text(
                'lajmi.net',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            height: Platform.isIOS ? 128:122,
            width: double.infinity,
          ),
        ]),
      ),
    );
  }
}
