import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/views/upload_medical_record_screen/upload_medical_record.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/gradient_container_widget.dart';

class AddRecordScreen extends StatefulWidget {
  static const routeName = "/AddRecordScreen";

  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  File? selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) navigateToUpload(File(image.path));
  }

  Future<void> selectFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) navigateToUpload(File(image.path));
  }

  Future<void> browseFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      navigateToUpload(File(result.files.single.path!));
    }
  }

  void navigateToUpload(File file) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UploadMedicalRecord(selectedFile: file),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          GradientContainer(
            height: screenHeight * 0.22,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.050,
              vertical: screenHeight * 0.025,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CustomTextWidget(
                  text: "Add Medical Record",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(height: 6),
                CustomTextWidget(
                  text: "Upload photos or documents related to your medical history",
                  fontSize: 13,
                  color: Colors.white70,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),


          SizedBox(height: screenHeight * 0.03),

          // Upload options
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.050,vertical: screenHeight * 0.010),
            child: Column(
              children: [
                UploadOptionTile(
                  icon: Iconsax.camera,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.primary,
                  title: "Take a Photo",
                  onTap: takePhoto,
                ),
                SizedBox(height: screenHeight * 0.015),
                UploadOptionTile(
                  icon: Iconsax.gallery,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.warning,
                  title: "Select from Gallery",
                  onTap: selectFromGallery,
                ),
                SizedBox(height: screenHeight * 0.015),
                UploadOptionTile(
                  icon: Iconsax.document,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.success,
                  title: "Browse Device Files",
                  onTap: browseFiles,
                ),

                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),

          // Selected file preview
          if (selectedFile != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(
                  text: "Selected File:",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10),
                Text(
                  selectedFile!.path.split('/').last,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

/// Reusable Upload Option Widget
class UploadOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final VoidCallback onTap;

  const UploadOptionTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: screenHeight * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: screenWidth * 0.04),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
