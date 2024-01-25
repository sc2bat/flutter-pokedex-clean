import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/main/widget/grid_type_image_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_id_text_widget.dart';
import 'package:pokedex_clean/presentation/main/widget/pokemon_image_widget.dart';

class MainGridViewWidget extends StatelessWidget {
  const MainGridViewWidget({
    super.key,
    required this.pokemonList,
  });

  final List<Pokemon> pokemonList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: pokemonList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: true
                    ? _getColorFromString('green')
                    : _getColorFromString('black'),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          pokemonList[index].description.name,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 32.0,
                        ),
                        PokemonIdTextWidget(
                          id: pokemonList[index].id,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        const Column(
                          children: [
                            GridTypeImageWidget(
                              isCollected: true,
                              typeImageUrl: 'assets/images/types/bug_type.png',
                              typeimageSize: 32.0,
                              iconSize: 24.0,
                            ),
                          ],
                        ),
                        PokemonImageWidget(
                          isCollected: true,
                          pokemonImageSize: 152.0,
                          imageurl: pokemonList[index].imageurl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case 'green':
        return Colors.green.withOpacity(0.3);
      case 'black':
        return Colors.black.withOpacity(0.3);
      // 추가적인 색상에 대한 처리를 원한다면 여기에 계속해서 추가 가능
      default:
        return Colors.transparent; // 기본값 설정
    }
  }
}
