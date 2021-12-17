import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadBlogPage extends StatefulWidget {
  const UploadBlogPage({Key? key}) : super(key: key);

  //for routing
  static const String routeName = "/uploadBlogPage";

  @override
  State<UploadBlogPage> createState() => _UploadBlogPageState();
}

class _UploadBlogPageState extends State<UploadBlogPage> {
  bool? _isChecked;
  PlatformFile? _platformFile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleTextEditingController = TextEditingController();
  final TextEditingController _descriptionTextEditingController = TextEditingController();

  Future<PlatformFile?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      return result.files[0];
    }
    return null;
  }

  Future<void> _handleUpload(BuildContext context) async {
    if (_formKey.currentState!.validate() && _platformFile != null) {
      print(_titleTextEditingController.text);
      print(_descriptionTextEditingController.text);
      print(_isChecked);
      print(_platformFile?.path);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Blog'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.upload),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAddProfileBtn(context),
                const SizedBox(height: 20),
                _buildFormFields(context),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SizedBox(
          height: 40,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _handleUpload(context);
            },
            child: const Text('Upload Post'),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleTextEditingController,
            validator: (value) {
              if (value != null) {
                return value.isEmpty ? 'title can not be empty' : null;
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'blog title',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _descriptionTextEditingController,
            validator: (value) {
              if (value != null) {
                return value.isEmpty ? 'description can not be empty' : null;
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'blog description',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 20),
          CheckboxListTile(
            title: const Text('Featured Post'),
            value: _isChecked ?? false,
            onChanged: (value) {
              setState(() {
                _isChecked = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddProfileBtn(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final PlatformFile? file = await pickImage();
        setState(() {
          _platformFile = file;
        });
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          image: _platformFile != null
              ? DecorationImage(
                  image: FileImage(
                    File(
                      _platformFile!.path!,
                    ),
                  ),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: const Center(
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.add_a_photo_outlined),
          ),
        ),
      ),
    );
  }
}
