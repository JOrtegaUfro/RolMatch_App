class MapMatch {
  int? _id;
  double? _latitud;
  double? _longitud;
  String? _date;
  String? _duration;
  String? _hora;
  String? _sport;
  int? _totalSlots;
  int? _totalPlayers;
  String? _description;
  // Constructor
  MapMatch(
      {int? id,
      double? latitud,
      double? longitud,
      String? date,
      String? duration,
      String? hora,
      String? sport,
      int? totalSlots,
      int? totalPlayers,
      String? description})
      : _id = id,
        _latitud = latitud,
        _longitud = longitud,
        _date = date,
        _duration = duration,
        _hora = hora,
        _sport = sport,
        _totalSlots = totalSlots,
        _totalPlayers = totalPlayers,
        _description = description;

  // Getters
  int? get id => _id;
  double? get latitud => _latitud;
  double? get longitud => _longitud;
  String? get date => _date;
  String? get duration => _duration;
  String? get hora => _hora;
  String? get sport => _sport;
  int? get totalSlots => _totalSlots;
  int? get totalPlayers => _totalPlayers;
  String? get description => _description;

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

  set hora(String? value) {
    _hora = value;
  }

  set sport(String? sport) {
    _sport = sport;
  }

  set totalSlots(int? slots) {
    _totalSlots = slots;
  }

  set totalPlayer(int? players) {
    _totalSlots = players;
  }

  set description(String? value) {
    _description = value;
  }

  //! Obtiene partido en base a estructura del json
  factory MapMatch.fromJson(Map<String, dynamic> json) {
    return MapMatch(
      id: json['id'],
      latitud: json['latitude']?.toDouble(),
      longitud: json['longitude']?.toDouble(),
      date: json['date'],
      duration: json['duration'],
      hora: json['hour'],
      sport: json['sport'],
      totalSlots: json['playerSlots'],
      totalPlayers: json['totalPlayers'],
      description: json['description'],
    );
  }
}
