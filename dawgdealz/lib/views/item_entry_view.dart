import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation/helper/upload.dart';
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
  final TextEditingController _nameController = TextEditingController(); 
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String _selectedCategory = 'General'; // Holds the currently selected category from the dropdown.
  String _itemCondition = 'Used'; // Default for item condition
  final List<File> _uploadedPhotos = []; // list of uploaded
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false; // To prevent the item from being uploaded multiple times


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
              const Padding(padding: EdgeInsets.all(10.0)),
              // Input field for item name.
              Semantics(
                label: 'Item name input', // Accessibility label for screen readers.
                child: TextField(
                  controller: _nameController, // Connects the input field to the TextEditingController.
                  decoration: const InputDecoration(
                    labelText: 'Item Name', // Text displayed above the input field.
                    hintText: 'Enter item name',
                    border: OutlineInputBorder(), // Draws a border around the input field.
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Adds vertical space between widgets.

              // Input field for item description.
              Semantics(
                label: 'Item description input',
                child: TextField(
                  controller: _descriptionController, // Connects the input field to the TextEditingController.
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter item description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Adds vertical space.

              Semantics(
                  label: 'Price Input',
                  child: TextField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      prefixText: '\$', // This adds the dollar sign in front of the input field
                      hintText: '0.0',
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
                    'Dorm Furnitures',
                    'Tickets & School Events'
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
             _uploadItemButton(context),
            ],
          ),
        ),
      ),
    );
  }

  
Widget _uploadItemButton(BuildContext context) {
  return Center(
    child: Semantics(
      label: 'Upload item button', // Accessibility label for screen readers.
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 24.0, // Adds padding inside the button.
          ),
          backgroundColor: Colors.teal, // Sets the button's background color.
        ),
        onPressed: isUploading
            ? null
            : () async {
                setState(() {
                  isUploading = true; // Disable the button during upload.
                });

                if (_nameController.text.isEmpty || 
                    _priceController.text.isEmpty || 
                    double.tryParse(_priceController.text) == null) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Missing name or price (or invalid price)")),
                    );
                  }
                  setState(() {
                    isUploading = false; // Re-enable the button.
                  });
                  return;
                }

                List<String> uploadedImageUrls = [];
                bool success = true;

                for (var image in _uploadedPhotos) {
                  final imageUrl = await uploadItemImageForUser(image);
                  if (imageUrl != null) {
                    uploadedImageUrls.add(imageUrl);
                  } else {
                    success = false;
                    break;
                  }
                }

                if (success) {
                  await saveItemData(
                    _nameController.text,
                    _descriptionController.text,
                    _priceController.text,
                    _selectedCategory,
                    _itemCondition,
                    uploadedImageUrls,
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Item added successfully!")),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavDemo(title: 'DawgDealz'),
                      ),
                      (route) => false,
                    );
                  }
                } else if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Failed to upload item!")),
                  );
                }

                if (context.mounted) {
                  setState(() {
                    isUploading = false; // Re-enable the button.
                  });
                }
              },
        child: isUploading
            ? const CircularProgressIndicator() // Show a loading spinner during upload.
            : const Text(
                'Add Item', // Button label.
                style: TextStyle(
                  color: Colors.white, // Text color.
                  fontSize: 16.0, // Font size.
                  fontWeight: FontWeight.bold, // Bold text.
                ),
              ),
      ),
    ),
  );
}

}

