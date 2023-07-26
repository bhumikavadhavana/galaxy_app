class Planet {
  String name;
  String name1;
  String image;
  String description;
  String bg;
  String velocity;
  String distance;
  String surface_gravity;
  String Surface_Temp;
  String Rotation_Period;
  String solar_orbit_period;
  String Details1;

  Planet({
    required this.name,
    required this.name1,
    required this.image,
    required this.description,
    required this.bg,
    required this.velocity,
    required this.distance,
    required this.surface_gravity,
    required this.Surface_Temp,
    required this.Rotation_Period,
    required this.solar_orbit_period,
    required this.Details1,
  });

  factory Planet.fromMap({required Map data}) {
    return Planet(
      name: data['name'],
      name1: data['name1'],
      image: data['image'],
      description: data['description'],
      bg: data['bg'],
      velocity: data['velocity'],
      distance: data['distance'],
      surface_gravity: data['surface_gravity'],
      Surface_Temp: data['Surface_Temp'],
      Rotation_Period: data['Rotation_Period'],
      solar_orbit_period: data['solar_orbit_period'],
      Details1: data['Details1'],
    );
  }
}
