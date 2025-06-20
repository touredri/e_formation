import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Inscription utilisateur
  static Future<http.Response> register(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // Connexion utilisateur
  static Future<http.Response> login(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // Liste des formations
  static Future<http.Response> getFormations() async {
    return await http.get(Uri.parse('$baseUrl/formations'));
  }

  // S’inscrire à une formation
  static Future<http.Response> inscrireAFormation(
    String formationId,
    Map<String, dynamic> data,
  ) async {
    return await http.post(
      Uri.parse('$baseUrl/formations/$formationId/inscrire'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // Liste des inscrits à une formation
  static Future<http.Response> getInscrits(String formationId) async {
    return await http.get(
      Uri.parse('$baseUrl/formations/$formationId/inscrits'),
    );
  }

  // Détails d’une formation
  static Future<http.Response> getFormationDetails(String formationId) async {
    return await http.get(Uri.parse('$baseUrl/formations/$formationId'));
  }

  // Passer le quiz
  static Future<http.Response> passerQuiz(
    String formationId,
    Map<String, dynamic> data,
  ) async {
    return await http.post(
      Uri.parse('$baseUrl/formations/$formationId/quiz'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
  }

  // Voir les certificats
  static Future<http.Response> getCertificats(String userId) async {
    return await http.get(Uri.parse('$baseUrl/certificats/$userId'));
  }
}
