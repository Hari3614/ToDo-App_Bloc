class ToDoModel {
  String? id;
  String title;
  String description;
  bool isCompleted;
  String? createAt;
  String? updateAt;

  ToDoModel(
      {this.id,
      required this.title,
      required this.description,
      this.createAt,
      required this.isCompleted,
      this.updateAt});

  factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'] == true || json['is_completed'] == 1,
      id: json['_id'],
      createAt: json['created_at'],
      updateAt: json['updated_at']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
        "created_at": createAt,
        "updated_at": updateAt,
      };
}
