//Modelo de medalla
class Medal {
  int? _id;
  String? _description;
  int? _level;

  // Constructor
  Medal({
    int? id,
    String? description,
    int? level,
  })  : _id = id,
        _description = description,
        _level = level;

  // Getters
  int? get id => _id;
  String? get description => _description;
  int? get level => _level;

  // Setters
  set id(int? id) {
    _id = id;
  }

  set description(String? value) {
    _description = value;
  }

  set level(int? level) {
    _level = level;
  }

  //! Obtiene Medalla en base a estructura del json
  factory Medal.fromJson(Map<String, dynamic> json) {
    return Medal(
      id: json['id'],
      description: json['description'],
      level: json['level'],
    );
  }
}
