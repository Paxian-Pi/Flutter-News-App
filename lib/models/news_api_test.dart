class NewsAPITest {
  final String status;
  final List<String> articles;

  NewsAPITest({required this.status, required this.articles});

  factory NewsAPITest.fromJson(final json) {
    return NewsAPITest(
      status: json["status"],
      articles: List<String>.from(json["articles"].map((article) => article)),
    );
  }
}
