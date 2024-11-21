// import '../helpers/imports.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     const collapsedBarHeight = 60.0;
//     const expandedBarHeight = 150.0;
//     final categoriesProvider =
//         Provider.of<CategoriesProvider>(context, listen: false);
//     return Scaffold(
//       body: Stack(
//         children: [
//           CustomScrollView(slivers: [
//             const SliverAppBar(
//               expandedHeight: expandedBarHeight,
//               collapsedHeight: collapsedBarHeight,
//               centerTitle: false,
//               pinned: true,
//               elevation: 1,
//               backgroundColor: Color(0xFFFF6666),
//               flexibleSpace: FlexibleSpaceBar(
//                 title: Image(image: AssetImage('assets/logo-app.png')),
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: Text('Hello fellow trainer',
//                   style: TextStyle(fontFamily: 'Rowdies')),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   return Column(
//                     children: [
//                       ListTile(
//                         leading: const Icon(Icons.done),
//                         title: Text(
//                           categoriesProvider.pokemonCategories[index].name,
//                         ),
//                         onTap: () async {
//                           if (kDebugMode) {
//                             print(
//                                 categoriesProvider.pokemonCategories[index].id);
//                           }
//                           //set in provider the selected type
//                           categoriesProvider.setSelectedType(
//                               categoriesProvider.pokemonCategories[index].name);
//                           // do the api call for fetching data base on the type and then navigate to the Type page
//                           await categoriesProvider
//                               .fetchType(categoriesProvider
//                                   .pokemonCategories[index].name
//                                   .toLowerCase())
//                               .then((message) => {
//                                     if (context.mounted && message == null)
//                                       {
//                                         Navigator.pushNamed(context, '/type'),
//                                       }
//                                     else
//                                       {
//                                         if (context.mounted && message == null)
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(SnackBar(
//                                                   content: Text(message)))
//                                       }
//                                   })
//                               .catchError((error) {
//                             throw Exception(error);
//                           });
//                         },
//                       ),
//                     ],
//                   );
//                 },
//                 childCount: categoriesProvider.pokemonCategories.length,
//               ),
//             )
//           ])
//         ],
//       ),
//       // appBar: AppBar(
//       //   centerTitle: true,
//       //   backgroundColor: const Color(0xFFFF6666),
//       //   title: const Image(image: AssetImage('assets/logo-app.png')),
//       // ),
//       // body: Center(
//       //   child: ListView.builder(
//       //     itemCount: categoriesProvider.pokemonCategories.length,
//       //     itemBuilder: (context, index) => ListTile(
//       //       leading: const Icon(Icons.done),
//       //       title: Text(
//       //         categoriesProvider.pokemonCategories[index].name,
//       //       ),
//       //       onTap: () async {
//       //         if (kDebugMode) {
//       //           print(categoriesProvider.pokemonCategories[index].id);
//       //         }
//       //         //set in provider the selected type
//       //         categoriesProvider.setSelectedType(
//       //             categoriesProvider.pokemonCategories[index].name);
//       //         // do the api call for fetching data base on the type and then navigate to the Type page
//       //         await categoriesProvider
//       //             .fetchType(categoriesProvider.pokemonCategories[index].name
//       //                 .toLowerCase())
//       //             .then((message) => {
//       //                   if (context.mounted && message == null)
//       //                     {
//       //                       Navigator.pushNamed(context, '/type'),
//       //                     }
//       //                   else
//       //                     {
//       //                       if (context.mounted && message == null)
//       //                         ScaffoldMessenger.of(context).showSnackBar(
//       //                             SnackBar(content: Text(message)))
//       //                     }
//       //                 })
//       //             .catchError((error) {
//       //           throw Exception(error);
//       //         });
//       //       },
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
