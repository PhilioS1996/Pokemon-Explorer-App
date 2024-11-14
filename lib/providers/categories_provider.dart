import '../helpers/imports.dart';

class CategoriesProvider extends ChangeNotifier {
  String _selectedTypeName = ''; // the selected type from the list in homepage
  late Type typeSelected; //the Type object after the api call
  List<Type> pokemonCategories = [
    Type(id: 'fire', name: 'Fire'),
    Type(id: 'water', name: 'Water'),
    Type(id: 'grass', name: 'Grass'),
    Type(id: 'electric', name: 'Electric'),
    Type(id: 'dragon', name: 'Dragon'),
    Type(id: 'psychic', name: 'Psychic'),
    Type(id: 'ghost', name: 'Ghost'),
    Type(id: 'dark', name: 'Dark'),
    Type(id: 'steel', name: 'Steel'),
    Type(id: 'fairy', name: 'Fairy'),
  ];

// get the type of Pokemon that is selected
  String get selectedTypeName => _selectedTypeName;

// set the type of Pokemon that the user selected in the homepage
  void setSelectedType(String type) {
    _selectedTypeName = type;
    notifyListeners();
  }
}
