import 'package:flutter/material.dart';
import 'package:lajmi.net/widgets/start_text.dart';

class ListaSondazheve extends StatefulWidget {
  ListaSondazheve({
    Key? key,
    required this.title,
    required this.startText,
    required this.endText,
    required this.questions,
    required this.id,
    /*required this.date*/
  });
  final String title;
  final String startText;
  final String endText;
  final List questions;
  final String id;
  // final String date;
  @override
  State<ListaSondazheve> createState() => _ListaSondazheveState();
}

class _ListaSondazheveState extends State<ListaSondazheve> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        margin: EdgeInsets.only(top: 8, left: 8, right: 8),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Titulli i Pytesorit:',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 11, color: Colors.black54)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis 
                        ),
                        
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StartText(
                        title: widget.title,
                        startText: widget.startText,
                        endText: widget.endText,
                        questions: widget.questions,
                        id: widget.id,
                      )),
            );
          },
        ),
      ),
    );
  }
}
