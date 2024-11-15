// the pokemon model with only the values we will use (not the full info from the api)
class Pokemon {
  late int id;
  String urlPath;
  String name;
  late int hpValue; //the hit points of the pokemon
  late int attackValue;
  late int defenseValue;

  Pokemon({
    required this.urlPath,
    required this.name,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        urlPath = json['url'] ?? '',
        name = json['name'] ?? '',
        hpValue = json['hpValue'] ?? 0,
        attackValue = json['attackValue'] ?? 0,
        defenseValue = json['defenseValue'] ?? 0;
}
