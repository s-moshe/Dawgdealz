import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SellerProfileView extends StatelessWidget {
  final String sellerId;

  const SellerProfileView({super.key, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 88, 159),
        title: const Text('Seller Profile',style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(sellerId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Seller profile not found.'));
          } else {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final List<dynamic> spotsDynamic =
                data['preferredMeetupSpots'] ?? [];
            final List<String> preferredMeetupSpots =
                spotsDynamic.cast<String>();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(context, data),
                  const SizedBox(height: 16),
                  const Text(
                    'Consider reaching out to the seller directly to learn more about their location or their availability, inquire about their services, or to leave a review. Some sellers may be open to selling items in bundles!',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  const Text(
                    'Preferred Campus Meetup Spots:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  preferredMeetupSpots.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: preferredMeetupSpots
                              .map((spot) => Text('- $spot',
                                  style: const TextStyle(fontSize: 14)))
                              .toList(),
                        )
                      : const Text('No preferred meetup spots listed.'),
                  const SizedBox(height: 16),
                  _buildEmailText(context, data['email'], data['name']),
                  const SizedBox(height: 16),
                  //_buildAdditionalDetails(data),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // reused from account view (static)
  Widget _buildName(BuildContext context, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['name'] ?? 'Unknown',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Major: ${data['major'] ?? 'Unknown'}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Year: ${data['gradDate'] ?? 'Unknown'}',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'About Me: ${data['bio'] ?? 'No bio provided'}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildEmailText(
      BuildContext context, String? email, String? userName) {
    final String fullEmail = '${email ?? 'unknown'}@uw.edu';
    return Row(
      children: [
        const Text(
          'Email: ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            _openEmail(context, fullEmail, userName ?? 'Unknown');
          },
          child: Text(
            fullEmail,
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
      path: email,
      query:
          'subject=Hello - Dawg Dealz Inquiry&body=I saw your profile on DawgDealx and wanted to reach out! \n\n (Consider the following options to discuss: I want to buy items in a bundle, I want to discuss a meet-up spot, I want to rent an item instead of buying, I want to send an offer on an item, I want to give you a review as a buyer, etc.) \n\n ...',
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email client')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open email client: $e')),
        );
      }
    }
  }

  //  NOT USED
  // Widget _buildAdditionalDetails(Map<String, dynamic> data) {
  //   // Additional seller details, if needed
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Additional Details',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: 8),
  //       Text('Listed Items: ${data['itemCount'] ?? 'No items'}'), // Example field
  //     ],
  //   );
  // }
}
