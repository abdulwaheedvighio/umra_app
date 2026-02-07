import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/views/sign_in_screen/sign_in_screen.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback? onConfirmed;

  const LogoutConfirmationDialog({super.key, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 Icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout,
                size: 40,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Title
            const Text(
              "Confirm Logout",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // 🔹 Message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Are you sure you want to logout?",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ❌ Cancel Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const CustomTextWidget(
                    text: "No",
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // ✅ Confirm Logout Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    // Call extra action if provided
                    if (onConfirmed != null) {
                      onConfirmed!();
                    } else {
                      Navigator.pushReplacementNamed(
                        context,
                        SignInScreen.routeName,
                      );
                    }
                  },
                  child: const CustomTextWidget(
                    text: "Yes",
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
