import '../helpers/imports.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  String _selectedTypeName = ''; // the selected type from the list in homepage
  late Type _typeSelected; //the Type object after the api call
  bool isLoading = false;
  String? errorMessage;
  int itemsShowList = 10;

  List<Type> pokemonCategories = [
    Type(name: 'Fire'),
    Type(name: 'Water'),
    Type(name: 'Grass'),
    Type(name: 'Electric'),
    Type(name: 'Dragon'),
    Type(name: 'Psychic'),
    Type(name: 'Ghost'),
    Type(name: 'Dark'),
    Type(name: 'Steel'),
    Type(name: 'Fairy'),
  ];

// get the type of Pokemon that is selected
  String get selectedTypeName => _selectedTypeName;
  Type get typeSelected => _typeSelected;

// set the type of Pokemon that the user selected in the homepage
  void setSelectedType(String type) async {
    _selectedTypeName = type;
    notifyListeners();
  }

  void increaseItemsShowList() {
    itemsShowList += 10;
    notifyListeners();
  }

  Future<void> fetchType(String typeName) async {
    isLoading = true;
    errorMessage = null;
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/type/$typeName'));
    try {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        if (kDebugMode) {
          print(jsonDecode(response.body)['pokemon']);
        }
        _typeSelected = Type.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load type');
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearVariables() {
    itemsShowList = 10;
    _typeSelected = Type(name: '');
    errorMessage = '';
    _selectedTypeName = '';
    notifyListeners();
  }
}
