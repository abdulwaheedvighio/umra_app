import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/responsive.dart';
import 'package:umra_app/src/views/manage_profile_screen/notification_screen.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class DashboardHeaderWidget extends StatefulWidget {
  final String memberName;
  final String? memberImage;

  const DashboardHeaderWidget({
    super.key,
    required this.memberName,
    this.memberImage,
  });

  @override
  State<DashboardHeaderWidget> createState() => _DashboardHeaderWidgetState();
}

class _DashboardHeaderWidgetState extends State<DashboardHeaderWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context);
    final bool isLandscape = Responsive.isLandscape(context);

    // Header height
    final double headerHeight = isLandscape
        ? Responsive.hp(context, 28)
        : isTablet
        ? Responsive.hp(context, 26)
        : Responsive.hp(context, 23);

    // Avatar Size
    final double avatarSize = isTablet ? Responsive.wp(context, 9) : Responsive.wp(context, 12);

    // Header Content
    Widget headerContent = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: headerHeight * 0.12),

        // Top Row: Avatar + Welcome + Notification
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: widget.memberImage != null && widget.memberImage!.isNotEmpty
                  ? Image.asset(
                widget.memberImage!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
              )
                  : Container(
                width: avatarSize,
                height: avatarSize,
                color: Colors.white24,
                child: Icon(
                  Icons.person,
                  size: Responsive.sp(context, 26),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: Responsive.wp(context, 3)),

            // Welcome Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: "Hello, Welcome",
                    fontSize: Responsive.sp(context, 13),
                    color: AppColors.textDark,
                  ),
                  SizedBox(height: Responsive.hp(context, 0.5)),
                  CustomTextWidget(
                    text: widget.memberName,
                    fontSize: Responsive.sp(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),

            // Notification Icon
            IconButton(
              icon: const Icon(Iconsax.notification, color: AppColors.textDark),
              iconSize: Responsive.sp(context, 24),
              onPressed: () {
                Navigator.pushNamed(context, NotificationScreen.routeName);
              },
            ),
          ],
        ),

        SizedBox(height: Responsive.hp(context, 2)),

        // Search Field
        // Search Field
        SizedBox(
          width: double.infinity,
          height: isLandscape
              ? Responsive.hp(context, isTablet ? 12 : 8.5) // Landscape me thodi badi
              : Responsive.hp(context, isTablet ? 5.5 : 6), // Portrait me normal
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.15),
              hintText: "Search here...",
              hintStyle: const TextStyle(color: Colors.white70),
              prefixIcon: const Icon(Iconsax.search_normal, color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

      ],
    );

    return Container(
      width: double.infinity,
      height: headerHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.secondary],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.wp(context, 6),
          vertical: Responsive.hp(context, 2),
        ),
        // Landscape => Scrollable, Portrait => Fixed
        child: isLandscape
            ? SingleChildScrollView(child: headerContent)
            : headerContent,
      ),
    );
  }
}
