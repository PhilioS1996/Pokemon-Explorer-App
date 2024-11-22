// the pokemon model with only the values we will use (not the full info from the api)
class Pokemon {
  String name;
  String urlPath;
  late int id;
  late String imageUrlPath;
  late int hpValue; //the hit points of the pokemon
  late int attackValue;
  late int defenseValue;

  Pokemon({
    required this.urlPath,
    required this.name,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        urlPath =
            json['url'] ?? 'https://pokeapi.co/api/v2/pokemon/${json['name']}',
        name = json['name'] ?? '',
        imageUrlPath = json['sprites'] != null
            ? (json['sprites']['front_default'] ?? '')
            : '',
        hpValue = json['stats'] != null
            ? (json['stats'] as List)
                .toList()
                .firstWhere((stat) => stat['stat']['name'] == 'hp')['base_stat']
            : 0,
        attackValue = json['stats'] != null
            ? (json['stats'] as List).toList().firstWhere(
                (stat) => stat['stat']['name'] == 'attack')['base_stat']
            : 0,
        defenseValue = json['stats'] != null
            ? (json['stats'] as List).toList().firstWhere(
                (stat) => stat['stat']['name'] == 'defense')['base_stat']
            : 0;
}
