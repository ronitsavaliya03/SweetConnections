import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  Contact({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController issueController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Contact Us", style: TextStyle(fontSize: 25),),
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
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
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
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Your Issue';
                  }
                  return null;
                },
                controller: issueController,
                decoration: InputDecoration(
                  labelText: 'Enter Your Issue',
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
              ElevatedButton(
                onPressed: () {
                  print('IS VALIDATE : ${_formKey.currentState!.validate()}');
                },
                child: Text(
                  'Submit',
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
