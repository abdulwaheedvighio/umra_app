import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:file_picker/file_picker.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/utils/utils.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/flutter_chip_widget.dart';
import 'package:umra_app/src/views/record_file_screen/patient_report_screen.dart';
import 'package:umra_app/src/widgets/gradient_container_widget.dart';
import 'package:umra_app/src/widgets/report_card_widget.dart';

class RecordFileScreen extends StatefulWidget {
  const RecordFileScreen({super.key});

  @override
  State<RecordFileScreen> createState() => _RecordFileScreenState();
}

class _RecordFileScreenState extends State<RecordFileScreen> {
  final TextEditingController searchController = TextEditingController();
  late List<Map<String, dynamic>> filteredCategories;



  List<Map<String, dynamic>> categories = [
    {
      "title": "Blood Report",
      "report": "Perception",
      "color": AppColors.primary,
      "image": "assets/images/icons/hand_blood_icon.png",
      "files": [
        {
          "name": "Blood Test Report.pdf",
          "path": "assets/pdf/patient_report.pdf",
          "type": "pdf",
          "date": "10 Feb 2026",
        },
        {
          "name": "CBC Result.pdf",
          "path": "assets/pdf/cbc_test_report1.pdf",
          "type": "pdf",
          "date": "09 Feb 2026",
        },
        {
          "name": "Blood Sample Image.png",
          "path": "assets/images/icons/cbc_test_report.png",
          "type": "image",
          "date": "08 Feb 2026",
        },
      ],
    },
    {
      "title": "Heart Beat",
      "report": "Stable",
      "color": AppColors.error,
      "image": "assets/images/icons/heart_beat_icon.png",
      "files": [
        {
          "name": "ECG Report.pdf",
          "path": "assets/pdf/patient_report.pdf",
          "type": "pdf",
          "date": "07 Feb 2026",
        },
        {
          "name": "ECG Report.png",
          "path": "assets/images/icons/heart_beat_image.png",
          "type": "pdf",
          "date": "07 Feb 2026",
        },
      ],
    },
    {
      "title": "Vision Test",
      "report": "Normal",
      "color": AppColors.warning,
      "image": "assets/images/icons/health_file_icon.png",
      "files": [
        {
          "name": "Eye Scan.png",
          "path": "assets/images/icons/ultrasound_report.png",
          "type": "image",
          "date": "05 Feb 2026",
        },
      ],
    },
  ];


  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories);
    searchController.addListener(_searchRecords);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary, // Background color of status bar
        statusBarIconBrightness: Brightness.light, // Android icons (battery, time)
        statusBarBrightness: Brightness.light, // iOS icons
      ),
    );
  }

  void _searchRecords() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCategories = categories
          .where((c) => c['title'].toString().toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _refreshRecords() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      filteredCategories = List.from(categories);
      searchController.clear();
    });
  }



  void _showFileTypeDialog({String? categoryName}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget(text:
              "Upload File",
              fontSize: 18, fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 10),
            const CustomTextWidget(text: "Select the type of file you want to upload."),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickFile(categoryName: categoryName, fileType: 'image');
                  },
                  icon: const Icon(Icons.image),
                  label: const CustomTextWidget(text: "Image"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _pickFile(categoryName: categoryName, fileType: 'pdf');
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const CustomTextWidget(text: "PDF"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile({String? categoryName, String? fileType}) async {
    FilePickerResult? result;

    if (fileType == 'image') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
    } else if (fileType == 'pdf') {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
    }

    if (result != null) {
      final fileName = result.files.single.name;
      final filePath = result.files.single.path!;
      final finalType = fileType ?? (fileName.endsWith('.pdf') ? 'pdf' : 'image');
      final date = "Uploaded Today";

      setState(() {
        Map<String, dynamic>? category = categories.firstWhere(
              (cat) => cat['title'] == categoryName,
          orElse: () => {},
        );

        if (category.isEmpty) {
          category = {
            "title": categoryName ?? "New Report",
            "report": "New",
            "color": AppColors.primary,
            "files": [],
          };
          categories.add(category);
        }

        category['files'].add({
          "name": fileName,
          "path": filePath,
          "type": finalType,
          "date": date,
        });

        filteredCategories = List.from(categories);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomTextWidget(text: "$fileName uploaded successfully"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      resizeToAvoidBottomInset: false, // keyboard-safe
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerSection(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: FilterChipWidget()),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshRecords,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final item = filteredCategories[index];
                  final files = List<Map<String, String>>.from(item['files'] ?? []);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PatientReportScreen(
                            title: item['title'] ?? "Unknown",
                            fileCount: files.length,
                            report: item['report'] ?? "Unknown",
                            reportColor: item['color'] ?? AppColors.primary,
                            files: files,
                          ),
                        ),
                      );
                    },
                    child: ReportCard(
                      image: item['image'] ?? "assets/images/icons/health_file_icon.png",
                      title: item['title'] ?? "Unknown",
                      subTitle: files.isNotEmpty
                          ? (files.last['date'] ?? "No date")
                          : "No files yet",
                      report: item['report'] ?? "Unknown",
                      reportColor: item['color'] ?? AppColors.primary,
                      fileCount: files.length,
                    ),
                  );
                },
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _headerSection(){
    return GradientContainer(
        height: screenHeight * 0.22,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.050),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.070,),
            CustomTextWidget(
              text: "Your Health Record",
              color: AppColors.backgroundLight,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
            SizedBox(height: screenHeight * 0.030,),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
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
                ),
                const SizedBox(width: 12),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(color: AppColors.backgroundLight, borderRadius: BorderRadius.circular(24)),
                  child: const Icon(Iconsax.setting, color: AppColors.primary),
                ),
              ],
            ),
          ],
        )
    );
  }
}

/// Header Section
