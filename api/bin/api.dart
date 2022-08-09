import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:core/core.dart';
import 'package:shelf_static/shelf_static.dart';

void main() async {
  final app = Router();
  const host = 'localhost';
  const port = 8080;

  app.get('/generate/<text>', (Request request, String text) {
    final file = customImage(text, path: 'images/');
    final fileName = file.path.split('/').last;

    return Response.ok('http://$host:$port/$fileName');
  });

  app.post('/generate', (Request request) async {
    final body = await request.readAsString();
    final Picture picture = Picture.fromJson(body);

    final file =
        customImage(picture.text, path: 'images/', color: picture.color);
    final fileName = file.path.split('/').last;

    return Response.ok('http://$host:$port/$fileName');
  });

  final staticHandler = createStaticHandler('images', listDirectories: true);

  final handler = Cascade().add(staticHandler).add(app).handler;

  await io.serve(handler, host, port);
}
