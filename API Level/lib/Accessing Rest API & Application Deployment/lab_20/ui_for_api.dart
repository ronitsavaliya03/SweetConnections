import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Accessing%20Rest%20API%20&%20Application%20Deployment/lab_19/user_model.dart';
import 'package:new_flutter_labs/Accessing%20Rest%20API%20&%20Application%20Deployment/lab_20/api_service.dart';
import 'package:new_flutter_labs/Accessing%20Rest%20API%20&%20Application%20Deployment/lab_20/user_details.dart';

class UiForApi extends StatefulWidget {
  const UiForApi({super.key});

  @override
  State<UiForApi> createState() => _UiForApiState();
}

class _UiForApiState extends State<UiForApi> {
  ApiService apiService= ApiService();
  TextEditingController _nameController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company Details", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: apiService.getAllUser(),
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
              return Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserDetails(id: users[index].id!)));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        users[index].companyName![0].toString(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      users[index].companyName.toString(),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("Status: ${users[index].status}"),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red,),
                            onPressed: (){
                              showDialog(context: context, builder: (context){
                                return CupertinoAlertDialog(
                                  title: Text("Delete", style: TextStyle(color: Colors.red),),
                                  content: Text("Are you sure want to delete?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await apiService.deleteUser(users[index].id.toString());
                                        setState(() {

                                        });
                                        Navigator.pop(context); // Close the dialog
                                      },
                                      child: Text("Delete", style: TextStyle(color: Colors.red),),
                                    ),
                                  ],
                                );
                              }) ;

                            },
                          ),
                          SizedBox(width: 5,),
                          IconButton(
                              onPressed: (){
                                _nameController.text=users[index].companyName!;
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Enter Text"),
                                    content: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(hintText: "Type here..."),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await apiService.updateUser(UserModel(id: users[index].id, companyName: _nameController.text));
                                          setState(() {

                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text("Update"),
                                      ),
                                    ],
                                  );
                                }) ;

                              }
                          , icon: Icon(Icons.edit, color: Colors.grey,))
                        ],
                      ),
                    )
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: (){
        showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text("Enter Text"),
            content: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Type here..."),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  await apiService.addUser(UserModel(id: "12345", companyName: _nameController.text));
                  _nameController.clear();
                  setState(() {

                  });
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("Add"),
              ),
            ],
          );
        }) ;
      }),
    );
  }
}
