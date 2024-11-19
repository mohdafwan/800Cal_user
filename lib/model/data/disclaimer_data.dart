class disclaimer {
  final String name;
  final String description;
  disclaimer({
    required this.name,
    required this.description,
  });
}

final List<disclaimer> DisclaimerData = [
  disclaimer(
    name: "General Information Only",
    description:
        "The 800cal app functions solely as an aggregator for diet centers and meal programs. All diet-related information, meal plans, and recommendations displayed in the app are provided and maintained by third-party diet centers. 800cal does not create, recommend, or calculate any diet or health plans independently.",
  ),
  disclaimer(
    name: "No Medical Advice",
    description:
        "The information presented in the app is intended for general informational purposes and should not be viewed as medical advice. 800cal does not provide medical, health, or nutritional advice, diagnosis, or treatment. Users should seek the guidance of a licensed healthcare professional for any medical or dietary concerns.",
  ),
  disclaimer(
    name: "Third-Party Responsibility",
    description:
        "All diet programs, nutritional advice, and health-related services offered through the app are provided by licensed third-party diet centers. 800cal is not responsible for the accuracy, effectiveness, or safety of the information provided by these third parties. Users are encouraged to review the terms, conditions, and details provided by each licensed diet center.",
  ),
  disclaimer(
    name: "No Endorsement",
    description:
        "The inclusion of any diet center or plan in the 800cal app does not imply endorsement or recommendation by 800cal. The choice to engage with any of the third-party services is entirely at the user’s discretion.",
  )
];
