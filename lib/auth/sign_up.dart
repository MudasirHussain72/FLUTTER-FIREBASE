import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class signUp extends StatefulWidget {
  final VoidCallback showloginPage;

  const signUp({Key? key, required this.showloginPage}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool passwordObscured = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> uploadProfiePic() async {
    PickedFile? _image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  }

  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Text(e.message.toString()),
            );
          });
    }
    //add user details
    addUserDetails(
      firstNameController.text.trim(),
      lastNameController.text.trim(),
      int.parse(
        ageController.text.trim(),
      ),
      emailController.text.trim(),
    );
    Navigator.of(context).pop();
    // }
  }

  Future addUserDetails(
    String firstName,
    String lastName,
    int age,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("users").add({
      'first name': firstName,
      'last name': lastName,
      'age': age,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: null,
                      ),
                      Positioned(
                          bottom: 20,
                          right: 20,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => MyBottonSheet()),
                              );
                            },
                            child: Icon(
                              Icons.image,
                              size: 22,
                              color: Colors.teal,
                            ),
                          ))
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Please enter this field"),
                      ]),
                      controller: firstNameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            size: 20,
                          ),
                          hintText: "First name"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Please enter this field"),
                      ]),
                      controller: lastNameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            size: 20,
                          ),
                          hintText: "Last name"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(errorText: "please enter your age"),
                        MinLengthValidator(1,
                            errorText: 'password must be at least 1 digit'),
                        PatternValidator(r'(?=.*?[1234567890])',
                            errorText: 'enter your age in digit')
                      ]),
                      controller: ageController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            size: 20,
                          ),
                          hintText: "Age"),
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
                          hintText: "Email"),
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
                            errorText:
                                'password must be at least 8 digits long'),
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
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      "By signing up, you\'re agree to our  terms \& Conditions and Privacy policy",
                      style: GoogleFonts.poppins(
                          textStyle:
                              TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: Container(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    child: ElevatedButton(
                      onPressed: signUp,
                      child: Text(
                        "Sign up",
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Row(children: [
                          Text("Joined us before?"),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: widget.showloginPage,
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ),
                          )
                        ]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget MyBottonSheet() {
  return Container(
    height: 100.0,
    // width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        Text(
          "choose profile photo",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.camera),
                label: Text("camera")),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image),
                label: Text("gallery"))
          ],
        )
      ],
    ),
  );
}
