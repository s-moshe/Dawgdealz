import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation/helper/upload.dart';
import 'package:navigation/main.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ItemEntryView extends StatefulWidget {
  
  const ItemEntryView({super.key}); 

  @override
  State<ItemEntryView> createState() => _EntryItemViewState();
}

class _EntryItemViewState extends State<ItemEntryView> {
  final TextEditingController _nameController = TextEditingController(); 
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  String _selectedCategory = 'General'; 
  String _itemCondition = 'Used'; 
  final List<File> _uploadedPhotos = []; 
  final ImagePicker _picker = ImagePicker();
  bool isUploading = false; 

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _uploadedPhotos.add(File(image.path));  
      });
    }
  }

  // Generate description using Gemini model
  Future<void> _generateDescription() async {
 

    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyDAWK6ZMfj3W_iE4vpcN1lPcF5kzr3qEXs');
    final content = [Content.text('Give me a short description about ${_nameController.text} using two sentences.')];
    
    try {
      if (_nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter an item name for AI description.')),
      );
      } else {
      final response = await model.generateContent(content);
      setState(() {
        _descriptionController.text = response.text.toString();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully generated AI description!')));
      });
      }
    } catch (e) {
      print('Error generating description: $e');
      setState(() {
        _descriptionController.text = 'Failed to generate description.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                label: 'Item name input',
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    hintText: 'Enter item name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Button to generate description using Gemini AI.
              Semantics(
                label: 'Gemini AI Description Generator',
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      overlayColor: Colors.white
                    ),
                    onPressed: () {
                      // Trigger the function to generate the description.
                      _generateDescription();
                    },
                    child: const Text(
                      'Gemini AI Description 🤖', // Added robot emoji
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),


              Semantics(
                label: 'Item description input',
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter item description',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Semantics(
                label: 'Price Input',
                child: TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixText: '\$',
                    hintText: '0',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Semantics(
                label: 'Category selection dropdown',
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: [
                    'General', 'Clothes', 'Books', 'Office Supplies', 'Dorm Furnitures', 'Tickets & School Events'
                  ].map((category) => DropdownMenuItem(value: category, child: Text(category))).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value ?? 'General';
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Semantics(
                label: 'Condition Selection',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Condition',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, overlayColor: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Select Photo Source'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);  
                            },
                            child: const Text('Camera'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);  
                            },
                            child: const Text('Gallery'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.photo, color: Colors.white),
                  label: const Text('Add Photo', style: TextStyle(color: Colors.white)),
                ),
              ),
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
                              width: 100,
                              height: 100,
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
                                  _uploadedPhotos.remove(photo); 
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Center(
                child: _uploadItemButton(context),
              ),
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
          backgroundColor: const Color.fromARGB(255, 114, 88, 159), // Sets the button's background color.
          foregroundColor: Colors.white
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
                ),
              ),
      ),
    ),
  );
}

}
