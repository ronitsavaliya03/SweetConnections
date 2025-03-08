import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_app/screens/user_list.dart';
import 'package:matrimonial_app/user%20model/constants.dart';
import 'package:num_to_words/num_to_words.dart';
import 'package:sqflite/sqflite.dart';

import '../database/my_database.dart';
import '../user model/constants.dart';
import '../user model/user.dart';


class AddEditScreen extends StatefulWidget {
  Map<String, dynamic>? data;

  /// The [id] of the user to be edited; if null, a new user will be created.
  final int? id;

  AddEditScreen({Key? key, this.data, this.id}) : super(key: key);

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
  List<String> _hobbies = ["Reading", "Traveling", "Gaming", "Sports", "Horse Riding"];
  final TextEditingController _otherHobbies = TextEditingController();
  String? _selectedCity = 'New York';
  bool isHide = true;
  List<String> cities = [
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
  Set<String> _selectedHobbies = {};

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      print(widget.data);
      loadUserData();
    }
  }

  Future<void> loadUserData() async {
    if (widget.data != null) {
      _fullNameController.text = widget.data![NAME] ?? '';
      _emailController.text = widget.data![EMAIL] ?? '';
      _mobileController.text = widget.data![PHONE] ?? '';
      _dobController.text = widget.data![DOB] ?? '';
      _selectedGender = widget.data![GENDER] ?? '';
      _selectedCity = widget.data![CITY] ?? '';
      _passwordController.text = widget.data![PASSWORD] ?? '';
      _confirmPasswordController.text = widget.data![CON_PASS] ?? '';
      _educationController.text = widget.data![EDUCATION] ?? '';
      _occupationController.text = widget.data![OCCUPATION] ?? '';
      _workPlaceController.text = widget.data![WORK_PLACE] ?? '';
      _incomeController.text = widget.data![INCOME].toString() ?? '';

      // Load hobbies with debugging logs
      String hobbiesRaw = widget.data?[HOBBIES] ?? '';
      print("Raw hobbies from database: $hobbiesRaw");

      List<String> fetchedHobbies = hobbiesRaw.split(',').map((h) => h.trim()).where((h) => h.isNotEmpty).toList();
      print("Parsed hobbies: $fetchedHobbies");

      _selectedHobbies.clear();
      _selectedHobbies.addAll(fetchedHobbies);

      // Ensure dynamically added hobbies appear in selection
      for (var hobby in fetchedHobbies) {
        if (!_hobbies.contains(hobby)) {
          _hobbies.add(hobby);
        }
      }

      print("Final hobbies list: $_hobbies");
      print("Selected hobbies: $_selectedHobbies");
    } else {
      _setDefaultDate();
      _dobController.text = "00/00/0000";
    }

    setState(() {}); // Ensure UI updates
  }

  //region HELPER METHODS
  Future<bool> validateCurrentPage() async {
    return _formKey.currentState?.validate() ?? true;
  }

  void _setDefaultDate() {
    DateTime defaultDate = DateTime.now().subtract(Duration(
      days: _selectedGender == 'Male' ? 21 * 365 : 18 * 365,
    ));
    _dobController.text =
        "${defaultDate.day.toString().padLeft(2, '0')}/${defaultDate.month.toString().padLeft(2, '0')}/${defaultDate.year}";
  }

  String _incomeInWords = "";
  String _convertNumberToWords(int number) {
    return number.toWords();
  }

  void _onIncomeChanged(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^0-9.]'), '');

    if (digitsOnly.isNotEmpty) {
      int income = int.parse(digitsOnly);
      String formattedIncome = NumberFormat.decimalPattern().format(income);

      setState(() {
        _incomeController.value = TextEditingValue(
          text: formattedIncome,
          selection: TextSelection.collapsed(offset: formattedIncome.length),
        );

        _incomeInWords = _convertNumberToWords(income);
      });
    } else {
      setState(() {
        _incomeInWords = "";
      });
    }
  }
  //endregion

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
              _buildGenderSelector(),
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
              _buildHobbiesSelector(),
              const SizedBox(height: 10),
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[\d,]*\.?\d*$')), // Only allow digits and commas
                ],
                onChanged: _onIncomeChanged,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Annual Income is required";
                  }

                  String sanitizedValue = value.replaceAll(',', '');

                  if (double.tryParse(sanitizedValue) == null) {
                    return "Enter a valid income amount";
                  }

                  return null;
                },
              ),
              if (_incomeInWords.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _incomeInWords,
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
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
                obscureText: isHide,
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
                                horizontal: 18, vertical: 8)),
                      ),
                      SizedBox(width: 25,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 136, 14, 79),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 35, vertical: 10),
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


  // region CUSTOMIZE WIDGETS
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
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: max,
      maxLengthEnforcement: MaxLengthEnforcement.none, // Prevents blocking input
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.9), // Reduce opacity
        ),
        counterText: "", // Hides the "0/10" label
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: cities.contains(_selectedCity) ? _selectedCity : (cities.isNotEmpty ? cities.first : null),
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
          children: _hobbies.map((hobby) => _buildHobbyChip(hobby)).toList(),
        ),
        _buildHobbyTextField(),
      ],
    );
  }

  Widget _buildHobbyChip(String hobby) {
    final isSelected = _selectedHobbies.contains(hobby);
    return ChoiceChip(
      label: Text(hobby),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedHobbies.add(hobby);
          } else {
            _selectedHobbies.remove(hobby);
          }
        });
      },
    );
  }

  Widget _buildHobbyTextField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _otherHobbies,
            decoration: InputDecoration(
              labelText: 'Other Hobbies',
              hintText: 'Enter Other hobbies you have..(optional)',
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.check, color: Colors.green),
          onPressed: () {
            String newHobby = _otherHobbies.text.trim();
            if (newHobby.isNotEmpty && !_hobbies.contains(newHobby)) {
              setState(() {
                _hobbies.add(newHobby);
                _otherHobbies.clear();
              });
            }
          },
        ),
      ],
    );
  }
  //endregion

  void _selectDate() async {
    DateTime today = DateTime.now();
    int minAge = _selectedGender == 'Male' ? 21 : 18;

    DateTime latestSelectableDate = today.subtract(Duration(days: minAge * 365));
    DateTime oldestSelectableDate = today.subtract(Duration(days: 80 * 365));

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: latestSelectableDate,
      firstDate: oldestSelectableDate,
      lastDate: latestSelectableDate,
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat("dd/MM/yyyy").format(pickedDate);
      });
    } else {
      print("No date selected");
    }
  }

  void _submitForm() async {
    DateFormat format = DateFormat("dd/MM/yyyy");
    DateTime birthDate = format.parse(_dobController.text);

    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> map = {
        NAME: _fullNameController.text.trim(),
        EMAIL: _emailController.text.trim(),
        PHONE: _mobileController.text.trim(),
        CITY: _selectedCity,
        DOB: _dobController.text.trim(),
        GENDER: _selectedGender,
        HOBBIES: _selectedHobbies.join(', '),
        OTH_HOBBIES: _otherHobbies.text.trim(),
        EDUCATION: _educationController.text.trim(),
        OCCUPATION: _occupationController.text.trim(),
        WORK_PLACE: _workPlaceController.text.trim(),
        INCOME: double.parse(_incomeController.text.replaceAll(',', '')),
        PASSWORD: _passwordController.text,
        CON_PASS: _confirmPasswordController.text,
        AGE: age,
        ISLIKED: 0,
      };

      try {
        if (widget.data == null) {
          await DatabaseHelper.instance.createUser(map);
        } else {
          if (widget.data != null && widget.data![ID] != null) {
            map[ID] = widget.data![ID];
          } else {
            throw Exception("User ID is missing for update.");
          }

          await DatabaseHelper.instance.updateUser(map);
        }

        if (mounted) {
          Navigator.pop(context, map);
        }
      } catch (e) {
        String errorMessage = e.toString();
        if (e is DatabaseException) {
          errorMessage = 'Database error: $errorMessage';
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    }
  }

  void _clearForm() {
    if (_formKey.currentState?.mounted ?? false) {
      _formKey.currentState!.reset(); // Only reset if formKey is valid
    }

    _fullNameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _dobController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _educationController.clear();
    _occupationController.clear();
    _workPlaceController.clear();
    _incomeController.clear();
    _otherHobbies.clear();

    _selectedGender = null;
    _selectedCity = cities.isNotEmpty ? cities.first : null;
    _selectedHobbies = {};

    if (mounted) {
      setState(() {});
    }
  }
}


