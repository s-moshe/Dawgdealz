import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation/main.dart'; // Import the file where NavDemo is defined, which represents the main app structure.

class ItemEntryView extends StatefulWidget {
  const ItemEntryView(
      {super.key}); // A StatefulWidget because the state (inputs) can change.

  @override
  State<ItemEntryView> createState() => _EntryItemViewState();
}

// This class manages the state (data and UI behavior) of the ItemEntryView.
class _EntryItemViewState extends State<ItemEntryView> {
  // TextEditingController allows us to control the text inside the input fields.
  final TextEditingController _nameController = TextEditingController(
      text: "Sample Item"); // Pre-filled placeholder text.
  final TextEditingController _descriptionController = TextEditingController(
      text: "This is a sample description."); // Pre-filled placeholder text.
  final TextEditingController _locationController =
      TextEditingController(text: "UW");

  String _selectedCategory =
      'General'; // Holds the currently selected category from the dropdown.
  String _itemCondition = 'Used'; // Default for item condition
  final List<File> _uploadedPhotos = []; // list of uploaded

  final ImagePicker _picker = ImagePicker();

   // Method to pick an image from the camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _uploadedPhotos.add(File(image.path));  // Add the image file to the list of uploaded photos
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Add New Item'), // AppBar displays the title of the page.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back button icon.
          onPressed: () {
            // When the back button is pressed, navigate back to NavDemo (main app with tabs).
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const NavDemo(
                      title: 'DawgDealz')), // Navigate to NavDemo.
              (route) => false, // Clear all previous screens from the stack.
            );
          },
          tooltip:
              'Go back', // Tooltip text shown when hovering over the button.
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Adds space around the content inside the screen.
        child: SingleChildScrollView(
          // Allows the screen to scroll if the content exceeds the height of the screen.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Aligns children to the start of the column.
            children: [
              // Input field for item name.
              Semantics(
                label:
                    'Item name input', // Accessibility label for screen readers.
                child: TextField(
                  controller:
                      _nameController, // Connects the input field to the TextEditingController.
                  decoration: const InputDecoration(
                    labelText:
                        'Item Name', // Text displayed above the input field.
                    border:
                        OutlineInputBorder(), // Draws a border around the input field.
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Adds vertical space between widgets.

              // Input field for item description.
              Semantics(
                label: 'Item description input',
                child: TextField(
                  controller:
                      _descriptionController, // Connects the input field to the TextEditingController.
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Adds vertical space.

              // input field for location TODO:geolocater?
              Semantics(
                  label: 'Location Input',
                  child: TextField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                  )),
              const SizedBox(height: 20),

              // Dropdown menu for selecting a category.
              Semantics(
                label:
                    'Category selection dropdown', // Accessibility label for screen readers.
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory, // The currently selected category.
                  items: [
                    'General',
                    'Clothes',
                    'Books',
                    'Office Supplies',
                    'Dorm Furnitures'
                  ] // Dropdown menu options.
                      .map((category) => DropdownMenuItem(
                            value:
                                category, // Value associated with this option.
                            child: Text(
                                category), // Text displayed for this option.
                          ))
                      .toList(),
                  onChanged: (value) {
                    // Update _selectedCategory whenever a new category is selected.
                    setState(() {
                      _selectedCategory = value ??
                          'General'; // Default to 'General' if value is null.
                    });
                  },
                  decoration: const InputDecoration(
                    labelText:
                        'Category', // Text displayed above the dropdown menu.
                    border:
                        OutlineInputBorder(), // Draws a border around the dropdown.
                  ),
                ), //sfjsalhfa
              ),
              const SizedBox(height: 40), // Adds vertical space.

              // radio buttons for used / new conditions
              Semantics(
                  label: 'Condition Selection',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Condition',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('New'),
                              value: 'New',
                              groupValue: _itemCondition,
                              onChanged: (value) {
                                setState(() {
                                  _itemCondition = value!;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Used'),
                              value: 'Used',
                              groupValue: _itemCondition,
                              onChanged: (value) {
                                setState(() {
                                  _itemCondition = value!;
                                });
                              },
                            ),
                            
                            )
                        ],
                      )
                    ],
                  )),
                  const SizedBox(height: 20),
                  // Button to add photos.
              Semantics(
                label: 'Add photos button',
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Placeholder logic for adding photos.
                     // Show a dialog to choose between camera or gallery
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select Photo Source'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);  // Take a picture
                            },
                            child: const Text('Camera'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);  // Pick from gallery
                            },
                            child: const Text('Gallery'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.photo), // Icon for the button.
                  label: const Text('Add Photo'),
                ),
              ),
              const SizedBox(height: 10),

              // Display uploaded photos (placeholder).
              if (_uploadedPhotos.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Uploaded Photos:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                   Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: _uploadedPhotos.map((photo) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            width: 100, // Adjust width.
                            height: 100, // Adjust height.
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(photo),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _uploadedPhotos.remove(photo); // Remove photo when delete icon is clicked.
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 40),
              // Save button.
              Center(
                child: Semantics(
                  label:
                      'Save item button', // Accessibility label for screen readers.
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0,
                          horizontal: 24.0), // Adds padding inside the button.
                      backgroundColor:
                          Colors.teal, // Sets the button's background color.
                    ),
                    onPressed: () {
                      // Navigate directly to the main NavDemo widget (Home page) without simulating saving.
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NavDemo(title: 'DawgDealz')),
                        (route) =>
                            false, // Clear all previous pages from the navigation stack.
                      );
                    },
                    child: const Text(
                      'Add Item', // Text displayed inside the button.
                      style: TextStyle(
                        color: Colors.white, // Text color.
                        fontSize: 16.0, // Font size.
                        fontWeight: FontWeight.bold, // Bold text.
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

