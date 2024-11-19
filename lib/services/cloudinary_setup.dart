import 'dart:io';

import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  final cloudinary = Cloudinary.signedConfig(
    // apiKey: '992636531583146',
    // apiSecret: 'iKb3qilFlfAjJvnSV0-RdB3uuBA',
    // cloudName: 'dbt5g25tx',
    apiKey: '897487449498569',
    apiSecret: '5vuR8XpAcJws48SKHkhl_858WG4',
    cloudName: 'dqtei4ujc',
  );

  Future<String> uploadFIle(File file) async {
    try {
      final response = await cloudinary.upload(
          file: file.path,
          fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.auto,
          folder: "gig-meister",
          fileName: DateTime.now().millisecondsSinceEpoch.toString(),
          progressCallback: (count, total) {
            print('Uploading image from file with progress: $count/$total');
          });

      if (response.isSuccessful) {
        print('Get your image from with ${response.secureUrl}');
        return response.secureUrl!;
      }
      return "";
    } catch (e) {
      print("Cloudinary upload failed: $e");
      return "";
    }
  }

  uploadFile(File imageFile) {}
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:get/get.dart';
// import 'package:cloudinary/cloudinary.dart';

// class CloudinaryService {
//   final cloudinary = Cloudinary.signedConfig(
//     apiKey: 'YOUR_API_KEY',
//     apiSecret: 'YOUR_API_SECRET',
//     cloudName: 'YOUR_CLOUD_NAME',
//   );

//   Future<String> uploadFile(File file) async {
//     try {
//       final response = await cloudinary.upload(
//         file: file.path,
//         fileBytes: file.readAsBytesSync(),
//         resourceType: CloudinaryResourceType.auto,
//         folder: "gig-meister",
//         fileName: DateTime.now().millisecondsSinceEpoch.toString(),
//         progressCallback: (count, total) {
//           print('Uploading image from file with progress: $count/$total');
//         },
//       );

//       if (response.isSuccessful) {
//         print('Get your image from with ${response.secureUrl}');
//         return response.secureUrl!;
//       }
//       return "";
//     } catch (e) {
//       print("Cloudinary upload failed: $e");
//       throw CloudinaryException('Cloudinary upload failed: $e');
//     }
//   }
// }

// // class CloudinaryException implements Exception {
// //   final String message;
// //   CloudinaryException(this.message);

// //   @override
// //   String toString() => 'CloudinaryException: $message';
// // }

// // uploadImage(ImageSource source, BuildContext context) async {
// //   final picker = await ImagePicker().pickImage(source: source);
// //   showLoaderDialog(context);

// //   if (picker != null) {
// //     try {
// //       String url = await CloudinaryService().uploadFile(File(picker.path));
// //       Get.back();
// //       if (url.isNotEmpty) {
// //         model!.image = url;
// //         update();
// //       } else {
// //         showErrorDialog(context, 'Failed to upload image.');
// //       }
// //     } catch (e) {
// //       Get.back();
// //       if (e is CloudinaryException) {
// //         // Handle Cloudinary-specific errors
// //         showErrorDialog(context, e.message);
// //       } else {
// //         // Handle other errors
// //         showErrorDialog(context, 'An unexpected error occurred: $e');
// //       }
// //     }
// //   } else {
// //     Get.back();
// //   }
// // }

// // void showLoaderDialog(BuildContext context) {
// //   showDialog(
// //     context: context,
// //     barrierDismissible: false,
// //     builder: (context) {
// //       return Center(
// //         child: CircularProgressIndicator(),
// //       );
// //     },
// //   );
// // }

// // void showErrorDialog(BuildContext context, String message) {
// //   showDialog(
// //     context: context,
// //     builder: (context) => AlertDialog(
// //       title: Text('Error'),
// //       content: Text(message),
// //       actions: [
// //         TextButton(
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //           child: Text('OK'),
// //         ),
// //       ],
// //     ),
// //   );
// // }
