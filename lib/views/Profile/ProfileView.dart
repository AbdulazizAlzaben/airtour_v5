import 'package:AirTours/constants/pages_route.dart';
import 'package:AirTours/services/cloud/firebase_cloud_storage.dart';
import 'package:AirTours/services_auth/auth_service.dart';
import 'package:AirTours/utilities/button.dart';
import 'package:AirTours/utilities/show_feedback.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseCloudStorage c = FirebaseCloudStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Text(
            //   'User Balance',
            //   style: TextStyle(fontSize: 24.0),
            // ),
            //const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(updateRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change Email',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle change password here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change Password',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      Text(
                        '>',
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle account deletion here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(fontSize: 18.0),
                    ),
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
