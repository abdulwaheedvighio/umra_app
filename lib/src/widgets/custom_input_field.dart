import 'package:flutter/material.dart';

enum FieldType { text, dropdown, date }

class CustomInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FieldType fieldType;
  final List<String>? dropdownItems;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffixWidget; // <-- Added suffixWidget

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.fieldType = FieldType.text,
    this.dropdownItems,
    this.onTap,
    this.validator,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget, // <-- Accept suffixWidget
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fieldType == FieldType.dropdown || fieldType == FieldType.date
          ? () async {
        if (fieldType == FieldType.date && onTap != null) {
          onTap!();
        } else if (fieldType == FieldType.dropdown && dropdownItems != null) {
          String? selected = await showDialog<String>(
            context: context,
            builder: (context) => SimpleDialog(
              title: Text(hintText),
              children: dropdownItems!
                  .map(
                    (item) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, item),
                  child: Text(item),
                ),
              )
                  .toList(),
            ),
          );
          if (selected != null) controller.text = selected;
        }
      }
          : null,
      child: AbsorbPointer(
        absorbing: fieldType == FieldType.dropdown || fieldType == FieldType.date,
        child: TextFormField(
          controller: controller,
          readOnly: fieldType == FieldType.date || fieldType == FieldType.dropdown,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            // Use suffixWidget if provided, else fallback to suffixIcon or default icons
            suffixIcon: suffixWidget ??
                suffixIcon ??
                (fieldType == FieldType.date
                    ? const Icon(Icons.calendar_month)
                    : fieldType == FieldType.dropdown
                    ? const Icon(Icons.arrow_drop_down)
                    : null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
