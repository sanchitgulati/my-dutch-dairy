class QnA {
  final String question;
  final List<MapEntry<String, String>> words;
  String text = '';

  QnA({required this.question, required this.words});

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['text'] = text;
    m['question'] = question;
    m['words'] = words;
    for (final entry in words) {
      m['words'] = entry.key;
    }
    return m;
  }
}
