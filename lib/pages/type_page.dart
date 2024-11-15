import '../helpers/imports.dart';

class TypePage extends StatefulWidget {
  const TypePage({super.key});

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      // The result argument contains the pop result that is defined in `_PageTwo`.
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          categoriesProvider.clearVariables();
          return;
        }
      },

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Type'),
        ),
        body: Column(
          children: [
            Text(
              categoriesProvider.selectedTypeName,
              style: const TextStyle(color: Colors.black),
            ),
            Expanded(
              child: Consumer<CategoriesProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (provider.errorMessage != null) {
                    return Center(
                        child: Text('Error: ${provider.errorMessage}'));
                  }

                  final type = provider.typeSelected;
                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (provider.itemsShowList <=
                              provider.typeSelected.listOfPokemons.length)
                          ? provider.itemsShowList
                          : provider.typeSelected.listOfPokemons.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                          provider.typeSelected.listOfPokemons[index].name,
                          style: const TextStyle(color: Colors.black),
                        ));
                      },
                    ),
                  );
                },
              ),
            ),
            (categoriesProvider.itemsShowList <=
                    categoriesProvider.typeSelected.listOfPokemons.length)
                ? IconButton(
                    onPressed: () {
                      categoriesProvider.increaseItemsShowList();
                    },
                    icon: const Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          'Load More',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ))
                : const TextButton(
                    onPressed: null, child: Text('You catchem all'))
          ],
        ),
      ),
    );
  }
}
