import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("About Us", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
        backgroundColor: Color.fromARGB(255, 136, 14, 79),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Title Section
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/tutor_logo.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Soulmate!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 136, 14, 79),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // "Meet Our Team" Section
              buildCard(
                "Meet Our Team",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow("Developed by", "Ronit Savaliya (23010101247)"),
                    buildInfoRow("Mentored by", "Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science"),
                    buildInfoRow("Explored by", "ASWDC, School of Computer Science, School of Computer Science"),
                    buildInfoRow("Eulogized by", "Darshan University, Rajkot, Gujarat - INDIA"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // "About ASWDC" Section
              buildCard(
                "About ASWDC",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/darshan.png',
                          height: 50,
                        ),
                        SizedBox(width: 20),
                        Image.asset(
                          'assets/images/aswdc.png',
                          height: 60,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "ASWDC is Application, Software, and Website Development Center @ Darshan University run by students and staff of the School of Computer Science.",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications, and gain professional experience.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // "Contact Us" Section
              buildCard(
                "Contact Us",
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildContactRow(Icons.email, "aswdc@darshan.ac.in"),
                    buildContactRow(Icons.phone, "+91-9727747317"),
                    buildContactRow(Icons.language, "www.darshan.ac.in"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Action Buttons
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    buildActionItem(Icons.share, "Share App"),
                    buildActionItem(Icons.apps, "More Apps"),
                    buildActionItem(Icons.star_rate, "Rate Us"),
                    buildActionItem(Icons.thumb_up, "Like us on Facebook"),
                    buildActionItem(Icons.update, "Check for Update"),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Footer Section
              Center(
                child: Column(
                  children: [
                    Text(
                      "© 2025 Darshan University",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      "All Rights Reserved - Privacy Policy",
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Made with ❤️ in India",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
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

  Widget buildCard(String title, Widget content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 136, 14, 79),
              ),
            ),
            SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget buildContactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Color.fromARGB(255, 136, 14, 79)),
          SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }

  Widget buildActionItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Color.fromARGB(255, 136, 14, 79)),
      title: Text(label),
      onTap: () {
        // Add action for the button here
      },
    );
  }
}
