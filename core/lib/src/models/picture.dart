import 'dart:convert';

import 'package:core/src/models/color_rgb.dart';

class Picture {
  final String text;
  final ColorRGB color;
  Picture({
    required this.text,
    required this.color,
  });

  Picture copyWith({
    String? text,
    ColorRGB? color,
  }) {
    return Picture(
      text: text ?? this.text,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'color': color.toMap(),
    };
  }

  factory Picture.fromMap(Map<String, dynamic> map) {
    return Picture(
      text: map['text'] ?? '',
      color: ColorRGB.fromMap(map['color']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Picture.fromJson(String source) =>
      Picture.fromMap(json.decode(source));

  @override
  String toString() => 'Picture(text: $text, color: $color)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Picture && other.text == text && other.color == color;
  }

  @override
  int get hashCode => text.hashCode ^ color.hashCode;
}
