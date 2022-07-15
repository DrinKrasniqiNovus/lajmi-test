import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lajmi.net/navbar_items/sondazhi.dart';
import 'package:lajmi.net/widgets/FullRegister.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  late String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Sondazhi()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login failed")));
    }
  }

  var _phonenumber = '';

  updateRegistrimi() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(osUserID)
        .update({'phonenumber': _phonenumber});
  }

//   //verify

//   bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;

  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  void _onCountryChange(PhoneNumber countryCode) {
    _phonenumber = countryCode.countryCode + countryCode.number;
  }

  getMobileFormWidget(context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FadeInDown(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_outlined),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullRegister()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset('assets/images/lajmilogo.PNG'),
                SizedBox(
                  height: 50,
                ),
                FadeInDown(
                  child: Text(
                    'VERIFIKO NUMRIN',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.grey.shade900),
                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20),
                    child: Text(
                      // 'Enter your phone number to continu, we will send you OTP to verifiy.',
                      'Shto numrin tuaj te telefonit , nese deshiron te dergosh kodin.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, color: Colors.grey.shade700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 400),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: IntlPhoneField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Numeri Telefonit',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'XK',
                      onChanged: _onCountryChange,
                      onSaved: (value) {
                        _phonenumber = value!.countryCode + value.number;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // FadeInDown(
                //   delay: Duration(milliseconds: 600),
                //   child: FlatButton(
                //     onPressed: () async {
                //       setState(() {
                //         showLoading = true;
                //       });

                //       await _auth.verifyPhoneNumber(
                //         phoneNumber: _phonenumber,
                //         verificationCompleted: (phoneAuthCredential) async {
                //           setState(() {
                //             showLoading = false;
                //             signInWithPhoneAuthCredential(phoneAuthCredential);
                //           });
                //           updateRegistrimi();
                //         },
                //         verificationFailed: (verificationFailed) async {
                //           setState(() {
                //             showLoading = false;
                //           });
                //           ScaffoldMessenger.of(context).showSnackBar(
                //               SnackBar(content: Text("Login failed")));
                //         },
                //         codeSent: (verificationId, resendingToken) async {
                //           setState(() {
                //             showLoading = false;
                //             currentState =
                //                 MobileVerificationState.SHOW_OTP_FORM_STATE;
                //             this.verificationId = verificationId;
                //           });
                //         },
                //         codeAutoRetrievalTimeout: (verificationId) async {},
                //       );
                //     },
                //     color: const Color.fromRGBO(52, 72, 172, 2),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5)),
                //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                //     child: showLoading
                //         ? Container(
                //             width: 20,
                //             height: 20,
                //             child: CircularProgressIndicator(
                //               backgroundColor: Colors.white,
                //               color: Colors.black,
                //               strokeWidth: 2,
                //             ),
                //           )
                //         : Text(
                //             "Dergo Kodin",
                //             style: TextStyle(color: Colors.white),
                //           ),
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }

  getOtpFormWidget(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                      opacity: _currentIndex == 0 ? 1 : 0,
                      duration: Duration(
                        seconds: 1,
                      ),
                      curve: Curves.linear,
                      child: Image.asset('assets/images/lajmilogo.PNG'),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                        opacity: _currentIndex == 1 ? 1 : 0,
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child: Image.asset('assets/images/lajmilogo.PNG')),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AnimatedOpacity(
                        opacity: _currentIndex == 2 ? 1 : 0,
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child: Image.asset('assets/images/lajmilogo.PNG')),
                  )
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "VERIFIKO NUMRIN",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 30,
              ),
              FadeInDown(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 500),
                child: Text(
                  "Ju lutem shenoni kodin \n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey.shade500, height: 1.5),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeInDown(
                delay: Duration(milliseconds: 400),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    controller: otpController,
                    maxLength: 6,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ju lutem mbusheni fushen!';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone_android),
                      labelText: 'Kodi i verifikimit',
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).primaryColor,
                      )),
                      focusColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FadeInDown(
                delay: Duration(milliseconds: 800),
                duration: Duration(milliseconds: 500),
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: otpController.text);

                    signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  color: const Color.fromRGBO(52, 72, 172, 2),
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  child: _isLoading
                      ? Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 3,
                            color: Colors.black,
                          ),
                        )
                      : _isVerified
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 30,
                            )
                          : Text(
                              "Verifiko",
                              style: TextStyle(color: Colors.white),
                            ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
