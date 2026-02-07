class OnboardingModel {
  final String title;
  final String subtitle;
  final String heading;
  final String subHeading;
  final String image1; // main image
  final String? image2; // small overlay
  final List<String>? bullets; // 👈 nullable

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.heading,
    required this.image1,
    this.image2,
    this.bullets,required this.subHeading, // optional
  });
}
