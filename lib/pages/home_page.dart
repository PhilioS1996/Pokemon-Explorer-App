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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Hello fellow trainer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10),
                child: Text('Choose Type',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.all(8.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categoriesProvider.pokemonCategories.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                        elevation: 5,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          tileColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          leading: Image(
                            width: 40,
                            height: 40,
                            image: AssetImage(categoriesProvider
                                    .pokemonCategories[index].typeIcon ??
                                'pokemon image'),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward,
                            color: categoriesProvider
                                .pokemonCategories[index].mainColor,
                          ),
                          title: Text(
                            categoriesProvider.pokemonCategories[index].name,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          onTap: () async {
                            if (kDebugMode) {
                              print(categoriesProvider
                                  .pokemonCategories[index].id);
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
                                                    .pokemonCategories[index],
                                              ),
                                            ),
                                          )
                                        }
                                      else
                                        {
                                          if (context.mounted)
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(message),
                                            ))
                                        }
                                    })
                                .catchError((error) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Sorry Something Happend! Try Again Later...The journey isn’t over yet!'),
                                ));
                              }
                            });
                          },
                        ),
                      ),
                    )),
            Visibility(
                visible: categoriesProvider.isLoading,
                child: const LoadingPokeball())
          ],
        ),
      ),
    );
  }
}
