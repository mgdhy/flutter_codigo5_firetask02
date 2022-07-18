import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_firetask/ui/general/colors.dart';
import 'package:flutter_codigo5_firetask/ui/widgets/form_task_widget.dart';
import 'package:flutter_codigo5_firetask/ui/widgets/item_task_widget.dart';
import 'package:flutter_codigo5_firetask/ui/widgets/item_type_widget.dart';
import 'package:flutter_codigo5_firetask/ui/widgets/textfield_widget.dart';

import '../models/task_model.dart';

class HomeTaskPage extends StatefulWidget {
  @override
  State<HomeTaskPage> createState() => _HomeTaskPageState();
}

class _HomeTaskPageState extends State<HomeTaskPage>
    with TickerProviderStateMixin {

  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  final TextEditingController _searchController = TextEditingController();

  String taskId = "";

  finishedTask(BuildContext context) {
    _taskCollection
        .doc(taskId)
        .update(
          {
            "finished": true,
          },
        )
        .then(
          (value) {},
        )
        .whenComplete(
          () {
            Navigator.pop(context);
          },
        );
  }

  showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "¿Deseas finalizar esta tarea?",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kFontPrimaryColor.withOpacity(0.6),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        finishedTask(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        primary: Color(0xff02c39a),
                      ),
                      child: const Text(
                        "Finalizar",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showFormTask(BuildContext context) {
    showModalBottomSheet(
      barrierColor: kFontPrimaryColor.withOpacity(0.7),
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      transitionAnimationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 650),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: FormTaskWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(14.0),
        // hoverColor: Colors.red,
        // focusColor: Colors.yellow,
        // splashColor: Colors.green,
        // highlightColor: Colors.pink,
        onTap: () {
          showFormTask(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          decoration: BoxDecoration(
              color: kFontPrimaryColor,
              borderRadius: BorderRadius.circular(14.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              SizedBox(
                width: 6.0,
              ),
              Text(
                "Nueva tarea",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.027),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bienvenido, Ramón"),
                    Row(
                      children: [
                        Text(
                          "Mis Tareas",
                          style: TextStyle(
                            height: 1.1,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: kFontPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextFieldWidget(
                      hintText: "Buscar tareas...",
                      icon: Icons.search,
                      controller: _searchController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Todas mis tareas",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: kFontPrimaryColor.withOpacity(0.9),
                    ),
                  ),
                  StreamBuilder(
                    stream: _taskCollection
                        .orderBy("finished", descending: false)
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snap) {
                      if (snap.hasData) {
                        QuerySnapshot collection = snap.data;

                        List<QueryDocumentSnapshot> docs = collection.docs;

                        List<Map<String, dynamic>> docsMap = docs.map(
                          (e) {
                            Map<String, dynamic> myMap =
                                e.data() as Map<String, dynamic>;
                            myMap["id"] = e.id;
                            return myMap;
                          },
                        ).toList();

                        List<TaskModel> tasks = docs.map((e) {
                          TaskModel task = TaskModel.fromJson(
                              e.data() as Map<String, dynamic>);
                          task.id = e.id;
                          return task;
                        }).toList();

                        return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return ItemTaskWidget(
                              // myMap: docsMap[index],
                              task: tasks[index],
                              onFinished: () {
                                taskId = tasks[index].id;
                                showUpdateDialog(context);
                              },
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
