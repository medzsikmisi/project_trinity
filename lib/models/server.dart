class Server {
  int? id;
  String? processor;
  String? location;

  Server({this.id, this.processor, this.location});

  Server.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    processor = json['processor'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['processor'] = processor;
    data['location'] = location;
    return data;
  }
}
