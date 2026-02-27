import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  int clicks = 0;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void incrementCounter(){
    setState(() {
      clicks++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child:  Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text("You have pushed the button this many times :"),
               const SizedBox(height: 10),
               Text(clicks.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
               ),
               const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: incrementCounter,
                  child: const Text('Click Me'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (nameController.text.isNotEmpty || emailController.text.isNotEmpty)
                  Text(
                    [
                      if (nameController.text.isNotEmpty) 'Name: ${nameController.text}',
                      if (emailController.text.isNotEmpty) 'Email: ${emailController.text}',
                    ].join(', '),
                    style: const TextStyle(fontSize: 16),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}