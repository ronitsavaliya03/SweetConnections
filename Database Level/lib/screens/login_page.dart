import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matrimonial_app/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  bool isHide= false;

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) { // Validate inputs
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', _emailController.text.trim()); // Save email
      await prefs.setString('userName', _fullNameController.text.trim()); // Save email

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  String? _validateName(String? value){
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }

    int letterCount =
        value.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;

    if (letterCount < 3) {
      return "Name must have at least 3 letters";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: Color(0xFF7B1E4A),
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Text(
                      "Soulmate",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Where True Love Finds You",
                      style: TextStyle(fontSize: 22, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              // Login Card
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              prefixIcon:
                              Icon(Icons.person, color: Colors.pink),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                              TextInputFormatter.withFunction((oldValue, newValue) {
                                if (newValue.text.isEmpty) return newValue;

                                String capitalizedText = newValue.text
                                    .split(' ')
                                    .map((word) => word.isNotEmpty
                                    ? word[0].toUpperCase() + word.substring(1)
                                    : '')
                                    .join(' ');

                                return newValue.copyWith(
                                  text: capitalizedText,
                                  selection: TextSelection.collapsed(offset: capitalizedText.length),
                                );
                              }),
                            ],
                            validator: _validateName
                          ),
                          SizedBox(height: 15),
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon:
                              Icon(Icons.email, color: Colors.pink),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 15),
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: isHide,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon:
                              Icon(Icons.lock, color: Colors.pink),
                              suffixIcon: IconButton(
                                icon: Icon(!isHide ? Icons.visibility : Icons.visibility_off, size: 20,),
                                onPressed: () {
                                  setState(() {
                                    isHide = !isHide;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: _validatePassword,
                          ),
                          SizedBox(height: 20),
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Colors.pinkAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () => _handleLogin(context),
                              child: Text("Login",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Forgot Password & Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text("Forgot Password?",
                                    style: TextStyle(color: Colors.purple)),
                              ),
                              TextButton(
                                onPressed: () => _handleGuestLogin(context),
                                child: Text("As Guest",
                                    style: TextStyle(color: Colors.purple)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Future<void> _handleGuestLogin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userEmail', 'guest@example.com'); // Default guest email
  await prefs.setString('userName', 'Guest User'); // Default guest name

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}
