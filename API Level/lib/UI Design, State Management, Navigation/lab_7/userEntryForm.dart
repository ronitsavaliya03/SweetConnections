import 'package:flutter/material.dart';

import '../../Static CRUD/constants.dart';

class UserEntryFormPage extends StatefulWidget {
  Map<String,dynamic>? data ;
  UserEntryFormPage({super.key,this.data});

  @override
  State<UserEntryFormPage> createState() => _UserEntryFormPageState();
}

class _UserEntryFormPageState extends State<UserEntryFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  List<String> cities = ['London', 'Singapore', 'California', 'Oslo', 'Berlin'];
  String? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.data != null){
      nameController.text = widget.data![NAME];
      emailController.text = widget.data![EMAIL];
      phoneController.text = widget.data![PHONE];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Registration',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Valid Name';
                  }
                  return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Email Address';
                  }
                  if (!RegExp(
                          r'^(^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$)'
                  )
                      .hasMatch(value)) {
                    return 'Enter Valid Email address';
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Phone Number';
                  }
                  if (value.length != 10) {
                    return 'Enter Valid Phone Number';
                  }
                  return null;
                },
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Phone',
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButton(
                borderRadius: BorderRadius.circular(20.0),
                hint: Text("City"),
                value: selectedCity,
                items: cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  print('IS VALIDATE : ${_formKey.currentState!.validate()}');
                  Map<String, dynamic> map = {};
                  map[NAME] = nameController.text.toString();
                  map[EMAIL] = emailController.text.toString();
                  map[PHONE] = phoneController.text.toString();
                  map[CITY] = selectedCity.toString();
                  Navigator.pop(context,map);
                },
                child: Text(
                 widget.data != null ?  'Edit' : 'Create',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
