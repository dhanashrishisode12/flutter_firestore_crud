import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;
  const UpdateStudentPage({super.key, required this.id});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference students =
      FirebaseFirestore.instance.collection('student');

  Future<void> updateUser(id, name, email, password) {
    return students
        .doc(id)
        .update({'name': name, 'email': email, 'password': password})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update User: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: const Text(
          " Update User",
        ),
      ),
      body: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('student')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var name = data!['name'];
              var email = data['email'];
              var password = data['password'];
              return Card(
                // elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: TextFormField(
                          initialValue: name,
                          autofocus: false,
                          onChanged: (value) => name = value,
                          decoration: const InputDecoration(
                            labelText: "Name : ",
                            hintText: "Enter name",
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(),
                          ),
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
                          initialValue: email,
                          onChanged: (value) => email = value,
                          // autofocus: false,
                          decoration: const InputDecoration(
                            labelText: "Email : ",
                            hintText: "Enter Email",
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(),
                          ),
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
                          initialValue: password,
                          onChanged: (value) => password = value,
                          autofocus: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password : ",
                            hintText: "Enter Password",
                            labelStyle: TextStyle(fontSize: 20),
                            border: OutlineInputBorder(),
                          ),
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
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.blueAccent)),
                              onPressed: () => {
                                //Validates returns true if the form is valid , otherwise false
                                if (_formKey.currentState!.validate())
                                  {
                                    updateUser(
                                        widget.id, name, email, password),
                                    Navigator.pop(context),
                                  },
                              },
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.lightBlue),
                              ),
                              onPressed: () => {},
                              child: const Text(
                                "Reset",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
