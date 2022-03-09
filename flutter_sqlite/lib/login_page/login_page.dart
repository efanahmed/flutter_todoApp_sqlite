import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite/database/home_page.dart';
import 'package:flutter_sqlite/login_page/create_new_account.dart';
import 'package:flutter_sqlite/login_page/forget_password.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isVisible = false;
  late String _email;
  TextEditingController passwordCntrlr = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
            ),
            children: <Widget>[
              const SizedBox(
                height: 70,
              ),
              Image.asset(
                'assets/user.png',
                height: 100,
                width: 100,
              ),
              const Center(
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Center(
                child: Text(
                  'Sign to continue',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
              ),
              const SizedBox(
                height: 90.0,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Email *",
                  prefixIcon: const Icon(
                    Icons.mail,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.blue,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Plase enter your email";
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                      .hasMatch(value)) {
                    return "Enter correct email";
                  }
                  return null;
                },
                onSaved: (String? email) {
                  _email = email!;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: passwordCntrlr,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                obscureText: !_isVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  hintText: "Password *",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  print(passwordCntrlr.text);

                  if (passwordCntrlr.text != passwordCntrlr.text) {
                    return "Please correct password";
                  }
                  return null;
                },
              ),

              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPassword()));
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Colors.blueAccent,
                  color: Colors.blue,
                  elevation: 5.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        print("successful");
                        return;
                      } else {
                        print(" not successful");
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MyHomePage(title: '')));
                    },
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const MyHomePage(
              //                   title: '',
              //                 )));
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //         horizontal: 20.0, vertical: 15),
              //     child: RaisedButton(
              //       onPressed: () {
              //         validate();
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => MyHomePage(title: "")));
              //       },
              //       child: const Text(
              //         "Login",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18.0,
              //         ),
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(15),
              //         boxShadow: const[
              //           BoxShadow(
              //             blurRadius: 4,
              //             color: Colors.blue,
              //             offset: Offset(2, 2),
              //           ),
              //         ]),
              //     child: Text(
              //       "Login".toUpperCase(),
              //       style: const TextStyle(
              //         fontSize: 16.0,
              //         letterSpacing: 1.7,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Don't have account ?",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Createanewaccount()));
                    },
                    child: const Text(
                      "Create a new account ?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              )
              // const SizedBox(
              //   height: 15,
              // ),
              // const Text(
              //   "Don't have account?     ",
              //   style: TextStyle(
              //     fontSize: 15,
              //     color: Colors.blue,
              //   ),
              //   textAlign: TextAlign.start,
              // ),
              // const SizedBox(
              //   width: 0,
              // ),
              // const Text(
              //   "Create a new account",
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.black,
              //   ),
              //   textAlign: TextAlign.end,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
