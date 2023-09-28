class JournalEntry {
  int questionId;
  String text;

  JournalEntry({required this.questionId, required this.text});

  toJSONEncodable() {
    Map<String, dynamic> m = Map();

    m['text'] = text;
    m['question'] = questionId;

    return m;
  }
}
