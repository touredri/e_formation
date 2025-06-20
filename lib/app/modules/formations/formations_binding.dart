import 'package:e_formation/app/modules/formations/controllers/formations_controller.dart';
import 'package:get/get.dart';

class FormationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormationsController>(() => FormationsController());
  }
}
