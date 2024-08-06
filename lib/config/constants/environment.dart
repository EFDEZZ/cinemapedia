
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String themovieDbKey = dotenv.env['The_MovieDB_Key'] ?? "No hay api key";
}