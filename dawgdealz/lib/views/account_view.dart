import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:navigation/models/profile_provider.dart';
import 'package:navigation/views/edit_profile.dart';
import 'package:navigation/views/login.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:navigation/firebase/firestore_crud.dart'; //NOT USED
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
//import 'package:flutter_email'



class AccountView extends StatelessWidget {
  final String uuid = FirebaseAuth.instance.currentUser?.uid ?? ''; 
  //final String name;
  //final String bio;
  //final String major;
  //final String email;
  //final int gradDate;
  //final String pfpLink;
  //final String pfpDesc;


  AccountView({super.key});




  late Future<DocumentSnapshot> userProfileFuture;
  @override




   Widget build(BuildContext context) {
    //final FirebaseFirestore firestore = FirebaseFirestore.instance;
    //FirestoreCrud firestore = FirestoreCrud(); // NOT USED 
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    print('Current User UID: $uuid'); 

    return  Scaffold(
      appBar: AppBar(
        title: const Text('Account Info'),
      ),
      body: userProfileProvider.userProfile == null
          ? FutureBuilder(
        future: userProfileProvider.fetchUserProfile(uuid),
        /*builder: (context, snapshot) {
         
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            //make dummy user if user is not found
            return FutureBuilder<void>(
              future: firestore.addDummyUser(uuid),
              builder: (context, createSnapshot) {
                if (createSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (createSnapshot.hasError) {
                  return Center(child: Text('Error creating user: ${createSnapshot.error}'));
                } else {
                  // Reload the page to fetch the newly created profile
                  return const Center(child: Text('User profile created. Please refresh.'));
                }
              },
            );
          } else {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
          padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(context, data), // Add the profile info
                  const SizedBox(height: 16.0),
                  _buildEditButton(context, data), // Add the edit button
                ],
              ),
            );
          }
        } */
       builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: Text('Profile loaded.'));
                }
              },
      ):
      Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfileProvider.userProfile!['name'] ?? 'Unknown',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Text('Major: ${userProfileProvider.userProfile!['major'] ?? 'Unknown'}'),
                  Text('Year: ${userProfileProvider.userProfile!['gradDate'] ?? 'Unknown'}'),
                  Text('About Me: ${userProfileProvider.userProfile!['bio'] ?? 'Unknown'}'),
                  _buildEmailText(
                    context,
                    userProfileProvider.userProfile!['email'],
                    userProfileProvider.userProfile!['name'],
                  ),
                  const SizedBox(height: 16),
                  const Text('Preferred Campus Meetup Spots:'),
                  ..._buildMeetupSpots(userProfileProvider.userProfile!),
                  const SizedBox(height: 16),
                  
                  _buildEditButton(context, userProfileProvider),
                  _buildLogOutButton(context)
                  
                ],
              ),
            ),
     
       );
  }


List<Widget> _buildMeetupSpots(Map<String, dynamic> userProfile) {
  final List<dynamic> spotsDynamic = userProfile['preferredMeetupSpots'] ?? [];
  final List<String> spots = List<String>.from(spotsDynamic); // Cast dynamic to List<String>

  return spots.map((spot) => Text('• $spot', style: const TextStyle(fontSize: 14))).toList();
}




Future<void> sendEmail(String email) async {
    final Email emailDetails = Email(
      body: 'Hi there,\n\nI saw your profile on DawgDealx and wanted to reach out! \n\n (Consider the following options to discuss: I want to buy items in a bundle, I want to discuss a meet-up spot, I want to rent an item instead of buying, I want to send an offer on an item, I want to give you a review as a buyer, etc.) \n\n ...',
      subject: 'Hello - Dawg Dealz Inquiry',
      recipients: ['$email@uw.edu'],
      cc: [],
      bcc: [],
      isHTML: false, 
    );


    try {
      await FlutterEmailSender.send(emailDetails);
      debugPrint('Email sent successfully!');
    } catch (error) {
      debugPrint('Failed to send email: $error');
    }
  }




// Widget _buildTestUrlLauncher(BuildContext context) {
//   final Uri testUrl = Uri.parse('https://www.google.com');


//   return GestureDetector(
//     onTap: () async {
//       if (await canLaunchUrl(testUrl)) {
//         await launchUrl(testUrl);
//       } else {
//         debugPrint('Could not launch $testUrl');
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Could not open the test URL.'))
//         );
//       }
//     },
//     child: const Text(
//       'Open Test URL',
//       style:  TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Colors.blue,
//         decoration: TextDecoration.underline,
//       ),
//     ),
//   );
// }

Widget _buildLogOutButton(BuildContext context) {
  return Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        // Show the confirmation dialog
        final shouldLogout = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Confirm Logout'),
              content: const Text('Are you sure you want to log out?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return "false"
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return "true"
                  },
                  child: const Text('Log Out'),
                ),
              ],
            );
          },
        );

        // If the user confirmed, log them out
        if (shouldLogout == true) {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
        }
      },
      child: const Text('Log Out', style: TextStyle(color: Colors.white)),
    ),
  );
}




Widget _buildEmailText(BuildContext context, String email, String userName) {
    return Row(
      children: [
        const Text(
          'Email: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            _openEmail(context, email, userName);
          },
          child: Text(
            '$email@uw.edu', // Automatically append @uw.edu
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }


void _openEmail(BuildContext context, String email, String userName) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: '$email@uw.edu',
      query: 'subject=Hello - Dawg Dealz Request&body=Hi $userName,\n\n I saw your profile on DawgDealx and wanted to reach out! \n\n (Consider the following options to discuss: I want to buy items in a bundle, I want to discuss a meet-up spot, I want to rent an item instead of buying, I want to send an offer on an item, I want to give you a review as a buyer, etc.) \n\n ...',
    );


    debugPrint('Email URI: $emailUri');
   
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email client')),
      );
    }
  }


//akldjfhdf


//this should build with whatever the new data that is fetched from
  // Widget _buildName(BuildContext context, Map<String, dynamic> data) {
  //   //initialize here instead of in constructor
  //   final String name = data['name'] ?? 'Unknown';
  //   final String major = data['major'] ?? 'Unknown';
  //   final int gradDate = data['gradDate'] ?? 0;
  //   final String bio = data['bio'] ?? 'No bio provided';
  //   final String email = data['email'] ?? 'unknown@example.com';
  //   return Column(
  //     //mainAxisAlignment: ,
  //     children: [
  //       Text(
  //         name,
  //         style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)
  //       ),
  //       Text(
  //         'Major: $major',
  //         style: const TextStyle(fontSize: 16)
  //       ),
  //       Text(
  //         'Year: $gradDate',
  //         style: const TextStyle(fontSize: 16)
  //       ),
  //       Text(
  //         'About Me: $bio',
  //         style: const TextStyle(fontSize: 16)
  //       ),
  //       Row(
  //       children: [
  //         const Text(
  //           'Contact: ',
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         ),
  //         GestureDetector(
  //           //replace with flutter email sender if it doesn't work
  //           onTap: () async {
  //             final Uri emailUri = Uri(
  //               scheme: 'mailto',
  //               path: '$email@uw.edu',
  //               query: 'subject=Dawg Dealz Request&body=Hi $name! I saw your profile listings, and I would like to discuss...',
  //             );
  //             if (await canLaunchUrl(emailUri)) {
  //               await launchUrl(emailUri);
  //             } else {
  //               debugPrint('Could not launch email client');
  //             }
  //           },
  //           child: Text(
  //             '$email@uw.edu',
  //             style: const TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.blue,
  //               decoration: TextDecoration.underline,
  //             ),
  //           ),
  //           //add an email me button?
  //         ),
  //       ],
  //     )
  //     ]  
  //   );
  // }


Widget _buildEditButton(BuildContext context, UserProfileProvider userProfileProvider) {
  return Center(child: ElevatedButton( 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 114, 88, 159),
                      foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileWidget(
                            name: userProfileProvider.userProfile!['name'] ?? '',
                            bio: userProfileProvider.userProfile!['bio'] ?? '',
                            major: userProfileProvider.userProfile!['major'] ?? '',
                            email: userProfileProvider.userProfile!['email'] ?? '',
                            gradDate: userProfileProvider.userProfile!['gradDate'] ?? 2025,
                          ),
                        ),
                      );
                    },
                    child: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
  ));
}


//once they open the view they can edit it

// NOT USED 
  // _giveEditPage(BuildContext context, String name, String bio, String major, String email, int gradDate) async {
  //   final updated = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => EditProfileWidget(
  //         name: name,
  //         bio: bio,
  //         major: major,
  //         email: email,
  //         gradDate: gradDate,
  //       ),
  //     ),
  //   );
  //   if (updated == true) {
  //     // Force rebuild of the FutureBuilder to fetch updated data
  //     FirestoreCrud firestore = FirestoreCrud();
  //     firestore.getUserProfile(uuid); // Call the helper function again to refresh
  //     (context as Element).markNeedsBuild();
  //   }
  // }


}

