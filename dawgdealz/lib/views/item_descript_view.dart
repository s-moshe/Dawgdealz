import 'package:flutter/material.dart';
import 'package:navigation/models/item.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart'; //not used
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:navigation/views/seller_profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDescription extends StatefulWidget {
  final Item item;

  const ItemDescription({super.key, required this.item});

  @override
  State<ItemDescription> createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  String sellerName = 'Unknown';
  String sellerEmail = 'unknown';

  @override
  void initState() {
    super.initState();
    fetchSellerInfo();
  }

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
                  itemCount: widget.item.images.length, // Total number of images
                  itemBuilder: (context, index) {
                    return ClipRect(
                      child: Image.network(
                        widget.item.images[index], // Load each image
                        height: 500,
                        width:  double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              Text(
                'Slide to view all images uploaded by seller.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                widget.item.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Item Description: ${widget.item.description}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Listed Date: ${widget.item.listedDate}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$${widget.item.price}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Condition: ${widget.item.condition}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Category: ${widget.item.category}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Seller Name: $sellerName',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 114, 88, 159), overlayColor: Colors.white),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellerProfileView(sellerId: widget.item.userId),
                  ),);
                },
                child: const Text('View Seller Profile', style: TextStyle(color: Colors.white)),
              )),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 114, 88, 159), overlayColor: Colors.white),
                  onPressed: () {
                    
                    sendEmail(sellerEmail);
                  },
                  child: const Text('Email Seller', style: TextStyle(color: Colors.white)),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchSellerInfo() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.item.userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          sellerName = data['name'] ?? 'Unknown';
          sellerEmail = data['email'] ?? 'unknown';
        });
      } else {
        debugPrint('Seller not found.');
      }
    } catch (e) {
      debugPrint('Error fetching seller info: $e');
    }
  }
  
  
  Future<void> sendEmail(String email) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: '$email@uw.edu',
    queryParameters: {
      'subject': 'DawgDealz - Item Inquiry',
      'body': 'Hi $sellerName, I am interested in your item: ${widget.item.name}.',
    },
  );
  if (await canLaunch(emailUri.toString())) {
    await launch(emailUri.toString());
  } else {
    
  }
}


}