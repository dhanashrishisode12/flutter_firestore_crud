import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();

  var name = " ";
  var email = " ";
  var password = " ";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  CollectionReference student1 =
      FirebaseFirestore.instance.collection('student');

  Future<void> addUser() {
    return student1
        .add({'name': name, 'email': email, 'password': password})
        .then((value) => print("New User Add"))
        .catchError((error) => print("Failed to add User $error"));
    // print("User Added");
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: const Text(
          "Add  New Students",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          margin: const EdgeInsets.all(16.0),
          elevation: 0.0,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: "Name : ",
                    hintText: "Enter name",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Name";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: "Email : ",
                    hintText: "Enter Email",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Email";
                    } else if (!value.contains("@")) {
                      return "Plese Enter Valid Email";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password : ",
                    hintText: "Enter Password",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Password";
                    } else if (value.length <= 6) {
                      return "Please Enter Password 6 Digits";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blueAccent)),
                      onPressed: () => {
                        //Validates returns true if the form is valid , otherwise false
                        if (_formKey.currentState!.validate())
                          {
                            setState(() {
                              name = nameController.text;
                              email = emailController.text;
                              password = passwordController.text;
                              addUser();
                              clearText();
                            }),
                          },
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightBlue),
                      ),
                      onPressed: () => {clearText()},
                      child: const Text(
                        "Reset",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
