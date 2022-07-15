import 'package:flutter/material.dart';
import 'package:lajmi.net/widgets/MultipleQuestion.dart';
import 'package:lajmi.net/widgets/grid_question.dart';
import 'package:lajmi.net/widgets/single_question.dart';

class RedirectToQuestion extends StatefulWidget {
  RedirectToQuestion({
    Key? key,
    required this.question,
    required this.label,
    required this.id,
    required this.saveAnswers,
    required this.getValidator,
  }) : super(key: key);

  final Map question;
  final String label;

  final String id;
  Function(dynamic, String) saveAnswers;
  Function(bool) getValidator;

  @override
  State<RedirectToQuestion> createState() => _RedirectToQuestionState();
}

class _RedirectToQuestionState extends State<RedirectToQuestion> {
  @override
  Widget build(BuildContext context) {
    if (widget.question['type'] == 'SS') {
      return SingleQuestion(
        key: Key(widget.question['question'][0]['id'].toString()),
        question: widget.question,
        sondazhiId: widget.id,
        saveAnswers: widget.saveAnswers,
        getValidator: widget.getValidator,
      );
    } else if (widget.question['type'] == 'MS') {
      return MultipleQuestion(
        key: Key(widget.question['question'][0]['id'][0]),
        question: widget.question,
        sondazhiId: widget.id,
        saveAnswers: widget.saveAnswers,
        getValidator: widget.getValidator,
      );
    } else if (widget.question['type'] == 'GS') {
      return GridQuestion(
        key: Key(widget.question['question'][0]['id'].toString()),
        question: widget.question,
        label: widget.question['label'],
        sondazhiId: widget.id,
        saveAnswers: widget.saveAnswers,
        getValidator: widget.getValidator,
      );
    } else {
      return Container(child: Text('0 QUESTIONS'));
    }
  }
}
