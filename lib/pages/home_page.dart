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
    // var size = MediaQuery.sizeOf(context);
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        shadowColor: Colors.grey[300],
        centerTitle: true,
        backgroundColor: const Color(0xFFFF6666),
        title: const Image(image: AssetImage('assets/logo-app.png')),
        toolbarHeight: 100,
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(25, 15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 38.0),
              child:
                  Text('Hello fellow trainer', style: TextStyle(fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // number of items in each row
                  mainAxisSpacing: 28.0, // spacing between rows
                  crossAxisSpacing: 28.0, // spacing between columns
                  childAspectRatio: 5,
                ),
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoriesProvider.pokemonCategories.length,
                itemBuilder: (context, index) => Material(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  elevation: 10,
                  child: ListTile(
                    tileColor:
                        categoriesProvider.pokemonCategories[index].mainColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    leading: Image(
                        width: 40,
                        height: 40,
                        image: AssetImage(categoriesProvider
                                .pokemonCategories[index].typeIcon ??
                            '404')),
                    title: Text(
                      categoriesProvider.pokemonCategories[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    onTap: () async {
                      if (kDebugMode) {
                        print(categoriesProvider.pokemonCategories[index].id);
                      }
                      //set in provider the selected type
                      categoriesProvider.setSelectedType(
                          categoriesProvider.pokemonCategories[index]);
                      // do the api call for fetching data base on the type and then navigate to the Type page
                      await categoriesProvider
                          .fetchType(categoriesProvider
                              .pokemonCategories[index].name
                              .toLowerCase())
                          .then((message) => {
                                if (context.mounted && message == null)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TypePage(
                                              typeselected: categoriesProvider
                                                  .pokemonCategories[index])),
                                    )
                                  }
                                else
                                  {
                                    if (context.mounted && message == null)
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)))
                                  }
                              })
                          .catchError((error) {
                        throw Exception(error);
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
