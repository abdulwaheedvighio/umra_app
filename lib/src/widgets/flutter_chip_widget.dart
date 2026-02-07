import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class FilterChipWidget extends StatefulWidget {
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  final List<String> categories = ["All", "Imaging", "OPD Prescription", "CT scan","X-rays"];
  final List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0, // space between chips
      runSpacing: 8.0, // space between lines
      children: categories.map((category) {
        final isSelected = selectedCategories.contains(category);
        return FilterChip(
          label: CustomTextWidget(
            text: category,
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          selected: isSelected,
          showCheckmark: false, // ✅ ensure tick is visible
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedCategories.add(category);
              } else {
                selectedCategories.remove(category);
              }
            });
          },
          selectedColor: AppColors.primary,
          backgroundColor: Colors.grey.shade200,
          //checkmarkColor: Colors.white, // tick color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide.none,
          ),
          //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // enough space
        );
      }).toList(),
    );
  }
}
