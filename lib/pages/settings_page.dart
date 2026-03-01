import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                  child: const Text(
                    'L',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight(40),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(child: const Text('slimahmad6@gmail.com')),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Account'),
                trailing: const Icon(Icons.open_in_full),
                onTap: () {
                  // Handle account settings tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                trailing: const Icon(Icons.open_in_new),
                onTap: () {
                  // Handle notifications settings tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Privacy'),
                trailing: const Icon(Icons.open_with_sharp),
                onTap: () {
                  // Handle privacy settings tap
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
