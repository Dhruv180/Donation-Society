class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

// Update onboarding contents
List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Make a Difference",
    image: "images/image1.png",
    desc: "Easily donate food, clothes, or blood to those in need.",
  ),
  OnboardingContents(
    title: "Track Your Contributions",
    image: "images/image2.png",
    desc: "Monitor your donations and see the impact you're making.",
  ),
  OnboardingContents(
    title: "Join a Community",
    image: "images/image3.png",
    desc: "Connect with others who are committed to helping.",
  ),
];
