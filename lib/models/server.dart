class Server {
  String? id;
  String? name;
  bool? isAvailable;
  String? price;
  String? capacity;

  Server({this.id, this.capacity, this.isAvailable, this.price, this.name});

  Server.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    id = json['id'];
    capacity = json['capacity'];
    price = json['price'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['capacity'] = capacity;
    data['price'] = price;
    data['is_available'] = price;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return 'Server with id: $id, name:$name';
  }
}
