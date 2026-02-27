import 'package:flutter/material.dart';

class MovieComponent extends StatelessWidget {
  final String? posterPath;
  final String description;
  final String name;

  const MovieComponent({
    super.key,
    this.posterPath, 
    required this.description,
    required this.name
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             SizedBox(height: 10),
             Image.network(
              'https://image.tmdb.org/t/p/w500$posterPath',
              height: 200,
              fit: BoxFit.cover,),
             SizedBox(height: 5),
             Text(name, style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
             SizedBox(height: 5),
             Text(description, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}