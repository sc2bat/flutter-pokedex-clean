import 'package:flutter/material.dart';
import 'package:pokedex_clean/domain/model/pokemon.dart';
import 'package:pokedex_clean/presentation/common/type_enum.dart';
import 'package:pokedex_clean/presentation/common/widget/type_page_view_container.dart';
import 'package:pokedex_clean/presentation/main/detail_screen/widget/detail_info_title_text_widget.dart';

class DetailTypeColumnWidget extends StatelessWidget {
  const DetailTypeColumnWidget({
    super.key,
    required this.pokemonData,
  });

  final Pokemon pokemonData;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> testType = {
      "id": "4",
      "name": "독",
      "imageurl": "assets/images/types/poison_type.png",
      "double_damage_to": [
        {"id": "5"},
        {"id": "6"},
        {"id": "7"},
        {"id": "8"},
        {"id": "9"},
        {"id": "10"},
        {"id": "11"},
        {"id": "12"},
        {"id": "13"},
        {"id": "14"},
        {"id": "15"},
        {"id": "16"}
      ],
      "double_damage_from": [
        {"id": "5"},
        {"id": "14"}
      ],
      "half_damage_to": [
        {"id": "4"},
        {"id": "5"},
        {"id": "6"},
        {"id": "8"}
      ],
      "half_damage_from": [
        {"id": "2"},
        {"id": "4"},
        {"id": "7"},
        {"id": "12"},
        {"id": "18"}
      ],
      "no_damage_to": [
        {"id": "9"}
      ],
      "no_damage_from": []
    };
    List<Map<String, dynamic>> doubleDamageTo =
        _nullCheckAndCastToMap(testType["double_damage_to"]);
    List<Map<String, dynamic>> doubleDamageFrom =
        _nullCheckAndCastToMap(testType["double_damage_from"]);
    List<Map<String, dynamic>> halfDamageTo =
        _nullCheckAndCastToMap(testType["half_damage_to"]);
    List<Map<String, dynamic>> halfDamageFrom =
        _nullCheckAndCastToMap(testType["half_damage_from"]);
    List<Map<String, dynamic>> noDamageTo =
        _nullCheckAndCastToMap(testType["no_damage_to"]);
    List<Map<String, dynamic>> noDamageFrom =
        _nullCheckAndCastToMap(testType["no_damage_from"]);

    List<String> goodForType =
        _removeDuplicates(doubleDamageTo, halfDamageFrom);
    List<String> badForType = _removeDuplicates(doubleDamageFrom, halfDamageTo);
    List<String> noneForType = _removeDuplicates(noDamageTo, noDamageFrom);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Type
            const DetailInfoTitleTextWidget(title: '타입'),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ],
        ),
        Row(
          children: List.generate(
            pokemonData.types.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      getTypeImagebyTypeId(
                                          pokemonData.types[index]),
                                      width: 64.0,
                                      height: 64.0,
                                    ),
                                    Text(
                                      '${testType["name"]} 타입의 상성정보',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close_outlined,
                                    size: 32.0,
                                  ),
                                ),
                              ],
                            ),
                            scrollable: true,
                            content: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: PageView(
                                children: [
                                  TypePageViewContainer(
                                      title: '유리함',
                                      typeList: goodForType,
                                      color: Colors.blue),
                                  TypePageViewContainer(
                                      title: '불리함',
                                      typeList: badForType,
                                      color: Colors.red),
                                  TypePageViewContainer(
                                      title: '효과없음',
                                      typeList: noneForType,
                                      color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Image.asset(
                  getTypeImagebyTypeId(pokemonData.types[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

List<Map<String, dynamic>> _nullCheckAndCastToMap(dynamic inputDynamic) {
  if (inputDynamic is List<Map<String, dynamic>>) {
    return inputDynamic;
  }
  return [];
}

List<String> _removeDuplicates(
    List<Map<String, dynamic>> list1, List<Map<String, dynamic>> list2) {
  Set<String> resultList = {};

  for (var entry in list1) {
    resultList.add(entry['id']);
  }

  for (var entry in list2) {
    resultList.add(entry['id']);
  }

  return resultList.toList();
}
