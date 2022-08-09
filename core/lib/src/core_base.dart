import 'dart:io';

import 'package:core/core.dart';
import 'package:image/image.dart';

String sanitizeFileName(String name) {
  return name.toLowerCase().replaceAll(' ', '_').replaceAll('%20', '_');
}

File customImage(
  String text, {
  String path = '',
  ColorRGB color = const ColorRGB(0, 0, 255),
}) {
  Image image = Image(320, 240);

  // Fill it with a solid color (blue)
  fill(image, getColor(color.r, color.g, color.b));

  // Draw some text using 24pt arial font
  drawString(image, arial_24, 0, 0, text);

  // Draw a line
  drawLine(image, 0, 0, 320, 240, getColor(255, 0, 0), thickness: 3);

  // // Blur the image
  // gaussianBlur(image, 10);

  final fileName = sanitizeFileName(text);

  // Save the image to disk as a PNG
  return File('$path$fileName.png')..writeAsBytesSync(encodePng(image));
}
