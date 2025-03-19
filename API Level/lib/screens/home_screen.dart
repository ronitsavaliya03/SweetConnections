import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimonial_app/screens/about_us.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/faq_screen.dart';
import 'package:matrimonial_app/screens/favorite_user.dart';
import 'package:matrimonial_app/screens/feedback.dart';
import 'package:matrimonial_app/screens/login_page.dart';
import 'package:matrimonial_app/screens/notification_screen.dart';
import 'package:matrimonial_app/screens/report_screen.dart';
import 'package:matrimonial_app/screens/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;
  String? userName;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String defaultProfileImage = "https://www.w3schools.com/howto/img_avatar.png";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail') ?? "guest@example.com";
      userName = prefs.getString('userName') ?? "Guest User";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.more_horiz_outlined),
            shape: CircleBorder(),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white70,
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            }),
        key: _scaffoldKey,
        body: HomeContent(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(userName ?? "Guest User", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                accountEmail: Text(userEmail ?? "guest@example.com"),
                currentAccountPicture: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(defaultProfileImage), // Profile Picture
                      radius: 28, // Adjust the size of the avatar
                    ),
                    SizedBox(width: 15), // Add space after avatar
                  ],
                ),
                decoration: BoxDecoration(color: const Color.fromARGB(
                    255, 152, 15, 88)),
              ),
              ListTile(
                title: Text("Notifications & Messaging"),
                leading: Icon(Icons.notification_add_outlined),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationsMessagingScreen()));
                },
              ),
              ListTile(
                title: Text("Reports & Complaints"),
                leading: Icon(Icons.report_problem_outlined),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReportsComplaintsScreen()));
                },
              ),
              ListTile(
                title: Text("FAQs & Help Center"),
                leading: Icon(Icons.question_answer_outlined),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FAQScreen()));
                },
              ),
              ListTile(
                title: Text("Log Out"),
                leading: Icon(Icons.logout),
                onTap: () {
                  showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Logout", style: TextStyle(color: CupertinoColors.destructiveRed)),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false, // Removes all previous routes
              );
            },
          ),
        ],
      );
    },
  );
}

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 136, 14, 79),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Soulmate",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 30),
              ),
              Text(
                "Where True Love Finds You",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 150, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CategoryCard(
                      title: "Add\nCandidate",
                      color: Color(0xFFF63C7C),
                      icon: Icons.add_card_rounded,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddEditScreen(),
                          ),
                        ).then((value) {
                            isApiCall = true;
                            setState(() {

                            });
                          },
                        );
                      },

                    ),
                    CategoryCard(
                      title: "List of\nCandidates",
                      color: Color(0xFF9C27B0),
                      icon: Icons.library_books_sharp,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserList(),
                          ),
                        );
                      },
                    ),
                    CategoryCard(
                      title: "Favorite\nCandidates",
                      color: Color(0xFFEC1362),
                      icon: Icons.star,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavoriteUserList(),
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CategoryCard(
                            title: "About us",
                            color: Colors.amber,
                            icon: Icons.new_releases,
                            height: 120,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AboutUs(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CategoryCard(
                            title: "Feedbacks",
                            color: Colors.green,
                            icon: Icons.eco,
                            height: 120,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FeedbackAndReviewsPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final double height;
  final VoidCallback onTap;

  CategoryCard({
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.white.withOpacity(0.3),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(-2, -2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      ),
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