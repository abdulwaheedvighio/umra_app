import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/root_screen.dart';
import 'package:umra_app/src/views/family_member_screen/add_family_member_bottom_sheet.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/gradient_container_widget.dart';
import '../../utils/utils.dart' show screenHeight, screenWidth;

class FamilyMemberScreen extends StatefulWidget {
  final String myName;
  final String? myImage;
  final int myAge;

  const FamilyMemberScreen({
    super.key,
    required this.myName,
    this.myImage,
    required this.myAge,
  });

  @override
  State<FamilyMemberScreen> createState() => _FamilyMemberScreenState();
}

class _FamilyMemberScreenState extends State<FamilyMemberScreen> {
  final List<Map<String, dynamic>> _familyMembers = [
    {
      "name": "Ayesha Khan",
      "relation": "Wife",
      "age": 28,
      "gender": "Female",
      "image": "assets/images/icons/user_image3.jpg"
    },
    {
      "name": "Ali Khan",
      "relation": "Son",
      "age": 6,
      "gender": "Male",
      "image": "assets/images/icons/user_image1.jpg"
    },
    {
      "name": "Sara Khan",
      "relation": "Daughter",
      "age": 10,
      "gender": "Female",
      "image": "assets/images/icons/user_image3.jpg"
    },
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Color _relationColor(String relation) {
    switch (relation.toLowerCase()) {
      case "wife":
      case "daughter":
        return Colors.pinkAccent;
      case "son":
        return Colors.blueAccent;
      case "mother":
        return Colors.green;
      case "father":
        return Colors.deepPurple;
      default:
        return AppColors.primary;
    }
  }

  Future<void> _addFamilyMember() async {
    final newMember = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const AddFamilyMemberBottomSheet(),
    );

    if (newMember != null) {
      final insertIndex = _familyMembers.length + 1;
      // +1 because index 0 = Myself

      _familyMembers.add(newMember);

      _listKey.currentState?.insertItem(
        insertIndex,
        duration: const Duration(milliseconds: 400),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          /// 🔹 HEADER
          GradientContainer(
            height: screenHeight * 0.22,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.025,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CustomTextWidget(
                  text: "Family Members",
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                SizedBox(height: 6),
                CustomTextWidget(
                  text: "Manage and upload family medical reports",
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ],
            ),
          ),

          /// 🔹 FIXED ADD FAMILY MEMBER CARD
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
            child: GestureDetector(
              onTap: _addFamilyMember,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle_outline,
                        color: AppColors.primary, size: 26),
                    SizedBox(width: 10),
                    CustomTextWidget(
                      text: "Add Family Member",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🔹 FAMILY LIST
          /// 🔹 FAMILY LIST
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: 1 + _familyMembers.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemBuilder: (context, index, animation) {
                final Map<String, dynamic> member = index == 0
                    ? {
                  "name": widget.myName,
                  "relation": "Myself",
                  "age": widget.myAge,
                  "image": widget.myImage ?? "assets/images/icons/waheed.png",
                }
                    : _familyMembers[index - 1];

                /// 🔐 SAFE VALUES
                final String name = member["name"]?.toString() ?? "Unknown";
                final String relation = member["relation"]?.toString() ?? "Member";
                final int age = member["age"] is int ? member["age"] : 0;
                final String image =
                    member["image"]?.toString() ?? "assets/images/icons/user_placeholder.png";

                final bool isMyself = relation == "Myself";
                final Color color = _relationColor(relation);

                return SizeTransition(
                  sizeFactor: animation,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RootScreen(
                            initialMemberName: name,
                            initialMemberImage: image,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: isMyself
                            ? Border.all(color: AppColors.primary, width: 1.5)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: color.withOpacity(0.15),
                            child: image.isNotEmpty
                                ? ClipOval(
                              child: Image.asset(
                                image,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Icon(
                                    Icons.person,
                                    size: 34,
                                    color: color,
                                  );
                                },
                              ),
                            )
                                : Icon(
                              Icons.person,
                              size: 34,
                              color: color,
                            ),
                          ),

                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: name,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: color.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: CustomTextWidget(
                                        text: relation,
                                        fontSize: 12,
                                        color: color,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    CustomTextWidget(
                                      text: "Age $age",
                                      fontSize: 13,
                                      color: AppColors.textLight,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 18, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
