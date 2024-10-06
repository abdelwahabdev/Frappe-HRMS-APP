import 'package:bio_attend/app/utils/helper/app_dimension.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? label;
  final List<String>? autoFill;
  final bool? visable;
  final int? maxLine;
  final VoidCallback? toggleSuffixIcon;
  final double? padding;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.toggleSuffixIcon,
    this.maxLine,
    this.keyboardType,
    this.visable,
    this.autoFill,
    this.label,
    this.padding,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 16),
      child: TextFormField(
        obscureText: visable ?? false,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0 * 1.5, vertical: 16.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            ),
          ),
          suffixIcon: visable != null
              ? IconButton(
                  onPressed: toggleSuffixIcon,
                  icon: Icon(visable ?? false
                      ? Icons.visibility
                      : Icons.visibility_off))
              : null,
        ),
      ),
    );
  }
}