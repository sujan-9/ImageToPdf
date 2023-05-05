
import 'dart:io';

// class ImageModel {
//   final File imagefile;

//   ImageModel(
//     this.imagefile,
//   );

//   ImageModel copyWith({
//     File? imagefile,
//   }) {
//     return ImageModel(
//       imagefile ?? this.imagefile,
//     );
//   }

// }

class ImageModel {
  final String path;
   final File imagefile;
  final String name;

  ImageModel(this.path, this.name, this.imagefile);
}