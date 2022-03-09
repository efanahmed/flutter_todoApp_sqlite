import 'package:flutter/material.dart';
import 'package:flutter_sqlite/databasehelper/dbhelper.dart';
import 'package:flutter_sqlite/login_page/login_page.dart';

class Createanewaccount extends StatefulWidget {
  const Createanewaccount({Key? key}) : super(key: key);

  @override
  _CreateanewaccountState createState() => _CreateanewaccountState();
}

class _CreateanewaccountState extends State<Createanewaccount> {
  bool _isVisible = false;
  bool _isvisible = false;
  @override
  Widget build(BuildContext context) {
    String _name, _email, _phone;

    TextEditingController _password = TextEditingController();
    TextEditingController _confPassword = TextEditingController();

    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
    //  final double height = MediaQuery.of(context).size.height;
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            children: <Widget>[
              const SizedBox(
                height: 120,
              ),
              const Center(
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Create a new account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Name * ",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 10,
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
                    return "Please enter your name";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _name = value!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Email *",
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey, width: 0),
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
                onSaved: (String? value) {
                  _email = value!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Phone *",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  }
                  if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                      .hasMatch(value)) {
                    return "Please enter correct phone number";
                  }
                  return null;
                },
                onSaved: (String? phone) {
                  _phone = phone!;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _password,
                textAlign: TextAlign.start,
                obscureText: !_isVisible,
                keyboardType: TextInputType.text,
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
                    borderSide: const BorderSide(color: Colors.blue, width: 0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _confPassword,
                textAlign: TextAlign.start,
                obscureText: !_isvisible,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isvisible = !_isvisible;
                      });
                    },
                    icon: _isvisible
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  hintText: "Confirm Password *",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey, width: 0),
                  ),
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  print(_password.text);

                  print(_confPassword.text);
                  if (_password.text != _confPassword.text) {
                    return "Password not match";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  shadowColor: Colors.blueAccent,
                  color: Colors.blue,
                  elevation: 5.0,
                  child: FlatButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        print("successful");

                        return;
                      } else {
                        print(" not successfull");
                      }
                    },
                    child: const Center(
                      child: Text(
                        "CREATE   ACCOUNT",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have a account ?",
                      style: TextStyle(
                        fontSize: 12,
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
                                builder: (context) => const Login()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
