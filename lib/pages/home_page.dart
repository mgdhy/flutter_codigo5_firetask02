import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> myTasks = [];

  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text(
                "Mis Tareas",
                style: TextStyle(fontSize: 22.0),
              ),
            ),
            Expanded(
              flex: 3,
              // child: ListView.builder(
              //   itemCount: myTasks.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(myTasks[index]["title"]),
              //       subtitle: Text("Estado: ${myTasks[index]["status"]} / Fecha: ${(myTasks[index]["created_date"] as Timestamp).toDate()}"),
              //     );
              //   },
              // ),
              child: FutureBuilder(
                future: _taskCollection.get(),
                builder: (BuildContext context, AsyncSnapshot snap) {
                  if (snap.hasData) {
                    List<Map<String, dynamic>> tasks = [];
                    QuerySnapshot collection = snap.data;
                    collection.docs.forEach((element) {
                      Map<String, dynamic> myMap =
                          element.data() as Map<String, dynamic>;
                      myMap["id"] = element.id;
                      tasks.add(myMap);
                    });

                    return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              tasks[index]["title"],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _taskCollection
                                    .doc(tasks[index]["id"])
                                    .delete()
                                    .whenComplete(
                                      () {
                                        print("Eliminado!");
                                        setState((){});
                                      },
                                    );
                              },
                            ),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // print(_taskCollection.id);
                      // print(_taskCollection.path);
                      // _taskCollection.get().then((QuerySnapshot collection) {
                      //   // print(collection.size);
                      //   // print(collection.docs);
                      //   List<QueryDocumentSnapshot> myDocs = collection.docs;
                      //
                      //   // print(myDocs[2].id);
                      //   // print(myDocs[2].data());
                      //
                      //   myDocs.forEach((element) {
                      //     print(element.id);
                      //     print(element.data());
                      //     print("..........................");
                      //   });
                      // });

                      // QuerySnapshot collection = await _taskCollection.get();
                      myTasks.clear();
                      _taskCollection.get().then((QuerySnapshot value) {
                        QuerySnapshot collection = value;
                        List<QueryDocumentSnapshot> docs = collection.docs;
                        docs.forEach((element) {
                          Map<String, dynamic> myMap =
                              element.data() as Map<String, dynamic>;
                          myTasks.add(myMap);
                        });
                        setState(() {});
                      });
                    },
                    child: Text("Get Data!"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _taskCollection.add(
                        {
                          "title": "Ir de campo dsfdsfd",
                          "status": false,
                          "created_date": DateTime.now(),
                        },
                      ).then((value) {
                        print(value.id);
                        setState(() {});
                      }).catchError((error) {
                        print(error);
                      });
                    },
                    child: Text("Create Document!"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _taskCollection.doc("fpCE3XF6yjkLcYnalYXX").update(
                        {
                          "status": true,
                        },
                      ).whenComplete(
                        () {
                          print("Future completado!");
                        },
                      ).catchError(
                        (error) {
                          print(error);
                        },
                      );
                    },
                    child: Text("Update Document"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _taskCollection
                          .doc("o0JCD7uiFmhREmrkvtmI")
                          .delete()
                          .whenComplete(
                        () {
                          print("Future completado");
                        },
                      ).catchError(
                        (error) {
                          print(error);
                        },
                      );
                    },
                    child: Text(
                      "Delete Document!",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _taskCollection.doc("miCodigoPersonalizado").set(
                        {
                          "title": "Ir al cine",
                          "status": false,
                          "created_date": DateTime.now(),
                        },
                      ).whenComplete(() {
                        print("Future completado!");
                      }).catchError((error) {
                        print(error);
                      });
                    },
                    child: Text(
                      "Create 2 Document!",
                    ),
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
