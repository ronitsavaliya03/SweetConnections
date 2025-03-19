import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Accessing%20Rest%20API%20&%20Application%20Deployment/lab_19/user_model.dart';
import 'package:new_flutter_labs/Accessing%20Rest%20API%20&%20Application%20Deployment/lab_20/api_service.dart';

class UserDetails extends StatelessWidget {
  String id;
  UserDetails({super.key, required this.id});

  ApiService apiService= ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: apiService.getUserById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          UserModel user= snapshot.data!;
          return SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.companyName.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Date: ${user.date.toString()}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Amount: \$${user.amount.toString()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: user.status.toString() == "deposit" ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.description.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Chip(
                      label: Text(
                        user.status.toString().toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: user.status.toString() == "deposit" ? Colors.green : Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
