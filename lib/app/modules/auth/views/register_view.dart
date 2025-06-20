import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nom'),
              onChanged: (v) => controller.nameController.value = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (v) => controller.emailController.value = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
              onChanged: (v) => controller.passwordController.value = v,
            ),
            const SizedBox(height: 24),
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        // Appel de la méthode d'inscription à implémenter
                      },
                      child: const Text('S\'inscrire'),
                    ),
            ),
            Obx(
              () => Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Get.offNamed('/login'),
              child: const Text('Déjà un compte ? Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
