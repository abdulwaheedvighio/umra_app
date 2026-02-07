import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:umra_app/src/constants/app_colors.dart'; // for your colors

class OTPInputWidget extends StatelessWidget {
  final void Function(String)? onCompleted;

  const OTPInputWidget({super.key, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
        fontSize: 20,
        color: AppColors.textLight,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColors.shadow.withValues(alpha: 0.09), // filled color
        borderRadius: BorderRadius.circular(15), // rounded corners
       // border: Border.all(color: AppColors.primary),
      ),
    );

    return Pinput(
      length: 6, // 4 input fields
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.shadow.withValues(alpha: 0.09), // filled color
          borderRadius: BorderRadius.circular(15),
          //border: Border.all(color: AppColors.primary, width: 2),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.shadow.withValues(alpha: 0.09), // filled color
          borderRadius: BorderRadius.circular(15),
          //border: Border.all(color: AppColors.primary),
        ),
      ),
      onCompleted: onCompleted,
      showCursor: true,
      cursor: Container(
        width: 2,
        height: 40,
        color: AppColors.primary,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
