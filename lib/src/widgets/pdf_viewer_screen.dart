import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:umra_app/src/constants/app_colors.dart';
import 'package:umra_app/src/widgets/custom_text_widget.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String pdfPath;
  final String title;
  final String date;
  final String status;
  final Color statusColor;

  const PdfPreviewScreen({
    super.key,
    required this.pdfPath,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  final PdfViewerController _pdfController = PdfViewerController();
  int currentPage = 1;
  int totalPages = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// 🔹 Glass AppBar (VIP Feel)
      appBar: AppBar(
        backgroundColor:AppColors.primary,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: CustomTextWidget(
          text: widget.title,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: Stack(
        children: [
          /// 🔹 PDF Viewer
          SfPdfViewer.asset(
            widget.pdfPath,
            controller: _pdfController,
            onDocumentLoaded: (details) {
              setState(() {
                totalPages = details.document.pages.count;
              });
            },
            onPageChanged: (details) {
              setState(() {
                currentPage = details.newPageNumber;
              });
            },
          ),

          /// 🔹 Top Floating Page Indicator
          Positioned(
            top: 20,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomTextWidget(
                text: "$currentPage / $totalPages",
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),

          /// 🔹 VIP Bottom Glass Toolbar
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.textLight.withValues(alpha: 0.60),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// 🔹 Document Info Row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(
                                  text: widget.title,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month,
                                        size: 13, color: Colors.white70),
                                    const SizedBox(width: 6),
                                    CustomTextWidget(
                                      text: widget.date,
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// Status Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: widget.statusColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: CustomTextWidget(
                              text: widget.status.toUpperCase(),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// 🔹 PDF Controls (WPS Style)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _controlIcon(
                            icon: Icons.zoom_out,
                            label: "Zoom -",
                            onTap: () {
                              _pdfController.zoomLevel =
                                  _pdfController.zoomLevel - 0.25;
                            },
                          ),
                          _controlIcon(
                            icon: Icons.zoom_in,
                            label: "Zoom +",
                            onTap: () {
                              _pdfController.zoomLevel =
                                  _pdfController.zoomLevel + 0.25;
                            },
                          ),
                          _controlIcon(
                            icon: Icons.arrow_upward,
                            label: "Prev",
                            onTap: () {
                              _pdfController.previousPage();
                            },
                          ),
                          _controlIcon(
                            icon: Icons.arrow_downward,
                            label: "Next",
                            onTap: () {
                              _pdfController.nextPage();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Control Button
  Widget _controlIcon({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.2),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          CustomTextWidget(
            text: label,
            fontSize: 11,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
