import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/api%20service/api_service.dart';
import 'package:matrimonial_app/user%20model/constants.dart';
import 'package:matrimonial_app/user%20model/user.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/information.dart';
import 'package:share_plus/share_plus.dart';

User user = User();
ApiService apiService = ApiService();
bool isApiCall = true;

enum SortOption { byDefault, nameAZ, nameZA, cityAZ, cityZA }

enum AgeRange {
  range18_25,
  range26_30,
  range31_35,
  range36_40,
  range41_45,
  range46_50,
  range51_55,
  range56_60,
  range61_65,
  range66_70,
  range71_75,
  range76_80,
  all,
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final TextEditingController searchDetails = TextEditingController();

  SortOption? _selectedSort;
  AgeRange? _selectedAgeRange;

  List<dynamic> _userList = []; // List to store user data from API

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final result = await apiService.getUsers(context);

      if (result is List<dynamic>) {
        setState(() {
          _userList = result;
          user.userList = _userList
              .cast<Map<String, dynamic>>()
              .toList(); // Update global user list
          isApiCall = false;
        });
      } else {
        // Handle error from API call
        print('Error fetching users: $result');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load users: $result')));
      }
    } catch (e) {
      // Handle any exceptions during API call
      print('Exception fetching users: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }

  List<Map<String, dynamic>> get filteredUsers {
    List<Map<String, dynamic>> users =
    List.from(user.userList); // Create a modifiable copy

    if (searchDetails.text.isNotEmpty) {
      final query = searchDetails.text.toLowerCase();
      users = users.where((u) {
        return u[NAME].toLowerCase().contains(query) ||
            u[CITY].toLowerCase().contains(query) ||
            u[PHONE].toLowerCase().contains(query);
      }).toList();
    }

    // Apply Age Range Filter
    if (_selectedAgeRange != null && _selectedAgeRange != AgeRange.all) {
      users = users.where((user) {
        int age = int.tryParse(user[AGE].toString()) ?? 0;
        switch (_selectedAgeRange!) {
          case AgeRange.range18_25:
            return age >= 18 && age <= 25;
          case AgeRange.range26_30:
            return age >= 26 && age <= 30;
          case AgeRange.range31_35:
            return age >= 31 && age <= 35;
          case AgeRange.range36_40:
            return age >= 36 && age <= 40;
          case AgeRange.range41_45:
            return age >= 41 && age <= 45;
          case AgeRange.range46_50:
            return age >= 46 && age <= 50;
          case AgeRange.range51_55:
            return age >= 51 && age <= 55;
          case AgeRange.range56_60:
            return age >= 56 && age <= 60;
          case AgeRange.range61_65:
            return age >= 61 && age <= 65;
          case AgeRange.range66_70:
            return age >= 66 && age <= 70;
          case AgeRange.range71_75:
            return age >= 71 && age <= 75;
          case AgeRange.range76_80:
            return age >= 76 && age <= 80;
          default:
            return true;
        }
      }).toList();
    }

    // Apply Sorting
    switch (_selectedSort) {
      case SortOption.byDefault:
        break;
      case SortOption.nameAZ:
        users.sort((a, b) => b[NAME].compareTo(a[NAME]));
        break;
      case SortOption.nameZA:
        users.sort((a, b) => a[NAME].compareTo(b[NAME]));
        break;
      case SortOption.cityAZ:
        users.sort((a, b) => b[CITY].compareTo(a[CITY]));
        break;
      case SortOption.cityZA:
        users.sort((a, b) => a[CITY].compareTo(b[CITY]));
        break;
      default:
        break;
    }

    return users;
  }

  String _getSortLabel(SortOption option) {
    switch (option) {
      case SortOption.byDefault:
        return "Default";
      case SortOption.nameAZ:
        return "📖 Name: A → Z";
      case SortOption.nameZA:
        return "📖 Name: Z → A";
      case SortOption.cityAZ:
        return "🌍 City: A → Z";
      case SortOption.cityZA:
        return "🌍 City: Z → A";
      default:
        return "🔽 Sort Options";
    }
  }

  String _getAgeRangeLabel(AgeRange option) {
    switch (option) {
      case AgeRange.range18_25:
        return "18-25";
      case AgeRange.range26_30:
        return "26-30";
      case AgeRange.range31_35:
        return "31-35";
      case AgeRange.range36_40:
        return "36-40";
      case AgeRange.range41_45:
        return "41-45";
      case AgeRange.range46_50:
        return "46-50";
      case AgeRange.range51_55:
        return "51-55";
      case AgeRange.range56_60:
        return "56-60";
      case AgeRange.range61_65:
        return "61-65";
      case AgeRange.range66_70:
        return "66-70";
      case AgeRange.range71_75:
        return "71-75";
      case AgeRange.range76_80:
        return "76-80";
      default:
        return "All Ages";
    }
  }


  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort By'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RadioListTile<SortOption>(
                  title: const Text('Default'),
                  value: SortOption.byDefault,
                  groupValue: _selectedSort,
                  onChanged: (SortOption? value) {
                    setState(() {
                      _selectedSort = value;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                RadioListTile<SortOption>(
                  title: const Text('Name: A → Z'),
                  value: SortOption.nameAZ,
                  groupValue: _selectedSort,
                  onChanged: (SortOption? value) {
                    setState(() {
                      _selectedSort = value;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                RadioListTile<SortOption>(
                  title: const Text('Name: Z → A'),
                  value: SortOption.nameZA,
                  groupValue: _selectedSort,
                  onChanged: (SortOption? value) {
                    setState(() {
                      _selectedSort = value;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                RadioListTile<SortOption>(
                  title: const Text('City: A → Z'),
                  value: SortOption.cityAZ,
                  groupValue: _selectedSort,
                  onChanged: (SortOption? value) {
                    setState(() {
                      _selectedSort = value;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                RadioListTile<SortOption>(
                  title: const Text('City: Z → A'),
                  value: SortOption.cityZA,
                  groupValue: _selectedSort,
                  onChanged: (SortOption? value) {
                    setState(() {
                      _selectedSort = value;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAgeRangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Age'),
          content: SingleChildScrollView(
            child: ListBody(
              children: AgeRange.values.map((range) {
                return RadioListTile<AgeRange>(
                  title: Text(_getAgeRangeLabel(range)),
                  value: range,
                  groupValue: _selectedAgeRange,
                  onChanged: (AgeRange? value) {
                    setState(() {
                      _selectedAgeRange = value;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Candidate List",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 136, 14, 79),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {}); // Trigger a rebuild to refresh the FutureBuilder
          await Future.delayed(Duration(milliseconds: 500)); //Optional Delay
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: searchDetails,
                onChanged: (value) {
                  setState(() {}); // Refresh UI when text changes
                },
                decoration: InputDecoration(
                  hintText: 'Search people & places',
                  prefixIcon: const Icon(Icons.search_rounded, size: 25),
                  suffixIcon: searchDetails.text.isNotEmpty
                      ? IconButton(
                    onPressed: () {
                      setState(() {
                        searchDetails.clear();
                      });
                    },
                    icon: const Icon(Icons.cancel_outlined, size: 20),
                  )
                      : null, // Hide suffix icon when text is empty
                  border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 15),
              SingleChildScrollView( // Make the row scrollable
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.filter_list),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Filter & Sort:",
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 15,),
                        InkWell(
                          onTap: () {
                            _showAgeRangeDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                Text(_selectedAgeRange == null
                                    ? "Age: All"
                                    : "Age: ${_getAgeRangeLabel(_selectedAgeRange!)}"),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            _showSortDialog(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: [
                                Text(_selectedSort == null
                                    ? "Sort: Select"
                                    : "Sort: ${_getSortLabel(_selectedSort!)}"),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              filteredUsers.isEmpty
                  ? const Expanded(
                child: Center(
                    child: Text(
                      'No Candidate Found',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )),
              )
                  : Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return userCard(filteredUsers.reversed.toList()[index]);
                  },
                  itemCount: filteredUsers.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userCard(Map<String, dynamic> userData) {
    return InkWell(
      onTap: () {
        int index = user.userList.indexWhere((u) => u[ID] == userData[ID]);
        if (index != -1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                Information(i: index), // Pass index instead of userData
          ));
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.pinkAccent.shade100,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  userData[NAME],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${userData[AGE]} years',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                trailing: Wrap( // Using wrap widget
                  children: [
                    IconButton(
                      onPressed: () async {
                        bool isLiked = userData[ISLIKED] == '1';

                        if (isLiked) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('Unlike'),
                                content:
                                const Text('Are you sure want to unlike?'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await _toggleLikeStatus(
                                          userData[ID], !isLiked);
                                      await _fetchUsers();
                                      setState(() {
                                        userData[ISLIKED] = isLiked
                                            ? '0'
                                            : '1'; // Toggle the status
                                        print("ok");
                                        print(userData);
                                      });
                                    },
                                    child: const Text('Yes'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          await _toggleLikeStatus(userData[ID], !isLiked);
                          await _fetchUsers();
                          setState(() {
                            // userData[ISLIKED] = !isLiked ? '1' : '0'; // Toggle the status immediately
                          });
                        }
                      },
                      icon: Icon(
                        userData[ISLIKED] == '1'
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                        userData[ISLIKED] == '1' ? Colors.red : Colors.grey,
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) async {
                        if (value == 'edit') {
                          // Handle edit action
                          final updatedUser = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditScreen(
                                  data: Map<String, dynamic>.from(
                                      userData)),
                            ),
                          );

                          if (updatedUser != null) {
                            await apiService.updateUser(
                                id: userData[ID],
                                map: userData,
                                context: context);
                            await _fetchUsers();
                          }
                        } else if (value == 'delete') {
                          final currentContext = context;
                          showDialog(
                            context: currentContext,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Delete'),
                              content: const Text(
                                  'Are you sure you want to delete?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    // Use the captured context here
                                    await apiService.deleteUser(
                                        context: currentContext, id: userData[ID]);
                                    await _fetchUsers(); // Refresh list
                                    Navigator.pop(currentContext);
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        } else if (value == 'share') {
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('Share as Text Message'),
                              content:
                              const Text('Are you sure you want to share?'),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    _shareUserDetails(userData);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 6),
                              Text("Edit")
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 6),
                              Text("Delete")
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'share',
                          child: Row(
                            children: [
                              Icon(Icons.copy, color: Colors.grey),
                              SizedBox(width: 6),
                              Text("Share as text")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.orange),
                            SizedBox(width: 6),
                            Text(userData[CITY]),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 6),
                            Text(userData[PHONE]),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.email, color: Colors.pink),
                        SizedBox(width: 6),
                        Text(userData[EMAIL]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleLikeStatus(dynamic userId, bool newStatus) async {
    try {
      // Find the user in _userList based on ID
      final userIndex = _userList.indexWhere((user) => user[ID] == userId);

      if (userIndex != -1) {
        // Update the isLiked status in the local list
        _userList[userIndex][ISLIKED] = newStatus ? '1' : '0';

        // Optimistically update the UI
        setState(() {});

        // Make API call to update the isLiked status
        final result = await apiService.updateUser(
          id: userId,
          map: {ISLIKED: newStatus ? '1' : '0'},
          context: context,
        );

        if (result is Map<String, dynamic>) {
          // API call successful, update the local list with the returned data
          _userList[userIndex] = result;
          setState(() {});
        } else {
          // API call failed, revert the local list to its original state
          _userList[userIndex][ISLIKED] = !newStatus ? '1' : '0';
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update like status: $result')));
          print('Failed to update like status: $result');
        }
      }
    } catch (e) {
      // Handle any exceptions that occur during the process
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An error occurred: $e')));
      print('An error occurred: $e');
    }
  }

  void _shareUserDetails(Map<String, dynamic> user) {
    String shareText = '''
    
    🔹 *Candidate Details* 🔹
  
  🧑‍💼 Name: ${user[NAME]}
  📧 Email: ${user[EMAIL]}
  📞 Phone: ${user[PHONE]}
  🎂 Date of Birth: ${user[DOB]}
  ⚧️ Gender: ${user[GENDER]}
  🏙️ City: ${user[CITY]}

  🎯 Hobbies: ${user[HOBBIES] ?? 'No hobbies listed'}
  🎓 Education: ${user[EDUCATION]}
  💼 Occupation: ${user[OCCUPATION]}
  🏢 Work Place: ${user[WORK_PLACE]}
  💰 Annual Income: ${user[INCOME]}

    ''';

    Share.share(shareText);
  }
}