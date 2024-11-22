import '../helpers/imports.dart';

class TypePage extends StatefulWidget {
  final Type typeselected;
  const TypePage({super.key, required this.typeselected});

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          categoriesProvider.clearVariables();
          return;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: widget.typeselected.mainColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            widget.typeselected.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: categoriesProvider.fetchPokemonsType(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Column(children: [
                      Center(
                        child: Text(
                          'Catching Pokémons',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      LoadingPokeball(),
                    ]);
                  } else if (snapshot.hasError) {
                    return Text('Error in future builder: ${snapshot.error}');
                  } else {
                    return const ListPokemonView();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
