import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_input_field.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import '../../utils/utils.dart';

class UploadMedicalRecord extends StatefulWidget {
  final File selectedFile;

  const UploadMedicalRecord({super.key, required this.selectedFile});

  @override
  State<UploadMedicalRecord> createState() => _UploadMedicalRecordState();
}

class _UploadMedicalRecordState extends State<UploadMedicalRecord> {
  final TextEditingController fileNameController = TextEditingController();
  final TextEditingController fileDateController = TextEditingController();
  final TextEditingController optionalNotesController = TextEditingController();

  // Category selection
  final List<String> categories = [
    "Lab Report",
    "CBC Report",
    "Heart Report",
    "Perception",
    "Other"
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: screenHeight * 0.18,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primary, AppColors.secondary],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CustomTextWidget(
                    text: "Add Medical Record",
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(height: 6),
                  CustomTextWidget(
                    text: "Upload photos or documents related to your medical history",
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Selected Image/File Preview
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cardDark.withValues(alpha: 0.1),
                ),
                child: ClipOval(
                  child: widget.selectedFile.path.endsWith(".jpg") ||
                      widget.selectedFile.path.endsWith(".png") ||
                      widget.selectedFile.path.endsWith(".jpeg")
                      ? Image.file(
                    widget.selectedFile,
                    fit: BoxFit.cover,
                  )
                      : Center(
                    child: Text(
                      widget.selectedFile.path.split('/').last,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Form Fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // File Name
                  CustomInputField(
                    hintText: "Enter File Name",
                    controller: fileNameController,
                    prefixIcon: const Icon(Iconsax.document),
                  ),
                  SizedBox(height: 12),

                  // Date Picker
                  CustomInputField(
                    fieldType: FieldType.date,
                    hintText: "Select Date",
                    controller: fileDateController,
                    prefixIcon: const Icon(Iconsax.calendar),
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        fileDateController.text =
                        "${pickedDate.toLocal()}".split(' ')[0];
                      }
                    },
                  ),
                  SizedBox(height: 12),

                  // Category Dropdown with chip inside the input field
                  GestureDetector(
                    onTap: () async {
                      final selected = await showDialog<String>(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text("Select Category"),
                          children: categories
                              .map(
                                (cat) => SimpleDialogOption(
                              onPressed: () => Navigator.pop(context, cat),
                              child: CustomTextWidget(text:cat),
                            ),
                          )
                              .toList(),
                        ),
                      );
                      if (selected != null) {
                        setState(() {
                          selectedCategory = selected;
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomInputField(
                        hintText: "Select Category",
                        controller:
                        TextEditingController(text: selectedCategory ?? ""),
                        prefixIcon: const Icon(Iconsax.document),
                        suffixWidget: selectedCategory != null
                            ? Padding(
                          padding:  EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 150,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50), // makes it fully rounded
                              ),
                              side: BorderSide.none,
                              label: CustomTextWidget(
                                text:  selectedCategory!,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: AppColors.primary,
                              deleteIcon: const Icon(Icons.close,
                                  size: 18, color: Colors.white),
                              onDeleted: () {
                                setState(() {
                                  selectedCategory = null;
                                });
                              },
                            ),
                          ),
                        )
                            : null,
                      ),
                    ),
                  ),

                  SizedBox(height: 12),

                  // Optional Notes
                  CustomInputField(
                    hintText: "Notes (Optional)",
                    controller: optionalNotesController,
                    prefixIcon: const Icon(Iconsax.note_2),
                    maxLines: 3,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle form submission here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        "Upload Record",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
