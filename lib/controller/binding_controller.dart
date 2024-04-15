import 'package:get/get.dart';
import 'package:helios/controller/user_controller.dart';

class BindingController implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<UserController>(() => UserController(),fenix: false);
  }
}