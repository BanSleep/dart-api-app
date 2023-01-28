class UsersModel {
  String? name;
  String? lastName;
  int? id;

  UsersModel({this.name, this.lastName, this.id});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['name'] = name;
    json['last_name'] = lastName;
    json['id'] = id;
    return json;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}