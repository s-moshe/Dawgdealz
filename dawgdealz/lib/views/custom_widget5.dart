import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class CustomWidget5 extends StatelessWidget {
  final String name;
  final String bio;
  final String major;
  final String email;
  final int gradDate;
  final String pfpLink;
  final String pfpDesc;

  const CustomWidget5({
    required this.name,
    required this.bio,
    required this.major,
    required this.email,
    required this.gradDate,
    required this.pfpLink,
    required this.pfpDesc
  });

  @override


   Widget build(BuildContext context) {
    return  Container(
      //width: 250, //hardcoded size (replace)
      //height: 225,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(10.0), // space inside border
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          //profile image
          _buildImage(),
          const SizedBox(height: 8.0),
      
          //name and info
          _buildName(),
          const SizedBox(height: 4.0),
          
          //their listings
          //_buildListings()
        ],
      ),
    );
  }

  Widget _buildImage() {
    //check if image url is brocken
    print('Image URL: $pfpLink');
    return Center( // This centers the entire content inside
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          pfpLink,
          height: 140,
          width: 225,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildName() {
    return Column(
      //mainAxisAlignment: ,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)
        ),
        Text(
          'Major: $major',
          style: const TextStyle(fontSize: 20)
        ),
        Text(
          'Year: $gradDate',
          style: const TextStyle(fontSize: 20)
        ),
        Text(
          'About Me: $bio',
          style: const TextStyle(fontSize: 20)
        ),
        Row(
        children: [
          const Text(
            'Email Me: ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              final emailUri = Uri(
                scheme: 'mailto',
                path: email,
              );
              launchUrl(emailUri);
            },
            child: Text(
              email,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Email link styled blue
                decoration: TextDecoration.underline, // Underlined for link effect
              ),
            ),
          ),
        ],
      )
      ]   
    );
  }

}