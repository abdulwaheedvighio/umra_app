import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';
import 'package:umra_app/src/widgets/image_preview_screen.dart';
import 'package:umra_app/src/widgets/pdf_viewer_screen.dart';

class PatientReportScreen extends StatefulWidget {
  final String title;
  final int fileCount;
  final String report;
  final Color reportColor;
  final List<Map<String, String>> files;

  const PatientReportScreen({
    super.key,
    required this.title,
    required this.fileCount,
    required this.report,
    required this.reportColor,
    required this.files,
  });

  @override
  State<PatientReportScreen> createState() => _PatientReportScreenState();
}

class _PatientReportScreenState extends State<PatientReportScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, String>> filteredFiles = [];

  @override
  void initState() {
    super.initState();
    filteredFiles = List.from(widget.files);

    searchController.addListener(() {
      final query = searchController.text.toLowerCase();
      setState(() {
        filteredFiles = widget.files
            .where((file) =>
            file['name']!.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  /// Pick IMAGE from gallery
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      final file = result.files.single;

      final newFile = {
        'name': file.name,
        'path': file.path!,
        'type': 'image',
        'date': 'Uploaded Today',
      };

      setState(() {
        widget.files.add(newFile);
        filteredFiles.add(newFile);
      });
    }
  }

  /// Pick PDF file
  Future<void> _pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.single;

      final newFile = {
        'name': file.name,
        'path': file.path!,
        'type': 'pdf',
        'date': 'Uploaded Today',
      };

      setState(() {
        widget.files.add(newFile);
        filteredFiles.add(newFile);
      });
    }
  }

  /// Upload chooser
  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text("Upload Image"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text("Upload PDF"),
                onTap: () {
                  Navigator.pop(context);
                  _pickPdf();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
              text: widget.title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            CustomTextWidget(
              text: "${widget.files.length} Files",
              fontSize: 11,
              color: Colors.white70,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          /// Files
          Expanded(
            child: Column(
              children: [
                /// 🔹 Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search files...",
                      prefixIcon: const Icon(Iconsax.search_normal, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: AppColors.primary.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                /// 🔹 Files List
                Expanded(
                  child: ListView.builder(

                    itemCount: filteredFiles.length,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      final file = filteredFiles[index];
                      final isPdf = file['type'] == 'pdf';

                      return GestureDetector(
                        onTap: (){},
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300, // subtle light border
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isPdf ? Icons.picture_as_pdf : Icons.image_outlined,
                                color: AppColors.primary,
                                size: 30,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWidget(
                                      text: file['name']!,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(height: 4),
                                    CustomTextWidget(
                                      text: file['date']!,
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  if (isPdf) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PdfPreviewScreen(
                                          pdfPath: "assets/pdf/patient_report.pdf",
                                          title: file['name']!,
                                          date: file['date']!,
                                          status: "Report",
                                          statusColor: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ImagePreviewScreen(
                                          imagePath: file['path']!,
                                          title: file['name']!,
                                          date: file['date']!,
                                          status: "Report",
                                          statusColor: AppColors.primary,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const CustomTextWidget(text: "View"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

      /// FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _showUploadOptions,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
