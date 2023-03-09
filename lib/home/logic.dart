import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../network/rest/rest_client.dart';

class HomeLogic extends GetxController {
  final loading = false.obs;
  final tasks = [].obs;
  final RestClient restClient = GetIt.instance.get<RestClient>();


  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  @override
  void onready() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadTasks() async {
    loading.value = true;
    var tasks = await restClient.getTasks();
    this.tasks.value = tasks;
    loading.value = false;
  }
}
