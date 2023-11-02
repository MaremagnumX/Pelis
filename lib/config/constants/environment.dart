import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movideDbKey = dotenv.env["THEMOVIEDB_KEY"] ?? 'No hay API key';
}
