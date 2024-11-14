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
    final databaseProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: databaseProvider.pokemonCategories.length,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.done),
            title: Text(
              databaseProvider.pokemonCategories[index].name,
            ),
            onTap: () {
              if (kDebugMode) {
                print(databaseProvider.pokemonCategories[index].id);
              }
              databaseProvider.setSelectedType(
                  databaseProvider.pokemonCategories[index].name);
              Navigator.pushNamed(context, '/type');
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
