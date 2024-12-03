import 'package:flutter/material.dart';
import 'package:navigation/models/item.dart';
import 'package:provider/provider.dart';
import 'package:navigation/models/item_provider.dart';
import 'package:navigation/views/item_descript_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Item> displayedItems = [];
  String search = '';

  @override
  Widget build(BuildContext context) {
    // Access the provider
    final itemProvider = Provider.of<ItemProvider>(context);
    final items = itemProvider.items;

    // Update displayedItems based on provider data
    if (displayedItems.isEmpty && items.isNotEmpty) {
      displayedItems = List.from(items);
    }

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (newText) {
                filterItems(newText, items);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: itemProvider.isLoading
                ?const Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: RefreshIndicator(
                      onRefresh: () async{
                        await itemProvider.fetchItems(); // Call your fetch method
                            setState(() {
                            displayedItems = List.from(itemProvider.items); // Update the displayed items
                        });
                      },
                      child: GridView.builder(
                        itemCount: displayedItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index) {
                          final item = displayedItems[index];
                      
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDescription(item: item),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  color: Colors.white70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipOval(
                                              child: (item.images.isNotEmpty)
                                                  ? Image.network(
                                                      item.images[0],
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const Icon(Icons
                                                      .image_not_supported),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10), // Add padding
                                        Semantics(
                                          child: Text(
                                            'Price: \$${item.price}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Semantics(
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void filterItems(String query, List<Item> items) {
    final filtered = items.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedItems = filtered;
    });
  }
}
