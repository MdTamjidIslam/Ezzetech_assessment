
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_details_controller.dart';
import '../model/todo_model.dart';

class TodoDetailsScreen extends StatelessWidget {
  static const String routeName = '/todo_details';
  const TodoDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoDetailsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Todo Details',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder<TodoModel?>(
        future: controller.getSingleTodoData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(user.id.toString()),
                    ),
                    title: Text('User Id: ${user.userId}',
                      style: TextStyle(color: Colors.black, fontSize: 18),),

                    subtitle: Text(
                      'Title: ${user.title}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: Row(
                      children: [
                        Checkbox(
                          value: user.completed,
                          onChanged: (value) {},
                        ),
                        user.completed == true
                            ? const Text('Complete')
                            : const Text('NotComplete')
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
