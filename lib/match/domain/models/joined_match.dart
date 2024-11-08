class JoinedMatch {
  int? _id;
  double? _latitud;
  double? _longitud;
  String? _date;
  String? _duration;
  String? _hora;
  String? _type;
  int? _totalSlots;
  int? _totalPlayers;
  String? _title;
  // Constructor
  JoinedMatch({
    int? id,
    double? latitud,
    double? longitud,
    String? date,
    String? duration,
    String? hora,
    String? type,
    int? totalSlots,
    int? totalPlayers,
    String? title,
  })  : _id = id,
        _latitud = latitud,
        _longitud = longitud,
        _date = date,
        _duration = duration,
        _hora = hora,
        _type = type,
        _totalSlots = totalSlots,
        _totalPlayers = totalPlayers,
        _title = title;

  // Getters
  int? get id => _id;
  double? get latitud => _latitud;
  double? get longitud => _longitud;
  String? get date => _date;
  String? get duration => _duration;
  String? get hora => _hora;
  String? get type => _type;
  String? get title => _title;
  int? get totalSlots => _totalSlots;
  int? get totalPlayers => _totalPlayers;

  // Setters
  set id(int? id) {
    _id = id;
  }

  set latitud(double? value) {
    _latitud = value;
  }

  set longitud(double? value) {
    _longitud = value;
  }

  set date(String? value) {
    _date = value;
  }

  set duration(String? value) {
    _duration = value;
  }

  set title(String? value) {
    _title = value;
  }

  set hora(String? value) {
    _hora = value;
  }

  set type(String? type) {
    _type = type;
  }

  set totalSlots(int? slots) {
    _totalSlots = slots;
  }

  set totalPlayer(int? players) {
    _totalPlayers = players;
  }

  //! Obtiene partido en base a estructura del json
  factory JoinedMatch.fromJson(Map<String, dynamic> json) {
    return JoinedMatch(
      id: json['id'],
      title: json['title'],
      latitud: json['latitude']?.toDouble(),
      longitud: json['longitude']?.toDouble(),
      date: json['date'],
      duration: json['duration'],
      hora: json['hour'],
      type: json['type'],
      totalSlots: json['playerSlots'],
      totalPlayers: json['totalPlayers'],
    );
  }
}
