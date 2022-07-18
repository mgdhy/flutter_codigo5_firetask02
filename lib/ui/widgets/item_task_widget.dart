import 'package:flutter/material.dart';
import 'package:flutter_codigo5_firetask/ui/general/colors.dart';
import 'package:flutter_codigo5_firetask/ui/widgets/item_type_widget.dart';

import '../../models/task_model.dart';

class ItemTaskWidget extends StatelessWidget {
  // Map<String, dynamic> myMap;
  TaskModel task;
  Function onFinished;

  ItemTaskWidget({
    // required this.myMap,
    required this.task,
    required this.onFinished,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.024),
            offset: const Offset(4, 5),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTypeWidget(
                type: task.type,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kFontPrimaryColor,
                  decoration: task.finished ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
              Text(
               task.description,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: kFontPrimaryColor.withOpacity(0.7),
                ),
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
               task.date,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: kFontPrimaryColor.withOpacity(0.95),
                ),
              ),
            ],
          ),
          // Positioned(
          //   top: 0,
          //   right: -5,
          //   child: GestureDetector(
          //     onTap: (){
          //       print("Holaaaaa");
          //     },
          //     child: Icon(
          //       Icons.more_vert,
          //       color: kFontPrimaryColor.withOpacity(0.8),
          //     ),
          //   ),
          // ),
          Positioned(
            top: -10,
            right: -16,
            child: PopupMenuButton(
              onSelected: (int value) {
                if(value == 1){

                }else if( value == 2){
                  onFinished();
                }

              },
              elevation: 2,
              color: Colors.white,
              icon: Icon(
                Icons.more_vert,
                color: kFontPrimaryColor.withOpacity(
                  0.8,
                ),
              ),
              iconSize: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              itemBuilder: (BuildContext) {
                return [
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Editar",
                      style: TextStyle(
                        color: kFontPrimaryColor.withOpacity(0.8),
                        fontSize: 13.0,
                      ),
                    ),
                    value: 1,
                    onTap: () {
                      print("Editar");
                    },
                  ),
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Finalizar",
                      style: TextStyle(
                        color: kFontPrimaryColor.withOpacity(0.8),
                        fontSize: 13.0,
                      ),
                    ),
                    value: 2,
                    onTap: () {

                    },
                  ),
                ];
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: task.finished == true
                ? const Icon(
                    Icons.check_circle,
                    color: Color(0xff02c39a),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
