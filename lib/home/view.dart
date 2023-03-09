import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Center(
        child: Obx(
          () => logic.loading.value
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: logic.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(logic.tasks[index].name),
                      subtitle: Text(logic.tasks[index].createdAt),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(logic.tasks[index].avatar),
                      ),
                    );
                  },
                ),
        ),
      )
    );
  }
}
