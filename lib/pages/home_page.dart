import '../helpers/imports.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: categoriesProvider.pokemonCategories.length,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.done),
            title: Text(
              categoriesProvider.pokemonCategories[index].name,
            ),
            onTap: () async {
              if (kDebugMode) {
                print(categoriesProvider.pokemonCategories[index].id);
              }
              //set in provider the selected type
              categoriesProvider.setSelectedType(
                  categoriesProvider.pokemonCategories[index].name);
              // do the api call for fetching data base on the type and then navigate to the Type page
              await categoriesProvider
                  .fetchType(categoriesProvider.pokemonCategories[index].name
                      .toLowerCase())
                  .then((_) => {Navigator.pushNamed(context, '/type')})
                  .catchError((error) {
                throw Exception(error);
              });
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
