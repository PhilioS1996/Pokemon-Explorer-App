// model of the types of the pokemons
import 'package:pokemon_explorer_app/helpers/imports.dart';

class Type {
  int id = 0;
  String name;
  Color? mainColor;
  String? typeIcon;
  List<Pokemon> listOfPokemons = []; //the list of pokemons that have this type

  Type({required this.name, this.mainColor, this.typeIcon});

  Type.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        listOfPokemons = (json['pokemon'] as List)
            .map((e) => Pokemon.fromJson(e['pokemon']))
            .toList(); //desirialized json dynamic list to list of pokemon objects
}
