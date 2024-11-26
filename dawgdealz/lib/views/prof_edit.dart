import 'package:flutter/material.dart';
import 'package:navigation/views/custom_widget5.dart';

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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle save action
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
); */             },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
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
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfileWidget(
        name: '',
        bio: '',
        major: '',
        email: '',
        gradDate: 2025,
      ),
    );
  }
}*/