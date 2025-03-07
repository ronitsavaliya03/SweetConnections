import 'package:flutter/material.dart';

class NotificationsMessagingScreen extends StatefulWidget {
  @override
  _NotificationsMessagingScreenState createState() => _NotificationsMessagingScreenState();
}

class _NotificationsMessagingScreenState extends State<NotificationsMessagingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _messageController = TextEditingController();
  final List<String> sentMessages = ["Here is an offer! flat 50% off for new candidates so tell your family & friends", "Hey! Can you find your match? "];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void sendNotification(String message) {
    if (message.isNotEmpty) {
      setState(() {
        sentMessages.add(message);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Notification sent successfully!")),
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications & Messaging", style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "Announcements"),
            Tab(text: "Bulk Messaging"),
            Tab(text: "Sent Messages"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AnnouncementTab(onSend: sendNotification),
          BulkMessagingTab(onSend: sendNotification),
          SentMessagesTab(messages: sentMessages),
        ],
      ),
    );
  }
}

class AnnouncementTab extends StatelessWidget {
  final Function(String) onSend;
  final TextEditingController _controller = TextEditingController();

  AnnouncementTab({required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: "Enter Announcement"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSend(_controller.text);
            },
            child: Text("Send Announcement"),
          ),
        ],
      ),
    );
  }
}

class BulkMessagingTab extends StatelessWidget {
  final Function(String) onSend;
  final TextEditingController _controller = TextEditingController();

  BulkMessagingTab({required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: "Enter Message for Users"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSend(_controller.text);
            },
            child: Text("Send Bulk Message"),
          ),
        ],
      ),
    );
  }
}

class SentMessagesTab extends StatelessWidget {
  final List<String> messages;

  SentMessagesTab({required this.messages});

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Center(child: Text("No messages sent yet."))
        : ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(Icons.notifications_active, color: Colors.blue),
            title: Text(messages[index]),
          ),
        );
      },
    );
  }
}
