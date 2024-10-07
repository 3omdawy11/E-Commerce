class Generics {

  List<T> mapItems<T>(List<dynamic> data, T Function(Map<String, dynamic>) fromJson) {
    List<T> items = [];
    for (var item in data) {
      items.add(fromJson(item));
    }
    return items;
  }
}