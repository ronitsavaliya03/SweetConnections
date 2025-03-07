import 'package:flutter/material.dart';

class ReportsComplaintsScreen extends StatefulWidget {
  @override
  _ReportsComplaintsScreenState createState() => _ReportsComplaintsScreenState();
}

class _ReportsComplaintsScreenState extends State<ReportsComplaintsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports & Complaints", style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: "User Reports"),
            Tab(text: "Chat Complaints"),
            Tab(text: "Resolution Center"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UserReportsTab(),
          ChatComplaintsTab(),
          ResolutionCenterTab(),
        ],
      ),
    );
  }
}

class UserReportsTab extends StatelessWidget {
  final List<Map<String, String>> userReports = [
    {"name": "John Doe", "reason": "Fake Account"},
    {"name": "Jane Smith", "reason": "Harassment"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userReports.length,
      itemBuilder: (context, index) {
        var report = userReports[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.person, color: Colors.redAccent),
            title: Text(report["name"]!),
            subtitle: Text("Reason: ${report["reason"]}"),
            trailing: ElevatedButton(
              onPressed: () {
              },
              child: Text("Resolve"),
            ),
          ),
        );
      },
    );
  }
}

class ChatComplaintsTab extends StatelessWidget {
  final List<Map<String, String>> chatComplaints = [
    {"user": "Mike", "message": "Offensive Message"},
    {"user": "Sara", "message": "Spam & Scams"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatComplaints.length,
      itemBuilder: (context, index) {
        var complaint = chatComplaints[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.chat_bubble_outline, color: Colors.orange),
            title: Text(complaint["user"]!),
            subtitle: Text("Issue: ${complaint["message"]}"),
            trailing: ElevatedButton(
              onPressed: () {
              },
              child: Text("Review"),
            ),
          ),
        );
      },
    );
  }
}

class ResolutionCenterTab extends StatelessWidget {
  final List<Map<String, String>> resolutionCases = [
    {"case": "John Doe", "status": "Pending"},
    {"case": "Sara", "status": "Resolved"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: resolutionCases.length,
      itemBuilder: (context, index) {
        var caseItem = resolutionCases[index];
        return Card(
          child: ListTile(
            leading: Icon(Icons.gavel, color: Colors.blueAccent),
            title: Text(caseItem["case"]!),
            subtitle: Text("Status: ${caseItem["status"]}"),
            trailing: ElevatedButton(
              onPressed: () {
              },
              child: Text(caseItem["status"] == "Pending" ? "Resolve" : "View"),
            ),
          ),
        );
      },
    );
  }
}
