enum NewsCategory {
  business(presentationName: "Business"),
  entertainment(presentationName: "Entertainment"),
  general(presentationName: "General"),
  health(presentationName: "Health"),
  science(presentationName: "Science"),
  sports(presentationName: "Sports"),
  technology(presentationName: "Technology");

  const NewsCategory({required this.presentationName});

  final String presentationName;
}
