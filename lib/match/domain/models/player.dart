class Player {
  int? _id;
  String? _nombre;
  String? _picture;
  // Constructor
  Player({int? id, String? nombre, String? picture})
      : _id = id,
        _nombre = nombre,
        _picture = picture;

  // Getters
  int? get id => _id;
  String? get nombre => _nombre;
  String? get picture => _picture;

  // Setters
  set id(int? id) {
    _id = id;
  }

  set nombre(String? value) {
    _nombre = value;
  }

  set picture(String? value) {
    _picture = value;
  }

  //! Obtiene partido en base a estructura del json
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      nombre: json['firstName'],
      picture: json['picture'],
    );
  }
}
