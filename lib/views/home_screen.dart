
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controller/home_controller.dart';
import 'todo_details_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    late ScrollController scrollController;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              'Home Screen',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) => SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            onLoading: () async {
              final status = await controller.getTodoData();
              if (status) {
                controller.refreshController.loadComplete();
              } else {
                controller.refreshController.loadFailed();
              }
            },
            onRefresh: () async {
              final status = await controller.getTodoData(isRefresh: true);
              if (status) {
                controller.refreshController.refreshCompleted();
              } else {
                controller.refreshController.refreshFailed();
              }
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: controller.todoModelList.length,
              itemBuilder: (context, index) {
                final user = controller.todoModelList[index];
                return Card(
                  elevation: 5,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.id.toString()),
                    ),
                    title: Text('User Id:${user.userId}'),
                    subtitle: Text('Title: ${user.title}'),
                    trailing: Checkbox(
                      value: user.completed,
                      onChanged: (value) {},
                    ),
                    onTap: () =>
                        Get.to(const TodoDetailsScreen(), arguments: user.id),
                  ),
                );
              },
            ),
          ),
        ));
  }
}

//
// import 'package:ezzetech_assessment/controller/home_controller.dart';
// import 'package:ezzetech_assessment/views/todo_details_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomeScreen extends StatefulWidget {
//
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int itemCount=5;
//
//   @override
//   Widget build(BuildContext context) {
//     late ScrollController scrollController;
//    // final controller=Get.put(HomeController());
//     return Scaffold(
//       body: ListView(
//
//         children: [
//           GetBuilder<HomeController>(
//             init: HomeController(),
//             builder: (controller) => controller.isLoading?const Center(child: CircularProgressIndicator(
//
//             ),)
//                 :ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: itemCount,
//
//               itemBuilder: (context, index) {
//                 final user=controller.todoModelList[index];
//                 return Card(
//                   elevation: 5,
//                   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     leading:CircleAvatar(
//                       child:Text(user.id.toString()) ,
//
//                     ),
//                     title:Text('User Id:${user.userId}') ,
//                     subtitle:Text('Title: ${user.title}'),
//                     // title: Text('Title: ${user.title}'),
//                     // subtitle: Text('User Id:${user.userId}'),
//                     trailing: Checkbox(value: user.completed, onChanged: (value) {
//
//                     },),
//                     onTap: ()=>Get.to(const TodoDetailsScreen(),arguments: user.id),
//                   ),
//                 );
//
//               },),
//
//           ),
//           GetBuilder<HomeController>(
//           init: HomeController(),
//     builder: (controller) =>
//         ElevatedButton(onPressed: (){
//               setState((){
//
//                 if(itemCount+2>controller.todoModelList.length){
//                   itemCount=controller.todoModelList.length;
//                 }
//                 else{
//                   itemCount=itemCount+2;
//                 }
//
//
//               });
//             }, child: Text('See More')),
//           )
//         ],
//       )
//     );
//   }
// }
