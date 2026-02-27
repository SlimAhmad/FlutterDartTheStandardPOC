import 'package:flutter/material.dart';
import 'package:hello_world/brokers/apiBrokers/api_broker.dart';
import 'package:hello_world/components/movie_component.dart';
import 'package:hello_world/components/todo_list.dart';
import 'package:hello_world/models/movies/movie_list.dart';
import 'package:hello_world/models/movies/movie_list_response.dart';
import 'package:hello_world/services/foundations/movies/movie_list_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List todos = [
    {'task': 'Buy groceries', 'completed': false},
  ];

 final MovieListService movieListService = MovieListService();
 MovieListResponse? movies;

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
      final fetched = await movieListService.retrieveAllMovieListsAsync();
      setState(() => movies = fetched);
  }
  void toggleTodoStatus(bool? value, int index) {
    setState(() {
      todos[index]['completed'] = value ?? false;
    });
  }
  
  @override
  Widget build(BuildContext context) {

   if (movies == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(  
        child:   ListView.builder(
        itemCount: movies!.results.length,
        itemBuilder: (context, index) {
          final movie = movies!.results[index];
          return MovieComponent(
            name: movie.name,
            posterPath: movie.posterPath,
            description: movie.description,
          );
      }),
  ),
      );
  }
}