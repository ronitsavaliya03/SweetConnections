
import 'package:flutter/material.dart';

import '../lab_9/tab_view_demo.dart';

class Validation extends StatefulWidget {
  Validation({super.key});

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  TextEditingController nameController = TextEditingController();
  TextEditingController conPassController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  bool isHide=true;
  bool isRegister=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightBlueAccent,
      //   title: Text(
      //     'Registration',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body:
      Center(
        child: Column(
          children: [
            Container(
              height: 450,
              width: 400,
              margin: EdgeInsets.all(40.0),
              decoration:  BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(isRegister?"Registration":"Login", style: TextStyle(color: Colors.white, fontSize: 30),),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Enter username";
                            }
                            else if(!RegExp(
                                r'^(?!.*\.\.)(?!.*\.$)[a-zA-Z0-9._]{1,30}$')
                                .hasMatch(value)){
                              return "Enter valid username";
                            }

                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Enter username',
                            labelStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.red,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters long";
                            }
                            return null;
                          },
                          obscureText: isHide,
                          controller: passController,
                          decoration: InputDecoration(
                            labelText: 'Enter password',
                            labelStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            suffixIcon: IconButton(icon: Icon(isHide? Icons.visibility: Icons.visibility_off),onPressed: (){
                              setState(() {
                                isHide= !isHide;
                              });
                            },),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: isRegister,
                        child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != passController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                          controller: conPassController,
                          decoration: InputDecoration(
                            labelText: 'Enter confirm password',
                            labelStyle: TextStyle(color: Colors.grey),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                print('IS VALIDATE : ${_key.currentState!.validate()}');

                                setState(() {
                                  isRegister=!isRegister;

                                });
                                if(_key.currentState!.validate()==true){
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) => TabViewDemo()));
                                }
                              },
                              child: Text(
                                !isRegister?'Login':'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print('IS VALIDATE : ${_key.currentState!.validate()}');

                                setState(() {
                                  isRegister=!isRegister;

                                });
                                if(_key.currentState!.validate()==true){
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (context) => TabViewDemo()));
                                }
                              },
                              child: Text(
                                isRegister?'Login':'Register',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}