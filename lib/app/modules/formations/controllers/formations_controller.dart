import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '../../../data/models/models.dart';
import '../../../data/services/api.dart';

class FormationsController extends GetxController {
  var formations = <Formation>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var inscriptions = <String>[]
      .obs; // Liste des IDs de formations auxquelles l'utilisateur est inscrit

  @override
  void onInit() {
    super.onInit();
    fetchFormations();
    fetchUserInscriptions();
  }

  Future<void> fetchFormations() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService.getFormations();
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        formations.value = data.map((e) => Formation.fromJson(e)).toList();
      } else {
        errorMessage.value = 'Erreur lors du chargement des formations';
      }
    } catch (e) {
      errorMessage.value = 'Erreur de connexion';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserInscriptions() async {
    final box = GetStorage();
    final userId = box.read('userId');
    if (userId == null) return;
    try {
      final response = await ApiService.getCertificats(userId);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        inscriptions.value = data
            .map((e) => e['idFormation'].toString())
            .toList();
      }
    } catch (_) {}
  }

  Future<void> inscrireAFormation(String formationId) async {
    final box = GetStorage();
    final userId = box.read('userId');
    if (userId == null) return;
    try {
      final response = await ApiService.inscrireAFormation(formationId, {
        'idUtilisateur': userId,
      });
      if (response.statusCode == 200) {
        inscriptions.add(formationId);
        Get.snackbar('Succès', 'Inscription réussie à la formation');
      } else {
        Get.snackbar('Erreur', 'Impossible de vous inscrire');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur de connexion');
    }
  }

  bool isUserInscrit(String formationId) {
    return inscriptions.contains(formationId);
  }
}
