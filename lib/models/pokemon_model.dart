// the pokemon model with only the values we will use (not the full info from the api)
class Pokemon {
  int id;
  String name;
  int hpValue; //the hit points of the pokemon
  int attackValue;
  int defenseValue;

  Pokemon(
      {required this.id,
      required this.name,
      required this.hpValue,
      required this.attackValue,
      required this.defenseValue});

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        hpValue = json['hpValue'],
        attackValue = json['attackValue'],
        defenseValue = json['defenseValue'];
}
