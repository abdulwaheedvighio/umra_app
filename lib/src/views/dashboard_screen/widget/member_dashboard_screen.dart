import 'package:flutter/material.dart';
import 'package:umra_app/src/constants/app_colors.dart';

class MemberDashboardScreen extends StatelessWidget {
  final String memberName;
  final Map<String, List<String>> reports; // each category with file paths

  const MemberDashboardScreen({
    super.key,
    required this.memberName,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("$memberName Dashboard"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: reports.entries.map((entry) {
          final reportType = entry.key;
          final files = entry.value;

          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reportType,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  files.isEmpty
                      ? Text("No files uploaded yet", style: TextStyle(color: Colors.grey[500]))
                      : Column(
                    children: files.map((filePath) {
                      return ListTile(
                        leading: Icon(filePath.endsWith(".pdf") ? Icons.picture_as_pdf : Icons.image,
                            color: AppColors.primary),
                        title: Text(filePath.split("/").last),
                        trailing: Icon(Icons.remove_red_eye, color: Colors.grey),
                        onTap: () {
                          // Open PDF or Image viewer here
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      // implement file picker for this member
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
