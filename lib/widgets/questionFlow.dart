import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lajmi.net/navbar.dart';
import 'package:lajmi.net/widgets/end_text.dart';
import 'package:lajmi.net/widgets/redirect_to_question.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Questions extends StatefulWidget {
  Questions({
    Key? key,
    required this.title,
    required this.endText,
    required this.questions,
    required this.startText,
    required this.id,
  }) : super(key: key);

  final String title;
  final String startText;
  final String endText;
  final List questions;
  final String id;
  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  var index = 0;
  Map Answers = {};
  var DeviceId;
  var validator = false;

  int i = 0;
  List<int> flowList = [];
  List<int> questionList = [];
  List<int> ques = [];

  void getValidator(bool checkValidator) {
    setState(() {
      validator = checkValidator;
    });
  }

  void saveAnswers(dynamic questionId, String answer) {
    Answers[questionId.toString()] = answer;
  }

  void saveQuestion() {
    // var answer = Answers.entries.map((e) => e.value).last;
    var questionId = Answers.entries.map((e) => e.key).last;
    var itemFlow;

    var questionIdInt = int.parse(questionId.toString().split('.')[0]);

    var questions = widget.questions.asMap().entries.map((e) => e.key);

    if (questionList.isEmpty) {
      for (var quest in questions) {
        itemFlow = int.parse(quest.toString().split('.')[0]);
        questionList.add(itemFlow);
      }
    }
    questionList.sort();
  }

  Future<void> initPlatformState() async {
    String? deviceId;
  
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    
    if (!mounted) return;

    setState(() {
      DeviceId = deviceId!;
    });
  }

  @override
  void initState() {
    getValidator(validator);

    initPlatformState();
    super.initState();
  }

  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(52, 72, 172, 2),
        centerTitle: true,
        title: Text(
          'lajmi.net',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              insetPadding: EdgeInsets.zero,
              content: Container(
                width: 100,
                height: 40,
                child: const Text(
                  'A jeni të sigurt që dëshironi\ntë mbyllni këtë pyetësor?',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Jo'),
                      child: const Text(
                        'Jo',
                        style: TextStyle(
                          color: const Color.fromRGBO(52, 72, 172, 2),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => NavBar(true,)),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Po',
                        style: TextStyle(
                          color: const Color.fromRGBO(52, 72, 172, 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              elevation: 24.0,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          controller: scrollController,
          key: Key(widget.questions[index].toString()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RedirectToQuestion(
                question: widget.questions[index],
                label: widget.questions[index]['label'],
                id: widget.id,
                saveAnswers: saveAnswers,
                getValidator: getValidator,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    validator
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(52, 72, 172, 2)),
                            onPressed: () {
                              setState(() {
                                validator = false;
                                saveQuestion();

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EndText(
                                      title: widget.title,
                                      endText: widget.endText,
                                      Answers: Answers,
                                      DeviceId: DeviceId,
                                      sondazhiId: widget.id,
                                      questionId: widget.id,
                                    ),
                                  ),
                                );
                              });
                              scrollController.jumpTo(0.0);
                            },
                            child: Text('VAZHDO'),
                          )
                        : ElevatedButton(
                            child: Text('VAZHDO'),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[100]),
                            onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
