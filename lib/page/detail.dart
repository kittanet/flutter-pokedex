import 'package:demo/extension/ex_string.dart';
import 'package:demo/model/PokemonDetailModel.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  PokemonDetail pokemonDetail;

  Detail({super.key, required this.pokemonDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Hero(
        tag: pokemonDetail.id.toString(),
        child: Center(
          child: pokemonDetail.id.toString().toSvg(200.0, 200.0),
        ),
      ),
    );
  }
}
