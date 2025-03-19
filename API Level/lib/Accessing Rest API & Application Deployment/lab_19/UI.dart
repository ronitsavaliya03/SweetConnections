import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Accessing%20Rest%20API%20&%20Application%20Deployment/lab_19/user_model.dart';

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  Future<List<UserModel>> getList() async {
    List<UserModel> user = [];
    String response = await DefaultAssetBundle.of(context).loadString('json_files/data.json');
    List<dynamic> data = jsonDecode(response);

    user = data.map((element) => UserModel.toUser(element)).toList();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: getList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users available"));
          }

          List<UserModel> users = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      users[index].id.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    users[index].companyName.toString(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text("User ID: ${users[index].id}"),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                ),
              );
            },
          );
        },
      ),
    );
  }
}