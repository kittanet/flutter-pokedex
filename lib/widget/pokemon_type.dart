import 'package:demo/extension/ex_string.dart';
import 'package:demo/model/PokemonDetailModel.dart';
import 'package:flutter/material.dart';

class PokemonType extends StatelessWidget {
  List<Types> types = [];
  PokemonType({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...types.map((e) => _buildTypeBox(e.type?.name ?? "")).toList(),
      ],
    );
  }

  Widget _buildTypeBox(String type) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        type.toUpperCaseFirst(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
