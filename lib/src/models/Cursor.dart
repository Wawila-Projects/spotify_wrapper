class Cursor {
  ///The cursor to use as key to find the next page of items.
  String after;

  ///The cursor to use as key to find the previous page of items.
  String before;

  Cursor(this.after, this.before);

  factory Cursor.fromJSON(Map<String, dynamic> json) {
    return Cursor(json['after'], json['before']);
  }
}