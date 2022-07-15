import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../navbar.dart';
import '../register.dart';

class FullRegister extends StatefulWidget {
  const FullRegister({Key? key}) : super(key: key);

  @override
  _FullRegisterState createState() => _FullRegisterState();
}

class _FullRegisterState extends State<FullRegister> {
  String? dropDownValue;
  String? dropDownValue2;
  String? dropDownValue3;
  String? dropDownValue4;
  String? dropDownValue5;
  List<String> gender = [
    'Mashkull',
    'Femer',
  ];
  List<String> punsimi = [
    'I punësuar',
    'I pa punësuar',
  ];
  List<String> qytetet = [
    'Deçan',
    'Dragash',
    'Ferizaj',
    'Fushë Kosovë',
    'Gjakovë',
    'Gjilan',
    'Gllogoc',
    'Graçanicë',
    'Hani i Elezit',
    'Istog',
    'Junik',
    'Kamenicë',
    'Kaçanik',
    'Klinë',
    'Kllokot',
    'Leposaviq',
    'Lipjan',
    'Malishevë',
    'Mamushë',
    'Mitrovicë Verior',
    'Mitrovicë',
    'Novobërdë',
    'Obiliq',
    'Partesh',
    'Pejë',
    'Podujevë',
    'Prishtinë',
    'Prizren',
    'Rahovec',
    'Ranillug',
    'Shtime',
    'Shtërpcë',
    'Skenderaj',
    'Suharekë',
    'Viti',
    'Vushtrri',
    'Zubin Potok',
    'Zveçan',
  ];
  List vendbanimet = [];

  getVendabanimet() async {
    var lista = await FirebaseFirestore.instance
        .collection('cities')
        .where('Komuna', isEqualTo: _location)
        .get();
    setState(() {
      vendbanimet = lista.docs[0]['Lagjet'];
    });
  }

  List shtetet = [];

  getStates() async {
    var sh = await FirebaseFirestore.instance.collection('states').get();
    setState(() {
      shtetet = sh.docs[0]['Shtetet'] as List;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getStates();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  bool _isVerified = false;
  bool _isLoading = false;

  String? value2;

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

  setFilters() {
    setState(() {
      dropDownValue = gender[1];
      dropDownValue2 = qytetet[2];
      dropDownValue3 = punsimi[3];
      dropDownValue4 = vendbanimet[4];
      dropDownValue5 = shtetet[5];
    });
  }

  //Firebase
  var _isLogin = true;
  var _name = '';
  var _location = null;
  var _gender = null;
  var _workingstatus = null;
  var _vendi = null;
  var _shteti = null;
  var _komuna = null;

  TextEditingController dateinput = TextEditingController();

  updateRegistrimi() async {
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    await FirebaseFirestore.instance.collection('users').doc(osUserID).update({
      'name': _name,
      'birthday': dateinput.text,
      'location': _location,
      'address': _vendi,
      'gender': _gender,
      'workingstatus': _workingstatus,
      'shteti': _shteti,
    });
  }

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    getVendabanimet();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(30),
              width: double.infinity,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FadeInDown(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavBar(false,)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  FadeInDown(
                    child: Text(
                      'Regjistrohu',
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
                        'Ju lutemi shenoni te dhenat tuaja.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Stack(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if ((value!.isEmpty)) {
                                return 'Ju lutem mbusheni fushen!';
                              }
                              return null;
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: 'Emri dhe Mbiemri',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              prefixIcon: Icon(
                                Iconsax.user,
                                color: Colors.black,
                                size: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onChanged: (value) {
                              _name = value;
                            },
                            onSaved: (value) {
                              _name = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: TextFormField(
                        validator: (value) {
                          if ((value.toString().isEmpty)) {
                            return 'Ju lutem mbusheni fushen!';
                          }
                          return null;
                        }, //editing controller of this TextField
                        // controller: _birthday,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0.0),
                          prefixIcon: Icon(
                            Iconsax.calendar,
                            color: Colors.black,
                            size: 18,
                          ), //icon of text field
                          labelText: "Datelindja",
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          floatingLabelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade200, width: 1.5),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        controller: dateinput,
                        onChanged: (value) {
                          dateinput.text = value;
                        },
                        onSaved: (value) {
                          dateinput.text = value!;
                        },
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              String formattedDate =
                                  DateFormat.yMMMd().format(date).toString();
                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            },
                            currentTime: DateTime.now(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Stack(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: 'Shteti',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              prefixIcon: Icon(
                                Iconsax.location,
                                color: Colors.black,
                                size: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if ((value == null)) {
                                return 'Ju lutem mbusheni fushen!';
                              }
                              return null;
                            },
                            onSaved: (dropDownValue5) {
                              _shteti = dropDownValue5!;
                            },
                            onChanged: (dropDownValue5) {
                              _shteti = dropDownValue5;
                            },
                            items: shtetet
                                .map((
                                  shtetetTitle,
                                ) =>
                                    DropdownMenuItem(
                                        value: shtetetTitle,
                                        child: Text("$shtetetTitle")))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_shteti == 'Kosova')
                    FadeInDown(
                      delay: Duration(milliseconds: 400),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Stack(
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                labelText: 'Komuna',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                                prefixIcon: Icon(
                                  Iconsax.location,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if ((value == null)) {
                                  return 'Ju lutem mbusheni fushen!';
                                }
                                return null;
                              },
                              onSaved: (dropDownValue2) {
                                _location = dropDownValue2!;
                              },
                              onChanged: (dropDownValue2) {
                                setState(() {
                                  _location = dropDownValue2;
                                });
                              },
                              items: qytetet
                                  .map((
                                    qytetetTitle,
                                  ) =>
                                      DropdownMenuItem(
                                          value: qytetetTitle,
                                          child: Text("$qytetetTitle")))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  if (_location != null &&
                      _shteti == 'Kosova' &&
                      _komuna == null)
                    FadeInDown(
                      delay: Duration(milliseconds: 400),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Stack(
                          children: [
                            DropdownButtonFormField(
                              key: Key(_location),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                labelText: 'Vendbanimet',
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                                prefixIcon: Icon(
                                  Iconsax.location,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                floatingLabelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.5),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              validator: (value) {
                                if ((value != null)) {
                                  return 'Ju lutem mbusheni fushen!';
                                }
                                return null;
                              },
                              onSaved: (dropDownValue4) {
                                _vendi = dropDownValue4!;
                              },
                              onChanged: (dropDownValue4) {
                                _vendi = dropDownValue4;
                              },
                              items: vendbanimet
                                  .map((
                                    vendbanimetTitle,
                                  ) =>
                                      DropdownMenuItem(
                                          value: vendbanimetTitle,
                                          child: Text("$vendbanimetTitle")))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Stack(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: 'Statusi i Punes',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              prefixIcon: Icon(
                                Iconsax.personalcard,
                                color: Colors.black,
                                size: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if ((value == null)) {
                                return 'Ju lutem mbusheni fushen!';
                              }
                              return null;
                            },
                            value: dropDownValue3,
                            onChanged: (dropDownValue3) {
                              _workingstatus = dropDownValue3;
                            },
                            onSaved: (dropDownValue2) {
                              _workingstatus = dropDownValue3!;
                            },
                            items: punsimi
                                .map((punsimiTitle) => DropdownMenuItem(
                                    value: punsimiTitle,
                                    child: Text("$punsimiTitle")))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 400),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Stack(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0.0),
                              labelText: 'Gjinia',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              prefixIcon: Icon(
                                Iconsax.user_cirlce_add,
                                color: Colors.black,
                                size: 18,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 1.5),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onSaved: (value) {
                              _gender = value!;
                            },
                            validator: (value) {
                              if ((value == null)) {
                                return 'Ju lutem mbusheni fushen!';
                              }
                              return null;
                            },
                            value: dropDownValue,
                            onChanged: (dropDownValue3) {
                              _gender = dropDownValue3;
                            },
                            items: gender
                                .map((genderTitle) => DropdownMenuItem(
                                    value: genderTitle,
                                    child: Text("$genderTitle")))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInDown(
                    delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 500),
                    child: MaterialButton(
                      elevation: 0,
                      onPressed: () async {
                      
                        updateRegistrimi();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
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
                                  "Vazhdo",
                                  style: TextStyle(color: Colors.white),
                                ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
