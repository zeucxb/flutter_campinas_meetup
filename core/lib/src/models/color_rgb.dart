import 'dart:convert';

class ColorRGB {
  final int r;
  final int g;
  final int b;

  const ColorRGB(
    this.r,
    this.g,
    this.b,
  );

  ColorRGB copyWith({
    int? r,
    int? g,
    int? b,
  }) {
    return ColorRGB(
      r ?? this.r,
      g ?? this.g,
      b ?? this.b,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'r': r,
      'g': g,
      'b': b,
    };
  }

  factory ColorRGB.fromMap(Map<String, dynamic> map) {
    return ColorRGB(
      map['r']?.toInt() ?? 0,
      map['g']?.toInt() ?? 0,
      map['b']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorRGB.fromJson(String source) =>
      ColorRGB.fromMap(json.decode(source));

  @override
  String toString() => 'ColorRGB(r: $r, g: $g, b: $b)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorRGB && other.r == r && other.g == g && other.b == b;
  }

  @override
  int get hashCode => r.hashCode ^ g.hashCode ^ b.hashCode;
}
