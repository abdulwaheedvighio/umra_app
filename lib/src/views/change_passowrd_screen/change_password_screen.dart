import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/gradient_container_widget.dart';
import 'package:umra_app/src/widgets/pin_input_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = "/ChangePasswordScreen";

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  int _currentStep = 0;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _resetPassword();
    }
  }

  void _resetPassword() {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Password reset successful")),
    );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // Background color of status bar
        statusBarIconBrightness: Brightness.light, // Android icons (battery, time)
        statusBarBrightness: Brightness.light, // iOS icons
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
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
                  text: "Reset Password",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(height: 6),
                CustomTextWidget(
                  text: "Secure your account with a new password",
                  fontSize: 13,
                  color: Colors.white70,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),

          /// 🔹 Header
          SizedBox(height: screenHeight * 0.030),
          /// 🔹 Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  _stepIndicator(),
                  const SizedBox(height: 20),
                  Expanded(child: _stepBody()),
                  const SizedBox(height: 20),

                  /// 🔹 Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        _currentStep == 2 ? "Update Password" : "Continue",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Step Indicator
  Widget _stepIndicator() {
    final steps = ["Email", "OTP", "Password"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final isActive = index == _currentStep;
        return Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              steps[index],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        );
      }),
    );
  }

  /// 🔹 Step Body
  Widget _stepBody() {
    switch (_currentStep) {

    /// EMAIL
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter your registered email", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 14),
            _inputField(
              controller: emailController,
              hint: "Email address",
              icon: Iconsax.message,
            ),
          ],
        );

    /// OTP
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Enter OTP sent to your email", style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            Center(child: OTPInputWidget()),
          ],
        );

    /// PASSWORD
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create a new password", style: TextStyle(fontSize: 15)),
            const SizedBox(height: 14),
            _passwordField(
              controller: passwordController,
              hint: "New Password",
              obscure: obscurePassword,
              toggle: () => setState(() => obscurePassword = !obscurePassword),
            ),
            const SizedBox(height: 14),
            _passwordField(
              controller: confirmPasswordController,
              hint: "Confirm Password",
              obscure: obscureConfirmPassword,
              toggle: () => setState(() => obscureConfirmPassword = !obscureConfirmPassword),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  /// 🔹 Input Field
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// 🔹 Password Field
  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(Iconsax.lock, size: 20),
        suffixIcon: IconButton(
          onPressed: toggle,
          icon: Icon(obscure ? Iconsax.eye_slash : Iconsax.eye, size: 20),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
