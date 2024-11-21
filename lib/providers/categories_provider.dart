import 'package:pokemon_explorer_app/models/pokemon_model.dart';

import '../helpers/imports.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  String _selectedTypeName = ''; // the selected type from the list in homepage
  Type _typeSelected = Type(name: ''); //the Type object after the api call
  List<Pokemon> tempListPokemons = [];
  late Type choosenType;
  bool isLoading = false;
  bool isLoadingPokemon = false;
  TextEditingController searchPokemonByName = TextEditingController();
  String? errorMessage;
  String errorMessagePokemon = '';

  int itemsShowList = 10;

  List<Type> pokemonCategories = [
    Type(
        name: 'Fire',
        mainColor: const Color(0xFFE62829),
        typeIcon: 'assets/fire-icon.png'),
    Type(
        name: 'Water',
        mainColor: const Color(0xFF2980EF),
        typeIcon: 'assets/water-icon.png'),
    Type(
        name: 'Grass',
        mainColor: const Color(0xFF3FA129),
        typeIcon: 'assets/grass-icon.png'),
    Type(
        name: 'Electric',
        mainColor: const Color(0xFFFAC000),
        typeIcon: 'assets/electric-icon.png'),
    Type(
        name: 'Dragon',
        mainColor: const Color(0xFF5060E1),
        typeIcon: 'assets/dragon-icon.png'),
    Type(
        name: 'Psychic',
        mainColor: const Color(0xFFEF4179),
        typeIcon: 'assets/psychic-icon.png'),
    Type(
        name: 'Ghost',
        mainColor: const Color(0xFF704170),
        typeIcon: 'assets/ghost-icon.png'),
    Type(
        name: 'Dark',
        mainColor: const Color(0xFF50413F),
        typeIcon: 'assets/dark-icon.png'),
    Type(
        name: 'Steel',
        mainColor: const Color(0xFF60A1B8),
        typeIcon: 'assets/steel-icon.png'),
    Type(
        name: 'Fairy',
        mainColor: const Color(0xFFEF70EF),
        typeIcon: 'assets/fairy-icon.png'),
  ];

// get the type of Pokemon that is selected
  String get selectedTypeName => _selectedTypeName;
  Type get typeSelected => _typeSelected;

// set the type of Pokemon that the user selected in the homepage
  void setSelectedType(Type type) async {
    _typeSelected = type;
    choosenType = type;
    _typeSelected.mainColor = type.mainColor;
    notifyListeners();
  }

//function that is used for the "Load More" button and increase items view by 10 each time
  void increaseItemsShowList() {
    itemsShowList += 10;
    notifyListeners();
  }

  void changeLoadingPokemon() {
    isLoadingPokemon = !isLoadingPokemon;
    notifyListeners();
  }

// future function for type pokemon api call
  Future<dynamic> fetchType(String typeName) async {
    isLoading = true;
    errorMessage = null;
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/type/$typeName'));
    try {
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        if (kDebugMode) {
          print(jsonDecode(response.body)['pokemon']);
        }
        _typeSelected = Type.fromJson(jsonDecode(response.body));

        return errorMessage;
      } else {
        // If the server did not return a 200 OK response,
        errorMessage = response.reasonPhrase;
        return errorMessage;
      }
    } catch (e) {
      errorMessage = e.toString();
      return errorMessage;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

// future function for getting the pokemon list of the selected type
  Future fetchPokemonsType() async {
    errorMessagePokemon = "";
    try {
      if (_typeSelected.listOfPokemons.isNotEmpty) {
        var pokemonsList = _typeSelected.listOfPokemons;
        for (int i = 0; i <= 10; i++) {
          await http.get(Uri.parse(pokemonsList[i].urlPath)).then((data) {
            if (data.statusCode == 200) {
              pokemonsList[i] = Pokemon.fromJson(jsonDecode(data.body));
            } else {
              // If the server did not return a 200 OK response,
              errorMessage = data.reasonPhrase;
              // return errorMessage;
            }
          });
        }
        tempListPokemons = _typeSelected.listOfPokemons;
      }
      notifyListeners();
      return _typeSelected.listOfPokemons;
    } catch (e) {
      errorMessage = e.toString();
      return errorMessage;
    }
  }

// future function for load more pokemons of the pokemon list of the selected type
  Future loadMorePokemonsType() async {
    changeLoadingPokemon();
    errorMessagePokemon = '';
    try {
      if (_typeSelected.listOfPokemons.isNotEmpty) {
        var pokemonsList = _typeSelected.listOfPokemons;
        for (int i = (itemsShowList + 1); i <= (itemsShowList + 10); i++) {
          await http.get(Uri.parse(pokemonsList[i].urlPath)).then((data) {
            if (data.statusCode == 200) {
              pokemonsList[i] = Pokemon.fromJson(jsonDecode(data.body));
            } else {
              // If the server did not return a 200 OK response,
              errorMessage = data.reasonPhrase;
              // return errorMessage;
            }
          });
        }
        tempListPokemons = _typeSelected.listOfPokemons;
      }
      increaseItemsShowList();

      return _typeSelected.listOfPokemons;
    } catch (e) {
      errorMessage = e.toString();
      return errorMessage;
    } finally {
      changeLoadingPokemon();
    }
  }

  void setTheSearchController(String controllerText) {
    searchPokemonByName.text = controllerText;
    notifyListeners();
  }

  void clearTheSearchController() {
    searchPokemonByName.clear();
    errorMessagePokemon = "";
    notifyListeners();
  }

  void searchByNamePokemons() {
    tempListPokemons = _typeSelected.listOfPokemons
        .where((pokemon) => (pokemon.name.contains(searchPokemonByName.text) &&
            pokemon.id != 0))
        .toList();
    notifyListeners();
  }

  // future function for type pokemon api call
  Future<dynamic> searchApiByName(String searchInput) async {
    changeLoadingPokemon();
    errorMessagePokemon = '';
    try {
      if (_typeSelected.listOfPokemons.isNotEmpty) {
        int searchPokemonIndex = _typeSelected.listOfPokemons
            .indexWhere((pokemon) => pokemon.name == searchInput);

        if (searchPokemonIndex == -1) {
          errorMessagePokemon =
              'Looks like this Pokémon is playing hide and seek! Try another name or explore a different type to catch them all.';
          notifyListeners();
          return;
        }
        // if the text input name matches pokemon name of the type's pokemons
        await http
            .get(Uri.parse(
                _typeSelected.listOfPokemons[searchPokemonIndex].urlPath))
            .then((data) {
          if (data.statusCode == 200) {
            _typeSelected.listOfPokemons[searchPokemonIndex] =
                Pokemon.fromJson(jsonDecode(data.body));
          } else {
            // If the server did not return a 200 OK response,
            errorMessage = data.reasonPhrase;
          }
        });
        tempListPokemons = [_typeSelected.listOfPokemons[searchPokemonIndex]];
        notifyListeners();
      }
      return tempListPokemons;
    } catch (e) {
      errorMessage = e.toString();
      return errorMessage;
    } finally {
      changeLoadingPokemon();
    }
  }

  void clearVariables() {
    itemsShowList = 10;
    _typeSelected = Type(name: '');
    errorMessage = '';
    _selectedTypeName = '';
    searchPokemonByName.clear();
    notifyListeners();
  }
}
