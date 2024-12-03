import 'package:flutter/material.dart';
import 'package:navigation/views/edit_profile.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_email'


class AccountView extends StatelessWidget {
  final String name;
  final String bio;
  final String major;
  final String email;
  final int gradDate;
  //final String pfpLink;
  //final String pfpDesc;

  const AccountView({
    required this.name,
    required this.bio,
    required this.major,
    required this.email,
    required this.gradDate,
    //required this.pfpLink,
   // required this.pfpDesc
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
          //_buildImage(),
          const SizedBox(height: 8.0),
      
          //name and info
          _buildName(),
          const SizedBox(height: 4.0),
          
          //their listings
          //_buildListings()
          _buildEditButton(context)
        ],
      ),
    );
  }

  /*Widget _buildImage() {
    //check if image url is brocken
    print('Image URL: $pfpLink');
    return Center(
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
  }*/


//akldjfhdf

  Widget _buildName() {
    return Column(
      //mainAxisAlignment: ,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
        ),
        Text(
          'Major: $major',
          style: const TextStyle(fontSize: 16)
        ),
        Text(
          'Year: $gradDate',
          style: const TextStyle(fontSize: 16)
        ),
        Text(
          'About Me: $bio',
          style: const TextStyle(fontSize: 16)
        ),
        Row(
        children: [
          const Text(
            'Contact: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            //replace with flutter email sender if it doesn't work
            onTap: () async {
              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: '$email@uw.edu',
                query: 'subject=Dawg Dealz Request&body=Hi $name! I saw your profile listings, and I would like to discuss...',
              );
              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              } else {
                print('Could not launch email client');
              }
            },
            child: Text(
              '$email@uw.edu',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue, 
                decoration: TextDecoration.underline,
              ),
            ),
            //add an email me button?
          ),
        ],
      )
      ]   
    );
  }

  Widget _buildEditButton(context){
    return ElevatedButton(
          onPressed: (){_giveEditPage(context);}, 
          child: const Text('Edit Profile'));
  }

  _giveEditPage(context){
    Navigator.push(context, 
        MaterialPageRoute(builder: (context) => EditProfileWidget(name: name, bio: bio, major: major, email: email, gradDate: gradDate)),
    );
  }

}