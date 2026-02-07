import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class UserEditProfileScreen extends StatefulWidget {
  static const routeName = "/UserEditProfileScreen";

  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,

      /// 🔹 APP BAR
      appBar: AppBar(
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const CustomTextWidget(
          text: "Edit Profile",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.cardDark),
        ),
      ),

      /// 🔹 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [

            /// 🔹 PROFILE IMAGE
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      border: Border.all(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: _profileImage == null
                        ? const Icon(Iconsax.user, size: 40, color: Colors.grey)
                        : ClipOval(
                      child: Image.file(
                        _profileImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Iconsax.camera,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const CustomTextWidget(
              text: "Tap to change profile picture",
              fontSize: 12,
              color: Colors.grey,
            ),

            const SizedBox(height: 30),

            /// 🔹 FORM CARD
            _formCard(
              child: Column(
                children: [
                  _inputField(
                    controller: nameCtrl,
                    hintText: "Full Name",
                    icon: Iconsax.user,
                  ),
                  _inputField(
                    controller: emailCtrl,
                    hintText: "Email Address",
                    icon: Iconsax.sms,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  _inputField(
                    controller: cityCtrl,
                    hintText: "City",
                    icon: Iconsax.location,
                  ),
                  _inputField(
                    controller: countryCtrl,
                    hintText: "Country",
                    icon: Iconsax.global,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// 🔹 SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  // TODO: Save profile
                },
                child: const CustomTextWidget(
                  text: "Save Changes",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Input Field
  Widget _inputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// 🔹 Form Card Container
  Widget _formCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

