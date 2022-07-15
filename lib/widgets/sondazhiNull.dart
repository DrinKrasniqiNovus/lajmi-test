import 'package:flutter/material.dart';

class sondazhiNull extends StatefulWidget {
  sondazhiNull({Key? key}) : super(key: key);

  @override
  State<sondazhiNull> createState() => _sondazhiNullState();
}

class _sondazhiNullState extends State<sondazhiNull> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'lajmi.net',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(52, 72, 172, 2),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Për momentin nuk ka ndonjë sondazh aktiv!',
                style: TextStyle(fontSize: 15, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
