import 'package:UturnJobs/util/UsefulVariables.dart';
import 'package:UturnJobs/util/info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firestore _firestore = Firestore.instance;
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('UserProfiles').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot> users = snapshot.data.documents;
          DocumentSnapshot user;
          for (user in users) {
            if (user.documentID == Variable.email) break;
          }

          String name = user.data['FULL NAME'];
          String mobile = user.data['MOBILE'];
          String city = user.data['CITY'];
          String state = user.data['STATE'];
          String url = user.data['DPURL'];

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "PROFILE",
                style: TextStyle(color: Color(0xff01D45B), letterSpacing: 3),
              ),
              backgroundColor: Color(0xFF1E3C44),
              centerTitle: true,
              elevation: 0,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xff01D45B),
                  )),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(url),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Color(0xff01D45B),
                      letterSpacing: 3,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.teal.shade700,
                    ),
                  ),
                  Text(
                    'Uturn User',
                    style: TextStyle(
                      color: Color(0xff00CCFF),
                      letterSpacing: 3,
                      fontSize: 25.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.teal.shade700,
                    ),
                  ),
                  InfoCard(
                    text: mobile,
                    icon: Icons.phone,
                  ),
                  InfoCard(
                    text: Variable.email,
                    icon: Icons.email,
                  ),
                  InfoCard(
                    text: '$city, $state',
                    icon: Icons.location_city,
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xFF1E3C44),
          );
        });
  }
}
