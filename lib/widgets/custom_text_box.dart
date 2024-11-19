import 'package:eight_hundred_cal/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';

class CustomTextBox extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? obscureText;
  final bool showBorder;
  final bool readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? initialValue;
  final TextInputType? inputType;
  final int? maxLength;
  final bool error;
  const CustomTextBox({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.showBorder = false,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.initialValue,
    this.inputType,
    this.maxLength,
    this.error = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: inputType,
      initialValue: initialValue,
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.textgreyColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        fillColor: AppColor.inputBoxBGColor,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: showBorder
              ? BorderSide(color: AppColor.whiteColor, width: 0.50)
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: error
              ? BorderSide(color: Colors.red, width: 0.50)
              : (showBorder
                  ? BorderSide(color: AppColor.whiteColor, width: 0.50)
                  : BorderSide.none),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: error
              ? BorderSide(color: Colors.red, width: 0.50)
              : (showBorder
                  ? BorderSide(color: AppColor.whiteColor, width: 0.50)
                  : BorderSide.none),
        ),
      ),
      style: TextStyle(
        color: AppColor.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );

    // return TextFormField(
    //   maxLength: maxLength,
    //   keyboardType: inputType,
    //   initialValue: initialValue,
    //   controller: controller,
    //   readOnly: readOnly,
    //   onTap: onTap,
    //   onChanged: onChanged,
    //   obscureText: obscureText ?? false,
    //   decoration: InputDecoration(
    //     hintText: hintText,
    //     hintStyle: TextStyle(
    //       color: AppColor.textgreyColor,
    //       fontSize: 16,
    //       fontWeight: FontWeight.w400,
    //     ),
    //     fillColor: AppColor.inputBoxBGColor,
    //     filled: true,
    //     prefixIcon: prefixIcon,
    //     suffixIcon: suffixIcon,
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(15),
    //       borderSide: showBorder
    //           ? BorderSide(color: AppColor.whiteColor, width: 0.50)
    //           : BorderSide.none,
    //     ),
    //   ),
    //   style: TextStyle(
    //     color: AppColor.whiteColor,
    //     fontSize: 16,
    //     fontWeight: FontWeight.w400,
    //   ),

    // );
  }
}

// class CustomTextBox extends StatefulWidget {
//   final TextEditingController? controller;
//   final String hintText;
//   final Icon? prefixIcon;
//   final Icon? suffixIcon;
//   final bool obscureText;
//   final bool showBorder;
//   final bool readOnly;
//   final Function()? onTap;
//   final Function(String)? onChanged;
//   final String? initialValue;
//   final TextInputType? inputType;
//   final int? maxLength;
//   final bool error;

//   const CustomTextBox({
//     super.key,
//     this.controller,
//     required this.hintText,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.showBorder = false,
//     this.readOnly = false,
//     this.onTap,
//     this.onChanged,
//     this.initialValue,
//     this.inputType,
//     this.maxLength,
//     this.error = false,
//   });

//   @override
//   _CustomTextBoxState createState() => _CustomTextBoxState();
// }

// class _CustomTextBoxState extends State<CustomTextBox> {
//   bool isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       maxLength: widget.maxLength,
//       keyboardType: widget.inputType,
//       initialValue: widget.initialValue,
//       controller: widget.controller,
//       readOnly: widget.readOnly,
//       onTap: widget.onTap,
//       onChanged: widget.onChanged,
//       obscureText: widget.obscureText && !isPasswordVisible,
//       decoration: InputDecoration(
//         hintText: widget.hintText,
//         hintStyle: TextStyle(
//           color: AppColor.textgreyColor,
//           fontSize: 16,
//           fontWeight: FontWeight.w400,
//         ),
//         fillColor: AppColor.inputBoxBGColor,
//         filled: true,
//         prefixIcon: widget.prefixIcon,
//         suffixIcon: widget.obscureText
//             ? IconButton(
//                 icon: Icon(
//                   isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//                   color: AppColor.textgreyColor,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isPasswordVisible = !isPasswordVisible;
//                   });
//                 },
//               )
//             : widget.suffixIcon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: widget.showBorder
//               ? BorderSide(color: AppColor.whiteColor, width: 0.50)
//               : BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: widget.error
//               ? BorderSide(color: Colors.red, width: 0.50)
//               : (widget.showBorder
//                   ? BorderSide(color: AppColor.whiteColor, width: 0.50)
//                   : BorderSide.none),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15),
//           borderSide: widget.error
//               ? BorderSide(color: Colors.red, width: 0.50)
//               : (widget.showBorder
//                   ? BorderSide(color: AppColor.whiteColor, width: 0.50)
//                   : BorderSide.none),
//         ),
//       ),
//       style: TextStyle(
//         color: AppColor.whiteColor,
//         fontSize: 16,
//         fontWeight: FontWeight.w400,
//       ),
//     );
//   }
// }
