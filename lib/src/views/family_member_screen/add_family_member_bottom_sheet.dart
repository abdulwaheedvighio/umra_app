import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class AddFamilyMemberBottomSheet extends StatefulWidget {
  const AddFamilyMemberBottomSheet({super.key});

  @override
  State<AddFamilyMemberBottomSheet> createState() =>
      _AddFamilyMemberBottomSheetState();
}

class _AddFamilyMemberBottomSheetState
    extends State<AddFamilyMemberBottomSheet> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String selectedRelation = "Wife";
  String selectedGender = "Female";

  final List<String> relations = [
    "Wife",
    "Son",
    "Daughter",
    "Mother",
    "Father",
    "Brother",
    "Sister",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const CustomTextWidget(
                text: "Add Family Member",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 20),

              _inputField("Full Name", nameController),
              const SizedBox(height: 14),
              _inputField("Age", ageController, isNumber: true),
              const SizedBox(height: 14),

              const CustomTextWidget(
                text: "Relation",
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: selectedRelation,
                items: relations
                    .map(
                      (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRelation = value!;
                    selectedGender = (value == "Son" ||
                        value == "Father" ||
                        value == "Brother")
                        ? "Male"
                        : "Female";
                  });
                },
                decoration: _decoration(),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  _genderChip("Male"),
                  const SizedBox(width: 12),
                  _genderChip("Female"),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        ageController.text.isEmpty) return;

                    Navigator.pop(context, {
                      "id": DateTime.now()
                          .millisecondsSinceEpoch
                          .toString(),
                      "name": nameController.text.trim(),
                      "relation": selectedRelation,
                      "gender": selectedGender,
                      "age": int.parse(ageController.text),
                    });
                  },
                  child: const CustomTextWidget(
                    text: "Save Member",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: _decoration(hint: hint),
    );
  }

  InputDecoration _decoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _genderChip(String gender) {
    final bool isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedGender = gender),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
              isSelected ? AppColors.primary : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: CustomTextWidget(
              text: gender,
              color:
              isSelected ? AppColors.primary : AppColors.textLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
