import 'package:flutter/material.dart';
import 'package:navigation/models/item.dart';

class ItemDescription extends StatelessWidget {
  final Item item;

  const ItemDescription({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 88, 159),
        title: const Text('Item',style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200, // Set the height of the image slider
                child: PageView.builder(
                  itemCount: item.images.length, // Total number of images
                  itemBuilder: (context, index) {
                    return ClipRect(
                      child: Image.network(
                        item.images[index], // Load each image
                        height: 500,
                        width:  double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Item Description: ${item.description}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed Date: ${item.listedDate}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$${item.price}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Condition: ${item.condition}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Category: ${item.category}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Seller Name: John Doe',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement email seller functionality here
                  },
                  child: const Text('Email Seller'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}