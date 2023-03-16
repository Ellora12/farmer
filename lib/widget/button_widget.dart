import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20, right: 20, top: 70),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 65,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [(new Color(0xff1fd655)), new Color(0xffF2861E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xffEEEEEE)),
          ],
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    ));
  }
}
