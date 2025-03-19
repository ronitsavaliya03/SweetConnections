import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/user%20model/constants.dart';
import 'package:matrimonial_app/screens/user_list.dart';

class Information extends StatefulWidget {
  final int i;
  Information({super.key, required this.i});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchUsers();
  }

  List<dynamic> _userList = []; // List to store user data from API

  Future<void> _fetchUsers() async {
    try {
      final result = await apiService.getUsers(context);

      if (result is List<dynamic>) {
        setState(() {
          _userList = result;
          user.userList = _userList.cast<Map<String, dynamic>>().toList(); // Update global user list
          isApiCall = false;
        });
      } else {
        // Handle error from API call
        print('Error fetching users: $result');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load users: $result')));
      }
    } catch (e) {
      // Handle any exceptions during API call
      print('Exception fetching users: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Details",
          style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold,),
        ),
        backgroundColor: const Color.fromARGB(255, 136, 14, 79),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Text(
                '${user.userList[widget.i][NAME]}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${user.userList[widget.i][AGE]} years',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     IconButton(
              //         style: ButtonStyle(
              //           backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 228, 62, 151)), // Background color
              //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(15), // Rounded corners
              //             ),
              //           ),
              //           overlayColor: MaterialStateProperty.all(Colors.pinkAccent.withOpacity(0.2)), // Ripple effect
              //         ),
              //         onPressed: (() {
              //           if (user.userList[widget.i][ISLIKED] == false) {
              //             setState(() {
              //               user.userList[widget.i][ISLIKED] = true;
              //             });
              //           } else {
              //             showDialog(
              //               context: context,
              //               builder: (context) {
              //                 return CupertinoAlertDialog(
              //                   title: Text('Unlike'),
              //                   content: Text('Are you sure want to unlike?'),
              //                   actions: [
              //                     TextButton(
              //                       onPressed: () {
              //                         Navigator.pop(context);
              //                         setState(() {
              //                           user.userList[widget.i][ISLIKED] = false;
              //                         });
              //                       },
              //                       child: Text('Yes'),
              //                     ),
              //                     TextButton(
              //                       onPressed: () {
              //                         Navigator.pop(context);
              //                       },
              //                       child: Text('No'),
              //                     )
              //                   ],
              //                 );
              //               },
              //             );
              //           }
              //         }),
              //         icon: !user.userList[widget.i][ISLIKED]
              //             ? Icon(
              //           Icons.favorite_border,
              //           color: Colors.white,
              //         )
              //             : Icon(
              //           Icons.favorite,
              //           color: Colors.white,
              //         )),
              //     SizedBox(width: 10,),
              //     IconButton(
              //         style: ButtonStyle(
              //           backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 228, 62, 151)), // Background color
              //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(15), // Rounded corners
              //             ),
              //           ),
              //           overlayColor: MaterialStateProperty.all(Colors.pinkAccent.withOpacity(0.2)), // Ripple effect
              //         ),
              //         onPressed: (() {
              //           print(user.userList[widget.i][DOB]);
              //           Navigator.of(context)
              //               .push(MaterialPageRoute(
              //               builder: (context) => AddEditScreen(
              //                 data: user.userList[widget.i],
              //               )))
              //               .then((value) {
              //             if (value != null) {
              //               user.userList[widget.i] = value;
              //               setState(() {});
              //             }
              //           });
              //         }),
              //         icon: Icon(Icons.edit, color: Colors.white,)),
              //     SizedBox(width: 10,),
              //     IconButton (
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 228, 62, 151)), // Background color
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15), // Rounded corners
              //           ),
              //         ),
              //         overlayColor: MaterialStateProperty.all(Colors.pinkAccent.withOpacity(0.2)), // Ripple effect
              //       ),
              //       onPressed: () {
              //         showDialog(
              //           context: context,
              //           builder: (context) {
              //             return CupertinoAlertDialog(
              //               title: Text('DELETE'),
              //               content: Text('Are you sure want to delete?\n\nNote: If you delete from here the candidate also delete from Candidate list'),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () {
              //                     user.deleteUser(id: widget.i);
              //                     Navigator.of(context)
              //                         .push(MaterialPageRoute(
              //                         builder: (context) => UserList()));
              //                     setState(() {});
              //                   },
              //                   child: Text('Yes'),
              //                 ),
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                   },
              //                   child: Text('No'),
              //                 )
              //               ],
              //             );
              //           },
              //         );
              //       },
              //       icon: Icon(
              //         Icons.delete,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              Column(
                children: [
                  _buildSection("Basic Information", [
                    _buildInfoTile(Icons.person, "Full Name", '${user.userList[widget.i][NAME]}'),
                    _buildInfoTile(Icons.location_city, "City", '${user.userList[widget.i][CITY]}'),
                    _buildInfoTile(Icons.call, "Phone Number", '${user.userList[widget.i][PHONE]}'),
                    _buildInfoTile(Icons.email, "Email", '${user.userList[widget.i][EMAIL]}'),
                    _buildInfoTile(Icons.date_range, "Date of Birth", '${user.userList[widget.i][DOB]}'),
                    _buildInfoTile(user.userList[widget.i][GENDER]=='Male'? Icons.male: Icons.female, "Gender", '${user.userList[widget.i][GENDER]}'),
                    _buildInfoTile(Icons.interests, "Hobbies", '${user.userList[widget.i][HOBBIES].toString().replaceAll("[", "").replaceAll("]", "")}'),
                  ]),
                  _buildSection("Educational & Professional Details", [
                    _buildInfoTile(Icons.school, "Education Qualification", '${user.userList[widget.i][EDUCATION]}'),
                    _buildInfoTile(Icons.work, "Occupation & Job Role", '${user.userList[widget.i][OCCUPATION]}'),
                    _buildInfoTile(Icons.business, "Company Name & Work Location", '${user.userList[widget.i][WORK_PLACE]}'),
                    _buildInfoTile(Icons.attach_money, "Annual Income", '${user.userList[widget.i][INCOME]}'),
                  ]),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 136, 14, 79),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.pinkAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Divider(thickness: 1, height: 20,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}