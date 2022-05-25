import 'package:firebase/auth/forget_password.dart';
import 'package:firebase/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class login extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const login({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool passwordObscured = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    // loading circle
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    // pop the loading circle
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(25.0),
                  height: 200,
                  child: Image.asset(
                    "assets/images/fingerPrint.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40),
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                child: TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "required"),
                    EmailValidator(errorText: "not valid email")
                  ]),
                  controller: emailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_outlined,
                        size: 20,
                      ),
                      hintText: "Email ID"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                ),
                child: TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "required"),
                    MinLengthValidator(8,
                        errorText: 'password must be at least 8 digits long'),
                    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                        errorText:
                            'passwords must have at least one special character')
                  ]),
                  controller: passwordController,
                  obscureText: passwordObscured,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              passwordObscured = !passwordObscured;
                            });
                          },
                          icon: Icon(passwordObscured
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      hintText: "Password"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => forgetPassword()));
                    }),
                    child: Container(
                      padding: EdgeInsets.only(right: 40, top: 10),
                      child: Text(
                        "Forget Password?",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                // fontWeight: FontWeight.bold,
                                fontSize: 12)),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                  child: Container(
                padding: EdgeInsets.only(left: 40, right: 40, top: 5),
                child: ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  ),
                ),
              )),
              Center(child: Text("OR")),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.grey[500],
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => home()));
                    },
                    child: Container(
                      child: Container(
                        width: 180,
                        height: 20,
                        child: Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Image.asset(
                                "assets/images/google.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Text(
                                "Login with Google",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
              // Center(child: Text("Not a member?")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Row(children: [
                      Text("Not a member?"),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          ))
                    ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
