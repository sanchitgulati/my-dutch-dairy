class StoryEntity {
  final String text;
  final List<MapEntry<String, String>> words;

  StoryEntity({required this.text, required this.words});

  factory StoryEntity.fromJson(Map<String, dynamic> json) {
    // Extract the values from the JSON map and create a QnA instance.
    return StoryEntity(
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
    m['words'] =
        words.map((entry) => {'key': entry.key, 'value': entry.value}).toList();

    return m;
  }
}
