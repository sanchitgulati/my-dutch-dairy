class Journal {
  String? id;
  int millisecondsSinceEpoch;
  String heading;
  String text;

  Journal(
      {this.id,
      required this.millisecondsSinceEpoch,
      required this.heading,
      required this.text});

  Journal.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        millisecondsSinceEpoch = res["millisecondsSinceEpoch"],
        heading = res["heading"],
        text = res["text"];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'millisecondsSinceEpoch': millisecondsSinceEpoch,
      'heading': heading,
      'text': text
    };
  }
}
