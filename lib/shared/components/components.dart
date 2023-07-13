import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

Widget defaultButton(width, height, text, arrow, fn) => TextButton(
    onPressed: fn,
    child: Container(
      width: width,
      height: height,
      alignment: AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [
            Colors.teal,
            Color(0xFF80CBC4),
          ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$text",
              style: GoogleFonts.montserrat(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          SizedBox(
            width: 20,
          ),
          if (arrow) ...[
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ] else
            Icon(Icons.logout_outlined, color: Colors.white),
        ],
      ),
    ));

Widget getErrorText(String errorText) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Container(
        height: 16,
        child: Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                errorText,
                style: TextStyle(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFFF0000),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )),
  );
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  String? Function(String?)? validate,
  required String label,
  void Function()? suffixPressed,
  required var prefix,
  IconData? suffix,
  bool isClickable = true,
  TextStyle? style,
  GlobalKey<FormFieldState>? key,
  FloatingLabelBehavior? floatingLabelBehavior,
  String? intialvalue,
}) =>
    TextFormField(
      initialValue: intialvalue,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: '$label',
        labelStyle: GoogleFonts.montserrat(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        prefixIcon: Icon(prefix, color: Colors.black),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: Colors.black,
                ),
              )
            : null,
      ),
    );

Widget buildReportItem({
  required context,
  required String dentistname,
  required String patientname,
  required String observation,
  required String date,
  required String time,
}) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${dentistname}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                      Text(
                        '$date at $time ',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              'Patient Name: ${patientname}',
            ),
            SizedBox(
              width: 15.0,
            ),
            Text('Observation: ${observation}'),
          ],
        ),
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

String toCamelCase(String? word) {
  List<String> words = word!.split(' ');
  String w = "";
  // Capitalize the first letter of each word except the first word
  for (int i = 0; i < words.length; i++) {
    String currentWord = words[i];
    words[i] = currentWord[0].toUpperCase() + currentWord.substring(1);
    // words[i+1] = ' ';
    w += words[i] + " ";
  }
  // Join the words without spaces
  return w;
}