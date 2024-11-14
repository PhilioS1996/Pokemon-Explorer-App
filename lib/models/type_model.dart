// model of the types of the pokemons
import '../models/pokemon_model.dart';

class Type {
  String id;
  String name;
  List<Pokemon> listOfPokemons = []; //the list of pokemons that have this type

  Type({
    required this.id,
    required this.name,
  });

  Type.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        listOfPokemons = json['pokemon'];
}
