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

  //adjfkhakljdfhaskjsdfh

  const EditProfileWidget({
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

  final FirestoreCrud firestore = FirestoreCrud();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    bioController = TextEditingController(text: widget.bio);
    majorController = TextEditingController(text: widget.major);
    emailController = TextEditingController(text: widget.email);
    gradDateController = TextEditingController(text: widget.gradDate.toString());
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
    final userProfileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField('Name', nameController),
            _buildTextField('Bio', bioController),
            _buildTextField('Major', majorController),
            _buildEmailField('Email', emailController),
            _buildTextField('Graduation Year', gradDateController, isNumber: true),
            
          
            ElevatedButton(
              /*
              onPressed: () {
                // Handle save action
                _saveProfile(); // Call _saveProfile when clicked
        
                print('Updated Profile:');
                print('Name: ${nameController.text}');
                print('Bio: ${bioController.text}');
                print('Major: ${majorController.text}');
                print('Email: ${emailController.text}');
                print('Graduation Year: ${gradDateController.text}');
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomWidget5(
                      name: nameController.text,
                      bio: bioController.text,
                      major: majorController.text,
                      email: emailController.text,
                      gradDate: int.parse(gradDateController.text),
                    ),
                  ),
                ); */             
              },
              child: const Text('Save'),*/
              
               onPressed: () async {
                final updatedData = {
                  'name': nameController.text.trim(),
                  'bio': bioController.text.trim(),
                  'major': majorController.text.trim(),
                  'email': emailController.text.trim(),
                  'gradDate': int.tryParse(gradDateController.text.trim()) ?? 2025,
                };
                await userProfileProvider.updateUserProfile(
                  FirebaseAuth.instance.currentUser!.uid,
                  updatedData,
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
      
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: User not logged in.')),
      );
      return;
    }

    final Map<String, dynamic> updatedData = {
      'name': nameController.text.trim(),
      'bio': bioController.text.trim(),
      'major': majorController.text.trim(),
      'email': emailController.text.trim(),
      'gradDate': int.tryParse(gradDateController.text.trim()) ?? 2025,
    };

    try {
      await firestore.updateUserProfile(userId, updatedData);
      print('Firestore Profile Updated:');
      print('Name: ${nameController.text}');
      print('Bio: ${bioController.text}');
      print('Major: ${majorController.text}');
      print('Email: ${emailController.text}');
      print('Graduation Year: ${gradDateController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pop(context, true); // Go back to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
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
          Text(
            emailDomain,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      const SizedBox(height: 16),
    ],
  );
}
}

