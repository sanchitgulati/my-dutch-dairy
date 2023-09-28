class QnA {
  final String questionEnglish;
  final String question;
  final List<MapEntry<String, String>> words;
  String text = '';

  QnA(
      {required this.questionEnglish,
      required this.question,
      required this.text,
      required this.words});

  factory QnA.fromJson(Map<String, dynamic> json) {
    // Extract the values from the JSON map and create a QnA instance.
    return QnA(
      questionEnglish: json['questionEnglish'],
      question: json['question'],
      text: json['text'],
      words: (json['words'] as List<dynamic>)
          .map(
              (entry) => MapEntry<String, String>(entry['key'], entry['value']))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = {};

    m['text'] = text;
    m['question'] = question;
    m['questionEnglish'] = questionEnglish;
    m['words'] =
        words.map((entry) => {'key': entry.key, 'value': entry.value}).toList();

    return m;
  }
}
