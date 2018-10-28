class Followers {
  ///A link to the Web API endpoint providing full details of the followers; 
  ///`null` if not available. Please note that this will always be set to null, 
  ///as the Web API does not support it at the moment.
  String href;

  ///The total number of followers.
  int total;

  Followers(this.href, this.total);
  factory Followers.fromJSON(Map<String, dynamic> json) {
    return Followers(json["href"], json["total"]);
  }
}
