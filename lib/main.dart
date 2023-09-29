import 'package:demo/model/PokemonDetailModel.dart';
import 'package:demo/service/pokedex.dart';
import 'package:demo/widget/pokemon_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pageSize = 20;
  // final _scrollController = ScrollController();
  var isLoading = false;
  var pageIndex = 0;
  List<PokemonDetail> data = [];

  _loadMore() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final result =
        await PokedexService().getPokedex(_pageSize, pageIndex * _pageSize);
    pageIndex++;

    setState(() {
      data.addAll(result);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Pokedex",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Visibility(
                      visible: isLoading && data.isEmpty,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    NotificationListener(
                      onNotification: (ScrollNotification scrollNotification) {
                        if (scrollNotification.metrics.pixels ==
                            scrollNotification.metrics.maxScrollExtent) {
                          _loadMore();
                        }
                        return true;
                      },
                      child: GridView.count(
                        padding: const EdgeInsets.all(10.0),
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.4,
                        crossAxisCount: 2,
                        children: [
                          ...data.map((e) {
                            return PokemonCard(pokemonDetail: e);
                          }).toList()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (data.isNotEmpty && isLoading)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
