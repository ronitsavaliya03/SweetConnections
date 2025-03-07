import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_app/screens/user_list.dart';
import 'package:matrimonial_app/user%20model/constants.dart';

class AddEditScreen extends StatefulWidget {
  Map<String, dynamic>? data;

  AddEditScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _workPlaceController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();

  String? _selectedGender;
  List<String> _hobbies = [];
  final TextEditingController _otherHobbies = TextEditingController();
  String? _selectedCity;
  bool isHide = true;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      _fullNameController.text = widget.data![NAME] ?? '';
      _emailController.text = widget.data![EMAIL] ?? '';
      _mobileController.text = widget.data![PHONE] ?? '';
      _dobController.text = widget.data![DOB] ?? '';
      _selectedGender = widget.data![GENDER] ?? '';
      _selectedCity = widget.data![CITY] ?? '';
      _hobbies = List<String>.from(widget.data![HOBBIES] ?? []);
      _passwordController.text = widget.data![PASSWORD] ?? '';
      _confirmPasswordController.text = widget.data![CON_PASS] ?? '';
      _educationController.text = widget.data![EDUCATION] ?? '';
      _occupationController.text = widget.data![OCCUPATION] ?? '';
      _workPlaceController.text = widget.data![WORK_PLACE] ?? '';
      _incomeController.text = widget.data![INCOME].toString() ?? '';
    } else {
      _setDefaultDate();
    }
  }

  void _setDefaultDate() {
    DateTime defaultDate = DateTime.now().subtract(Duration(
      days: _selectedGender == 'Male' ? 21 * 365 : 18 * 365,
    ));
    _dobController.text =
        "${defaultDate.day.toString().padLeft(2, '0')}/${defaultDate.month.toString().padLeft(2, '0')}/${defaultDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Candidate",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 136, 14, 79),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Basic Information",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 136, 14, 79)),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _fullNameController,
                label: "Full Name",
                hintText: "Enter your full name",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (newValue.text.isEmpty) return newValue;

                    // Capitalize the first letter of each word
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }

                  int letterCount =
                      value.replaceAll(RegExp(r'[^a-zA-Z]'), '').length;

                  if (letterCount < 3) {
                    return "Name must have at least 3 letters";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _emailController,
                label: "Email Address",
                hintText: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }

                  if (widget.data == null) {
                    for (int i = 0; i < user.userList.length; i++) {
                      if (user.userList[i][EMAIL] == value) {
                        return 'Already exist email';
                      }
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _mobileController,
                label: "Mobile Number",
                max: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                hintText: "Enter your mobile number",
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mobile Number is required';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _dobController,
                label: "Date of Birth",
                hintText: "Select your date of birth",
                readOnly: true,
                onTap: _selectDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date of Birth is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildCityDropdown(),
              const SizedBox(height: 10),
              _buildGenderSelector(),
              const SizedBox(height: 10),
              _buildHobbiesSelector(),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _otherHobbies,
                label: 'Other Hobbies',
                hintText: 'Enter Other hobbies you have..(optional)',
              ),
              const SizedBox(height: 20),
              Text(
                "Educational & Professional Details",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 136, 14, 79)),
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _educationController,
                label: 'Education Qualification',
                hintText: 'Enter Degree, University, Year of Passing',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Education Qualification is required";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _occupationController,
                label: 'Occupation & Job Role',
                hintText: 'Enter Occupation & Job Role',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Occupation & Job Role is required";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _workPlaceController,
                label: 'Company Name & Work Location',
                hintText: 'Enter Company Name & Work Location',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Company Name & Work Location is required";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _incomeController,
                label: 'Annual Income',
                keyboardType: TextInputType.number ,
                hintText: 'Enter Annual Income',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Annual Income is required";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _passwordController,
                label: "Password",
                hintText: "Enter your password",
                obscureText: isHide,
                suffixIcon: IconButton(
                  icon: Icon(!isHide ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isHide = !isHide;
                    });
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _confirmPasswordController,
                label: "Confirm Password",
                hintText: "Confirm your password",
                obscureText: false,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _clearForm,
                        child: Text('Clear Form',
                            style: const TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15)),
                      ),
                      SizedBox(width: 25,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 136, 14, 79),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          widget.data != null ? 'Modify' : 'Submit',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int? max,
    List<TextInputFormatter> inputFormatters =
        const [], // FIX: Set default value
    bool obscureText = false,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
    String? initialValue,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: max,
      maxLengthEnforcement: MaxLengthEnforcement.none, // Prevents blocking input
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        counterText: "", // Hides the "0/10" label
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
    );
  }

  Widget _buildCityDropdown() {
    const List<String> cities = [
      'New York',
      'Boston',
      'San Francisco',
      'Seattle',
      'Sydney',
      'Toronto',
      'Delhi',
      'Los Angeles',
      'Miami',
      'Chicago',
      'Houston',
      'Phoenix'
    ];
    return DropdownButtonFormField<String>(
      value: _selectedCity,
      items: cities
          .map((city) => DropdownMenuItem(
                value: city,
                child: Text(city),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCity = value!;
        });
      },
      decoration: const InputDecoration(
        labelText: "City",
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'City is required';
        }
        return null;
      },
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender", style: TextStyle(fontSize: 16)),
        FormField<String>(
          validator: (value) {
            if (_selectedGender == null) {
              return "Please select a gender";
            }
            return null;
          },
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                          state.didChange(value);
                          _setDefaultDate();
                        });
                      },
                    ),
                    const Text("Male"),
                    Radio<String>(
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                          state.didChange(value);
                          _setDefaultDate();
                        });
                      },
                    ),
                    const Text("Female"),
                  ],
                ),
                if (state.hasError) // Show error message if validation fails
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildHobbiesSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hobbies", style: TextStyle(fontSize: 16)),
        Wrap(
          spacing: 10,
          children: [
            _buildHobbyChip("Reading"),
            _buildHobbyChip("Traveling"),
            _buildHobbyChip("Gaming"),
            _buildHobbyChip("Sports"),
            _buildHobbyChip("Horse Riding")
          ],
        ),
      ],
    );
  }

  Widget _buildHobbyChip(String hobby) {
    final isSelected = _hobbies.contains(hobby);
    return ChoiceChip(
      label: Text(hobby),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            if (!_hobbies.contains(hobby)) _hobbies.add(hobby);
          } else {
            _hobbies.remove(hobby);
          }
        });
      },
    );
  }

  void _selectDate() async {
    DateTime today = DateTime.now();
    int minAge = _selectedGender == 'Male' ? 21 : 18;

    DateTime latestSelectableDate =
        today.subtract(Duration(days: minAge * 365));
    DateTime oldestSelectableDate = today.subtract(Duration(days: 80 * 365));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: latestSelectableDate, // Default date: minAge years ago
      firstDate: oldestSelectableDate, // 80 years ago
      lastDate: latestSelectableDate, // minAge years ago
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
    }
  }

  void _submitForm() {
    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime birthDate = format.parse(_dobController.text);

    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    _hobbies.add(_otherHobbies.text.toString());

    if (_formKey.currentState!.validate()) {
      // Create the map with user data
      Map<String, dynamic> map = {
        NAME: _fullNameController.text.toString(),
        EMAIL: _emailController.text.toString(),
        PHONE: _mobileController.text.toString(),
        CITY: _selectedCity.toString(),
        DOB: _dobController.text.toString(),
        GENDER: _selectedGender.toString(),
        HOBBIES: _hobbies,
        OTH_HOBBIES: _otherHobbies.text.toString(),
        EDUCATION: _educationController.text.toString(),
        OCCUPATION: _occupationController.text.toString(),
        WORK_PLACE: _workPlaceController.text.toString(),
        INCOME: _incomeController.text.toString(),
        PASSWORD: _passwordController.text.toString(),
        CON_PASS: _confirmPasswordController.text.toString(),
        AGE: age.toString(),
        ISLIKED: false,
      };

      if (widget.data == null) {
        setState(() {
          user.userList.insert(0, map);
        });

        Navigator.pop(context);
      } else {
        Navigator.pop(context, map);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully!")),
      );
    }
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    _fullNameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _otherHobbies.clear();
    _educationController.clear();
    _occupationController.clear();
    _workPlaceController.clear();
    _incomeController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
  }
}