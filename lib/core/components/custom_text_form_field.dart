import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixIcon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: Colors.blue),
            filled: true,

            fillColor: Colors.white,
            contentPadding:
                prefixIcon == null
                    ? null
                    : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

// class CustomFormField extends StatelessWidget {
//   final String labelText;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//   final bool isFormEnabled;
//   final bool haveBorder;
//   final Widget prefixIcon;
//   final int maxLines;

//   final TextInputType keyboardType;
//   final double vPadding;

//   const CustomFormField({
//     super.key,
//     required this.labelText,
//     required this.controller,
//     this.validator,
//     this.isFormEnabled = true,
//     this.haveBorder = false,

//     this.keyboardType = TextInputType.text,
//     this.vPadding = 15,
//     required this.prefixIcon,
//     this.maxLines = 1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: vPadding),
//       child: TextFormField(
//         controller: controller,
//         validator: validator,

//         style: const TextStyle(color: AppColors.dark),
//         enabled: isFormEnabled,
//         cursorOpacityAnimates: true,
//         cursorColor: Colors.black54,
//         enableInteractiveSelection: true,
//         keyboardType: keyboardType,
//         cursorHeight: 18,
//         onTapOutside: (event) {
//           FocusScope.of(context).unfocus();
//         },
//         minLines: maxLines,
//         maxLines: null,
//         decoration: InputDecoration(
//           prefixIcon: prefixIcon,

//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide:
//                 haveBorder
//                     ? const BorderSide(color: Colors.grey)
//                     : BorderSide.none,
//           ),
//           // fillColor: formFillColor,
//           filled: true,
//           labelText: labelText,
//           labelStyle: TextStyle(color: Colors.grey),
//           floatingLabelStyle: const TextStyle(color: Colors.black54),
//           contentPadding: const EdgeInsets.only(left: 20),
//           hintFadeDuration: const Duration(milliseconds: 200),
//         ),
//       ),
//     );
//   }
// }
