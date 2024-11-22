import 'package:flutter/material.dart';
import 'package:navigation/views/custom_widget3.dart';


class CustomWidget1 extends StatefulWidget {
  const CustomWidget1({super.key});

  @override
  _CustomWidget1State createState() => _CustomWidget1State();
}

class _CustomWidget1State extends State<CustomWidget1> {
  List<String> sortedVenues = [
    'https://seattleunexplored.com/wp-content/uploads/2019/10/IMG_1583.jpg',
    'https://media.king5.com/assets/KING/images/cc646f21-1d12-42a7-9ba4-7c732a25de35/cc646f21-1d12-42a7-9ba4-7c732a25de35_1920x1080.jpg',
    'https://seattlecoffeescene.com/wp-content/uploads/2013/08/morsel-coffee-university-district.jpg',
    'https://res.cloudinary.com/the-infatuation/image/upload/q_auto,f_auto/cms/StBread_Patio_ChonaKasinger_Seattle01_7760',
    'https://static-content.owner.com/funnel/images/4ccce2d9-c490-4256-ad58-eacf4856c559?v=4369946875&w=3840&q=80&auto=format',
    'https://img.restaurantguru.com/w550/h367/r9d9-Oxbow-Urban-Kitchen-interior.jpg'
  ];

  List<String> displayedVenues = [];
  String search = '';

  @override
  void initState() {
    super.initState();
    displayedVenues = List.from(sortedVenues);
  }

  void _filterVenues(String query) {
    final filtered = sortedVenues.where((venue) {
      return venue.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedVenues = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (newText) {
                  _filterVenues(newText);
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
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: displayedVenues.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final venue = displayedVenues[index];

                  return InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>const CustomWidget3()));},
                    child: Card(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: (venue != null)
                                        ? Image.network(
                                            venue,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : const Icon(Icons.image_not_supported),
                                  ),
                                ],
                              ),
                              Semantics(
                                child: const Text(
                                  'Rating: 4.5',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                              Semantics(
                                child: Text(
                                  'Item $index',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Semantics(
                                child: const Text(
                                  '1 mi away',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
