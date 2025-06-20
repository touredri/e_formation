import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/services/api.dart';

class AuthController extends GetxController {
  // Champs pour les formulaires
  final emailController = ''.obs;
  final passwordController = ''.obs;
  final nameController = ''.obs;

  // Pour afficher les erreurs
  final errorMessage = ''.obs;

  // Pour l'état de chargement
  final isLoading = false.obs;

  // Méthode de connexion
  Future<void> login() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await ApiService.login({
        'email': emailController.value,
        'motDePasse': passwordController.value,
      });
      if (response.statusCode == 200) {
        // Stocker l'état de connexion et infos utilisateur
        final box = GetStorage();
        box.write('isLogged', true);
        // box.write('user', ...); // Stocke les infos utilisateur si besoin
        Get.offAllNamed('/home');
      } else {
        errorMessage.value = 'Email ou mot de passe incorrect';
      }
    } catch (e) {
      errorMessage.value = 'Erreur de connexion';
    } finally {
      isLoading.value = false;
    }
  }

}
