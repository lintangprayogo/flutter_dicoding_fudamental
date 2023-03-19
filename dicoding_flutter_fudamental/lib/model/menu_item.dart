class MenuItem {
  final String name;

  const MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> data) {
    return MenuItem(name: data["name"]);
  }
}
