import 'package:flutter/material.dart';

import 'data/jokes.dart';
import 'model/joke.dart';

final Color appColor = Colors.green.shade300;

void main() => runApp(const MaterialApp(
  home: FavoriteJokes()));

class FavoriteJokes extends StatefulWidget {
  const FavoriteJokes({super.key});

  @override
  State<FavoriteJokes> createState() => _FavoriteJokesState();
}

class _FavoriteJokesState extends State<FavoriteJokes> {
  int? favoriteJokeId;

  void onFavoriteClick(int id) {
    setState(() {
      favoriteJokeId = (favoriteJokeId == id) ? null : id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text("Favorite Jokes"),
      ),
      body: ListView.builder(
        itemCount: jokes.length,
        itemBuilder: (context, index) {
          final Joke joke = jokes[index];
          return JokeCard(
            joke: joke,
            isFavorite: favoriteJokeId == joke.id,
            onFavoriteClick: () => onFavoriteClick(joke.id),
          );
        },
      ),
    );
  }
}

class JokeCard extends StatelessWidget {
  const JokeCard({
    super.key,
    required this.joke,
    required this.isFavorite,
    required this.onFavoriteClick,
  });

  final Joke joke;
  final bool isFavorite;
  final VoidCallback onFavoriteClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: .5, color: Colors.grey),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.title,
                  style: TextStyle(
                    color: appColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(joke.description),
              ],
            ),
          ),
          IconButton(
            onPressed: onFavoriteClick,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}