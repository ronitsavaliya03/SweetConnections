import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  List<Map<String, String>> faqList = [
    {"question": "How does the matchmaking work?", "answer": "Our system finds the best match based on your preferences."},
    {"question": "Is my data secure?", "answer": "Yes, we use encryption to protect your personal details."},
    {"question": "How do I report a fake profile?", "answer": "Go to the user profile and click on 'Report'."},
  ];

  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();

  void addFAQ() {
    if (questionController.text.isNotEmpty && answerController.text.isNotEmpty) {
      setState(() {
        faqList.add({
          "question": questionController.text,
          "answer": answerController.text,
        });
      });
      questionController.clear();
      answerController.clear();
      Navigator.pop(context);
    }
  }

  void deleteFAQ(int index) {
    setState(() {
      faqList.removeAt(index);
    });
  }

  void showAddFAQDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Add FAQ"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoTextField(
                  controller: questionController,
                  placeholder: "Enter Question",
                  padding: EdgeInsets.all(12),
                ),
                SizedBox(height: 10,),
                CupertinoTextField(
                  controller: answerController,
                  placeholder: "Enter Answer",
                  padding: EdgeInsets.all(12),
                ),
              ],
            ),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: addFAQ,
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ & Help Center", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ExpansionTile(
                      title: Text(
                        faqList[index]["question"]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(faqList[index]["answer"]!),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){
                              showDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text('Delete'),
                                  content: Text('Are you sure you want to delete?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          faqList.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('No'),
                                    ),
                                  ],
                                ),
                              );
                            }, icon: Icon(Icons.delete, color: Colors.red,))
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: showAddFAQDialog,
              icon: Icon(Icons.add),
              label: Text("Add FAQ"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 136, 14, 79),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
