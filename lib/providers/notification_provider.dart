import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  bool isReceived = false;
  getisReceived() {
    return isReceived;
  }

  messageReceived() {
    isReceived = true;
    notifyListeners();
  }

  messageOpened() {
    isReceived = false;
    notifyListeners();
  }
}
