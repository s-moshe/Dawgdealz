import 'package:flutter/material.dart';
import 'package:navigation/models/item.dart';
import 'package:provider/provider.dart';
import 'package:navigation/models/item_provider.dart';
import 'package:navigation/views/item_descript_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Item> displayedItems = [];
  String search = '';
  String selectedFilter = 'Time Posted'; // Default filter criterion

  @override
  Widget build(BuildContext context) {
    // Access the provider
    final itemProvider = Provider.of<ItemProvider>(context);
    final items = itemProvider.items;

    // Update displayedItems based on provider data
    if (displayedItems.isEmpty && items.isNotEmpty) {
      displayedItems = List.from(items);
    }

    // Apply sorting based on selected filter
    if (selectedFilter == 'Price') {
      displayedItems.sort((a, b) {
        double priceA = parsePrice(a.price);
        double priceB = parsePrice(b.price);
        return priceA.compareTo(priceB);
      });
    }
    // 'Time Posted' doesn't modify the order, as it's based on the original order.

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              onChanged: (String? newValue) {
                setState(() {
                  selectedFilter = newValue!;
                  // Reset the displayed items when switching between filters
                  if (selectedFilter == 'Time Posted') {
                    displayedItems = List.from(items);
                  }
                });
              },
              items: <String>['Time Posted', 'Price']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: itemProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await itemProvider.fetchItems();
                        setState(() {
                          displayedItems =
                              List.from(itemProvider.items);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipOval(
                                              child: Semantics(
                                                label: 'This is an image of ${item.name}.', 
                                                child: (item.images.isNotEmpty)
                                                    ? CachedNetworkImage(
                                                        imageUrl: item.images[0],
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) => const CircularProgressIndicator(),
                                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                                      )
                                                    : const Icon(Icons.image_not_supported),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Semantics(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            'Price: \$${item.price}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Semantics(
                                          child: Text(
                                            textAlign: TextAlign.center,
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

  // Helper method to parse price strings and handle cases like "$20" and "$20.00"
  double parsePrice(String priceString) {
    // Remove any non-numeric characters (like "$" or ",") and convert to double
    return double.tryParse(priceString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }
}
