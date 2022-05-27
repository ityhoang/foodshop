import 'dart:convert';

class News {
  final String contents;
  final String image;
  final num star;
  final num hlihgts;
  final num hot;
  final String id;
  final String title;
  News({
    required this.contents,
    required this.image,
    required this.star,
    required this.hlihgts,
    required this.hot,
    required this.id,
    required this.title,
  });

  factory News.fromJson(Map<String, dynamic> jsonData) {
    return News(
      contents: jsonData['contents'],
      image: jsonData['image'],
      star: jsonData['star'],
      hlihgts: jsonData['hlihgts'],
      hot: jsonData['hot'],
      id: jsonData['id'],
      title: jsonData['title'],
    );
  }
  static Map<String, dynamic> toMap(News news) => {
        'contents': news.contents,
        'image': news.image,
        'star': news.star,
        'hlihgts': news.hlihgts,
        'hot': news.hot,
        'id': news.id,
        'title': news.title,
      };

  static String encode(List<News> news) => json.encode(
        news.map<Map<String, dynamic>>((news) => News.toMap(news)).toList(),
      );

  static List<News> decode(String news) => (json.decode(news) as List<dynamic>)
      .map<News>((item) => News.fromJson(item))
      .toList();
}
