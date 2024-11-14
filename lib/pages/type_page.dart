import '../helpers/imports.dart';

class TypePage extends StatefulWidget {
  const TypePage({super.key});

  @override
  State<TypePage> createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  @override
  Widget build(BuildContext context) {
    final databaseProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Type'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              databaseProvider.selectedTypeName,
              style: const TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
