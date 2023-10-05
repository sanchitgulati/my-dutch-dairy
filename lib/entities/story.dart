class StoryEntity {
  final String text;
  final List<String> words;

  StoryEntity({required this.text, required this.words});

  factory StoryEntity.fromJson(Map<String, dynamic> json) {
    // Extract the values from the JSON map and create a QnA instance.
    return StoryEntity(
      text: json['text'],
      words: json['words'].toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = {};

    m['text'] = text;
    m['words'] = words.toList();

    return m;
  }
}
