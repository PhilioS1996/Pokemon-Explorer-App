// model of the types of the pokemons
import '../models/pokemon_model.dart';

class Type {
  int id = 0;
  String name;
  List<Pokemon> listOfPokemons = []; //the list of pokemons that have this type

  Type({
    required this.name,
  });

  Type.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        listOfPokemons = (json['pokemon'] as List)
            .map((e) => Pokemon.fromJson(e['pokemon']))
            .toList(); //desirialized json dynamic list to list of pokemon objects
  // (json['pokemon'] as List);

  // (json['pokemon'] as List)
  //     .map((e) => Pokemon.fromJson(e))
  //     .toList(); //desirialized json dynamic list to list of pokemon objects
}
