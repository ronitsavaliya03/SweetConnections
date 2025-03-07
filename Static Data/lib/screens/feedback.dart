import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackAndReviewsPage extends StatefulWidget {
  @override
  State<FeedbackAndReviewsPage> createState() => _FeedbackAndReviewsPageState();
}

class _FeedbackAndReviewsPageState extends State<FeedbackAndReviewsPage> {
  final List<Map<String, String>> feedbackList = [
    {
      'user': 'John Doe',
      'rating': '4.5',
      'feedback': 'Great platform! Found my perfect match here.',
      'date': '2023-10-01',
    },
    {
      'user': 'Jane Smith',
      'rating': '3.0',
      'feedback': 'The app is good, but it needs more filters.',
      'date': '2023-09-28',
    },
    {
      'user': 'Alice Johnson',
      'rating': '5.0',
      'feedback': 'Amazing experience! Highly recommended.',
      'date': '2023-09-25',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback & Reviews',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            final feedback = feedbackList[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback['user']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE91E63),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 5),
                            Text(
                              feedback['rating']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Feedback Text
                    Text(
                      feedback['feedback']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Date and Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feedback['date']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.reply, color: Color(0xFFE91E63)),
                              onPressed: () {
                                _showReplyDialog(context, feedback['user']!);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                _showDeleteConfirmation(context, index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showReplyDialog(BuildContext context, String user) {
    TextEditingController replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Reply to $user'),
          content: Column(
            children: [
              CupertinoTextField(
                controller: replyController,
                placeholder: 'Type your reply...',
                maxLines: 3,
                padding: EdgeInsets.all(12),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                final reply = replyController.text;
                if (reply.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reply sent to $user'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Send', style: TextStyle(color: Color(0xFFE91E63))),
            ),
          ],
        );

      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Delete Feedback'),
          content: Text('Are you sure you want to delete this feedback?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                // Handle deletion
                setState(() {
                  feedbackList.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Feedback deleted successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}