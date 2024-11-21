import '../../helpers/help_functions.dart';
import '../../helpers/imports.dart';
import '../../models/pokemon_model.dart';

class ListPokemonView extends StatelessWidget {
  const ListPokemonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CategoriesProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading ||
              (provider.typeSelected.name == '' &&
                  provider.errorMessage == null)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  'Something Happend...Aww noo \n "Team Rocket, blast off at the speed of light! Surrender now, or prepare to fight!${provider.errorMessage}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }

          final type = provider.typeSelected;
          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(children: [
                // search input
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: provider.choosenType.mainColor!,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.search),
                            focusColor: provider.choosenType.mainColor!,
                            labelText: 'Search Pokemon Name',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.choosenType.mainColor!,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: provider.searchPokemonByName,
                          onSubmitted: (value) async {
                            await provider.searchApiByName(value);
                          },
                          onChanged: (value) {
                            // function in provider which is searching for matches
                            provider.searchByNamePokemons();
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () => provider.clearTheSearchController(),
                          icon: const Icon(Icons.clear))
                    ],
                  ),
                ),

                // check if the search widget is been used
                (provider.searchPokemonByName.text != '')
                    ? ListPokemonCards(
                        provider: provider,
                        listToSearch: provider.tempListPokemons,
                        itemCounts: (provider.itemsShowList <=
                                provider.tempListPokemons.length)
                            ? provider.itemsShowList
                            : provider.tempListPokemons.length,
                      )
                    : ListPokemonCards(
                        provider: provider,
                        listToSearch: type.listOfPokemons,
                        itemCounts: (provider.itemsShowList <=
                                type.listOfPokemons.length)
                            ? provider.itemsShowList
                            : type.listOfPokemons.length,
                      ),
                Visibility(
                    visible: (provider.searchPokemonByName.text == '' &&
                        provider.errorMessagePokemon == ''),
                    child: (provider.itemsShowList <=
                            provider.typeSelected.listOfPokemons.length)
                        ? IconButton(
                            color: provider.choosenType.mainColor!,
                            onPressed: () async {
                              // provider.increaseItemsShowList();
                              await provider.loadMorePokemonsType();
                            },
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                    visible: !provider.isLoadingPokemon,
                                    child: const Row(
                                      children: [
                                        Icon(Icons.add),
                                        Text(
                                          'Load More',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    )),
                                Visibility(
                                    visible: provider.isLoadingPokemon,
                                    child: Center(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: CircularProgressIndicator(
                                        color: provider.choosenType.mainColor!,
                                      ),
                                    )))
                              ],
                            ))
                        : const TextButton(
                            onPressed: null, child: Text('You catch ΄em all')))
              ]),
            ),
          );
        },
      ),
    );
  }
}

class ListPokemonCards extends StatelessWidget {
  const ListPokemonCards({
    super.key,
    required this.provider,
    required this.listToSearch,
    required this.itemCounts,
  });

  final CategoriesProvider provider;
  final List<Pokemon> listToSearch;
  final int itemCounts;

  @override
  Widget build(BuildContext context) {
    return provider.errorMessagePokemon == ""
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCounts,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    elevation: 2,
                    child: Stack(children: [
                      // Top-left element
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: provider.choosenType.mainColor!,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          width: MediaQuery.of(context).size.width / 2,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              HelperFunctions.firstLetterUppecase(
                                  listToSearch[index].name),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, top: 50, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: const Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                          border: Border.all(
                                              width: 1.5,
                                              color: provider
                                                  .choosenType.mainColor!),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.network(
                                        fit: BoxFit.contain,
                                        listToSearch[index].imageUrlPath,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Hit Points: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              )),
                                        ])),
                                        RichText(
                                            text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Attack: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              )),
                                        ])),
                                        RichText(
                                            text: const TextSpan(children: [
                                          TextSpan(
                                              text: 'Defence: ',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              )),
                                        ]))
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${listToSearch[index].hpValue}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            )),
                                        Text(
                                            '${listToSearch[index].attackValue}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            )),
                                        Text(
                                            '${listToSearch[index].defenseValue}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ])),
              );
            },
          )
        : const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  color: Colors.red,
                  size: 60,
                ),
                Text(
                  'No luck finding a Pokémon with that name in this type!\n Maybe try another name or take a look at a different type. The journey isn’t over yet!',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
  }
}
