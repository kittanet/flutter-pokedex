import 'package:demo/extension/ex_string.dart';
import 'package:demo/model/PokemonDetailModel.dart';
import 'package:demo/page/detail.dart';
import 'package:demo/widget/pokemon_type.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  PokemonDetail pokemonDetail;

  PokemonCard({super.key, required this.pokemonDetail});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => Detail(pokemonDetail: pokemonDetail),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: (pokemonDetail.types?[0].type?.name ?? '').toTypeColor(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(children: [
          Positioned(
            top: 20.0,
            left: 10.0,
            child: Text(
              (pokemonDetail.name ?? "").toUpperCaseFirst(),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 10.0,
            child: PokemonType(types: pokemonDetail.types ?? []),
          ),
          Positioned(
            bottom: 5.0,
            right: 5.0,
            child: Hero(
              tag: pokemonDetail.id.toString(),
              child: pokemonDetail.id.toString().toSvg(90.0, 90.0),
            ),
          ),
        ]),
      ),
    );
  }
}
