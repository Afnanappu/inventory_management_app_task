import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    required this.controller,
    this.prefixIcon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.focusNode,
    this.suffix,
    this.maxLength,
    this.readOnly = false,
    this.enabled = true,
    this.obscureText = false,
  });

  final String? label;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final Widget? suffix;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String? value)? validator;
  final FocusNode? focusNode;
  final int? maxLength;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
        TextFormField(
          readOnly: readOnly,
          enabled: enabled,
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          focusNode: focusNode,
          maxLength: maxLength,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffix,
            counterText: '',
            hintText: hintText,
            prefixIcon:
                prefixIcon == null
                    ? null
                    : Icon(prefixIcon, color: AppColors.textSecondary),
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
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
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

//         style: const TextStyle(color: AppColors.surfaceDark),
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
