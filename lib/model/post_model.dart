import 'package:file_picker/file_picker.dart';

class PostModel {
  final String title;
  final PlatformFile image;
  final String? description;
  final bool? isFeatured;

  const PostModel({
    required this.title,
    required this.image,
    this.description,
    this.isFeatured = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'description': description,
      'isFeatured': isFeatured,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      title: map['title'] as String,
      image: map['image'] as PlatformFile,
      description: map['description'] as String,
      isFeatured: map['isFeatured'] as bool,
    );
  }
}

List<PostModel> postModelList = [];
