class Estudiante {
  final int? id;
  final String nombres;
  final int edad;
  final DateTime fecha;
  final String pais;
  final String ciudad;
  final double valorCurso;
  final double cuotaInicial;
  final double cuotaMensual;

  Estudiante({
    this.id,
    required this.nombres,
    required this.edad,
    required this.fecha,
    required this.pais,
    required this.ciudad,
    required this.valorCurso,
    required this.cuotaInicial,
    required this.cuotaMensual,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombres': nombres,
      'edad': edad,
      'fecha': fecha.toIso8601String(),
      'pais': pais,
      'ciudad': ciudad,
      'valorCurso': valorCurso,
      'cuotaInicial': cuotaInicial,
      'cuotaMensual': cuotaMensual,
    };
  }

  static Estudiante fromMap(Map<String, dynamic> map) {
    return Estudiante(
      id: map['id'],
      nombres: map['nombres'],
      edad: map['edad'],
      fecha: DateTime.parse(map['fecha']),
      pais: map['pais'],
      ciudad: map['ciudad'],
      valorCurso: map['valorCurso'],
      cuotaInicial: map['cuotaInicial'],
      cuotaMensual: map['cuotaMensual'],
    );
  }
}
