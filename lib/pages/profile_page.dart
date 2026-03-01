import 'package:flutter/material.dart';
import 'package:hello_world/components/movie_component.dart';
import 'package:hello_world/models/views/movie_list_view/movie_list_response_view.dart';
import 'package:hello_world/services/views/movies_list/movie_list_view_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List todos = [
    {'task': 'Buy groceries', 'completed': false},
  ];

  final MovieListViewService movieListService = MovieListViewService();
  bool isLoading = false;
  MovieListResponseView? movies;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadMovies() async {
    setState(() => isLoading = true);

    final fetched = await movieListService.retrieveAllMovieViewsAsync();
    setState(() => movies = fetched);
    setState(() => isLoading = false);
  }

  void toggleTodoStatus(bool? value, int index) {
    setState(() {
      todos[index]['completed'] = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : movies == null
            ? ElevatedButton(
                onPressed: _loadMovies,
                child: const Text("Load Movies"),
              )
            : ListView.builder(
                itemCount: movies!.results.length,
                itemBuilder: (context, index) {
                  final movie = movies!.results[index];
                  return MovieComponent(
                    name: movie.name.toString(),
                    posterPath: movie.posterPath,
                    description: movie.description,
                  );
                },
              ),
      ),
    );
  }
}
