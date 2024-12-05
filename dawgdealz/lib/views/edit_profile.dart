import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:navigation/firebase/firestore_crud.dart';
import 'package:navigation/models/profile_provider.dart';
import 'package:provider/provider.dart';

class EditProfileWidget extends StatefulWidget {
  final String name;
  final String bio;
  final String major;
  final String email;
  final int gradDate;
  final List<String> campusSpots = [
    'Red Square',
    'Quad',
    'Drumheller Fountain',
    'North Campus Dorms',
    'West Campus Dorms',
    'Other/Off Campus'
  ];
  //late List<bool> selectedSpots;

  //key added to line 18 and
  EditProfileWidget({
    super.key,
    required this.name,
    required this.bio,
    required this.major,
    required this.email,
    required this.gradDate,
  });
  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController majorController;
  late TextEditingController emailController;
  late TextEditingController gradDateController;
  late List<bool> selectedSpots;

  final FirestoreCrud firestore = FirestoreCrud();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    bioController = TextEditingController(text: widget.bio);
    majorController = TextEditingController(text: widget.major);
    emailController = TextEditingController(text: widget.email);
    gradDateController =
        TextEditingController(text: widget.gradDate.toString());
    selectedSpots = List<bool>.filled(widget.campusSpots.length, false);

    _initializeSelectedSpots(); // Fetch data and update selectedSpots
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    majorController.dispose();
    emailController.dispose();
    gradDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 88, 159),
        title: const Text('Edit Profile',style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Name', nameController),
            _buildTextField('Bio', bioController),
            _buildTextField('Major', majorController),
            _buildEmailField('Email', emailController),
            _buildTextField('Graduation Year', gradDateController,
                isNumber: true),
            _buildMeetupSpots(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 114, 88, 159),
                      foregroundColor: Colors.white
                    ),
              onPressed: () async {
                final currentContext = context; // Capture context locally

                final List<String> selectedMeetupSpots = [];
                for (int i = 0; i < widget.campusSpots.length; i++) {
                  if (selectedSpots[i]) {
                    selectedMeetupSpots.add(widget.campusSpots[i]);
                  }
                }

                final updatedData = {
                  'name': nameController.text.trim(),
                  'bio': bioController.text.trim(),
                  'major': majorController.text.trim(),
                  'email': emailController.text.trim(),
                  'gradDate':
                      int.tryParse(gradDateController.text.trim()) ?? 2025,
                  'preferredMeetupSpots': selectedMeetupSpots,
                };

                await userProfileProvider.updateUserProfile(
                  FirebaseAuth.instance.currentUser!.uid,
                  updatedData,
                );

                debugPrint('Updated data: $updatedData');

                if (currentContext.mounted) {
                  // Use the captured context and check if it is mounted
                  Navigator.pop(currentContext);
                }
              },
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeSelectedSpots() async {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      debugPrint('Error: User not logged in.');
      return;
    }

    try {
      // Fetch preferred meetup spots from Firestore

      final List<dynamic> spotsDynamic = await firestore.getMeetupSpots(userId);
      debugPrint('Fetched meetup spots: $spotsDynamic');
      final List<String> meetupSpots =
          spotsDynamic.cast<String>(); // Cast dynamic to List<String>

      setState(() {
        for (int i = 0; i < widget.campusSpots.length; i++) {
          selectedSpots[i] = meetupSpots.contains(widget.campusSpots[i]);
        }
      });
    } catch (e) {
      debugPrint('Error initializing preferred meetup spots: $e');
    }
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter $label',
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMeetupSpots() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferred Campus Meetup Spots:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...List.generate(widget.campusSpots.length, (index) {
          return CheckboxListTile(
            title: Text(widget.campusSpots[index]),
            value: selectedSpots[index],
            onChanged: (bool? value) {
              setState(() {
                selectedSpots[index] = value ?? false;
                debugPrint('Selected Spots: $selectedSpots'); // Debug output
              });
            },
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEmailField(String label, TextEditingController controller) {
    const String emailDomain = '@uw.edu'; // Hardcoded domain

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                //enabled:false,
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter $label',
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              emailDomain,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
