import 'package:flutter/material.dart';
import 'package:new_flutter_labs/API%20CRUD/api_service.dart';

class UIForApiCRUD extends StatefulWidget {
  const UIForApiCRUD({super.key});

  @override
  State<UIForApiCRUD> createState() => _UIForApiCRUDState();
}

class _UIForApiCRUDState extends State<UIForApiCRUD> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> users = [];

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    users = await apiService.getUsers();
    setState(() {});
  }

  Future<void> _showUserForm({Map<String, dynamic>? user}) async {
    nameController.text = user?['Name'] ?? '';

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(user == null ? "Add User" : "Edit User"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final userData = {"Name": nameController.text.trim()};

              if (user == null) {
                await apiService.createUser(userData);
              } else {
                await apiService.updateUser(int.parse(user['User_id']), userData);
              }

              Navigator.pop(context);
              _fetchUsers(); // Refresh the list
            },
            child: Text(user == null ? "Add" : "Update"),
          )
        ],
      ),
    );
  }

  Future<void> _deleteUser(int id) async {
    await apiService.deleteUser(id);
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API CRUD")),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['Name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showUserForm(user: user),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteUser(int.parse(user['User_id'])),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUserForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
