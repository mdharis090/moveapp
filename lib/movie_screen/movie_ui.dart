import 'package:flutter/material.dart';
import 'package:moviesapp/api/api_feching_data.dart';


class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  MovieService movieService = MovieService();
  List movies = [];
  TextEditingController searchController = TextEditingController();

  void search() async {
    var results = await movieService.searchMovies(searchController.text);
    setState(() {
      movies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        "Movies",
        style: TextStyle
          (fontSize: 30,
            fontWeight:FontWeight.bold,
            color: Colors.white),),
      centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search movies",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                )
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: movies[index]['Poster'] != "N/A"
                      ? Image.network(movies[index]['Poster'], width: 50)
                      : Container(width: 50),
                  title: Text(movies[index]['Title']),
                  subtitle: Text("${movies[index]['Year']}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
