import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageData extends StatefulWidget {
  const ImageData({
    super.key,
  });

  @override
  State<ImageData> createState() => _ImageDataState();
}

class _ImageDataState extends State<ImageData> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage(File imageFile) async {
    final url = Uri.parse(
        'https://app-production-7b68.up.railway.app/profile/552b2e62-e390-4856-86ef-cab674bc6ab4/setImage/');

    final request = http.MultipartRequest('POST', url);
    request.files.add(
      await http.MultipartFile.fromPath(
        'profileimage',
        imageFile.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);
      print('Success: $jsonResponse');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully!')),
      );
    } else {
      print('Error: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // return CircleAvatar(
    //   radius: 80,
    //   backgroundColor: Colors.amber,
    // );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_selectedImage != null)
            Image.file(
              _selectedImage!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_selectedImage != null) {
                uploadImage(_selectedImage!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select an image first!')),
                );
              }
            },
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
