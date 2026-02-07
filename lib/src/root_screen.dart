import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/views/manage_profile_screen/user_profile_screen.dart';
import 'package:umra_app/src/views/upload_medical_record_screen/add_record_screen.dart';
import 'package:umra_app/src/views/dashboard_screen/dashboard_screen.dart';
import 'package:umra_app/src/views/family_member_screen/family_member_screen.dart';
import 'package:umra_app/src/views/manage_profile_screen/manage_profile_screen.dart';
import 'package:umra_app/src/views/record_file_screen/record_file_screen.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class RootScreen extends StatefulWidget {

  final String initialMemberName;
  final String? initialMemberImage;

  static const routeName = "/RootScreen";
  const RootScreen({super.key, required this.initialMemberName, this.initialMemberImage});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    DashboardScreen(
      memberName: widget.initialMemberName,
      memberImage: widget.initialMemberImage,
    ),

    FamilyMemberScreen(myName: "Abdul Waheed", myAge: 22),
    const SizedBox(),
    RecordFileScreen(),
    ManageProfileScreen(),
  ];

  // Pick Image from gallery or camera
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print("Picked Image: ${image.path}");
    }
  }

  // Pick any file (pdf, doc, etc.)
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt', 'jpg', 'png'],
    );
    if (result != null && result.files.isNotEmpty) {
      print("Picked File: ${result.files.first.path}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      resizeToAvoidBottomInset: false,
      body: _screens[_currentIndex],

      /// 🔹 Bottom Navigation Bar with centered Upload button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: -4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              elevation: 0,
              color: AppColors.backgroundLight,
              child: SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Iconsax.home, "Home", 0),
                    _navItem(Iconsax.people, "Family", 1),

                    /// 🔹 Center Upload Button
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AddRecordScreen.routeName);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Iconsax.add, color: Colors.white),
                      ),
                    ),


                    _navItem(Iconsax.note, "Files ", 3),
                    _navItem(Iconsax.user, "Account", 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Bottom Navigation Item
  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : Colors.grey,
            size: 22,
          ),
          const SizedBox(height: 4),
          CustomTextWidget(
            text:  label,
              fontSize: 9,
              color: isActive ? AppColors.primary : Colors.grey,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,

          ),
        ],
      ),
    );
  }
}
