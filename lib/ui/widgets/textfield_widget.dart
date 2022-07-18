import 'package:flutter/material.dart';
import 'package:flutter_codigo5_firetask/ui/general/colors.dart';

class TextFieldWidget extends StatelessWidget {
  String hintText;
  IconData icon;
  int? maxLines;
  bool isDatePicker;
  Function? onTap;
  TextEditingController controller;

  TextFieldWidget({
    required this.hintText,
    required this.icon,
    this.maxLines,
    this.isDatePicker = false,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: kFontPrimaryColor,
          height: 1.0,
          fontSize: 13.0,
        ),
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: kBrandPrimaryColor,
          // fillColor: Colors.red,
          hintText: hintText,
          hintStyle: TextStyle(
            height: 1.0,
            fontSize: 13.0,
            color: kFontPrimaryColor.withOpacity(0.7),
          ),
          prefixIcon: Icon(
            icon,
            color: kFontPrimaryColor.withOpacity(0.55),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: (){
          if(isDatePicker){
            FocusScope.of(context).requestFocus(FocusNode());
            onTap!();
          }
        },
        validator: (String? value){
          if(value != null && value.isEmpty){
            return "Campo obligatorio";
          }
          return null;
        },
      ),
    );
  }
}
