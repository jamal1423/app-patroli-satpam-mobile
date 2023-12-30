// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:app_patroli_satpam/pages/page_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart' as locationv2;

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var txtEditEmployeeID = TextEditingController();
  var txtEditPwd = TextEditingController();

  locationv2.Location lokasi = locationv2.Location();

  // request permission
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    locationv2.PermissionStatus permissionGranted;
    serviceEnabled = await lokasi.serviceEnabled();

    //ceck service
    if (!serviceEnabled) {
      serviceEnabled = await lokasi.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    //ceck permission
    permissionGranted = await lokasi.hasPermission();
    if (permissionGranted == locationv2.PermissionStatus.denied) {
      permissionGranted = await lokasi.requestPermission();
      if (permissionGranted != locationv2.PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Widget inputEmployeeID() {
    return TextFormField(
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        autofocus: false,
        validator: (String? arg) {
        if (arg == null || arg.isEmpty) {
          return 'EmployeeID harus diisi';
        } else {
          return null;
        }
      },
        controller: txtEditEmployeeID,
        onSaved: (String? val) {
          txtEditEmployeeID.text = val!;
        },
        decoration: InputDecoration(
          hintText: 'Masukkan EmployeeID',
          hintStyle: const TextStyle(color: Colors.white),
          labelText: "Masukkan EmployeeID",
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: const Icon(
            Icons.person_outlined,
            color: Colors.white,
          ),
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.white));
  }

  Widget inputPassword() {
    return TextFormField(
      cursorColor: Colors.white,
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true, //make decript inputan
      validator: (String? arg) {
        if (arg == null || arg.isEmpty) {
          return 'Password harus diisi';
        } else {
          return null;
        }
      },
      controller: txtEditPwd,
      onSaved: (String? val) {
        txtEditPwd.text = val!;
      },
      decoration: InputDecoration(
        hintText: 'Masukkan Password',
        hintStyle: const TextStyle(color: Colors.white),
        labelText: "Masukkan Password",
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Colors.white,
        ),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
      style: const TextStyle(fontSize: 16.0, color: Colors.white),
    );
  }

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
      //If all data are correct then save data to out variables
      _formKey.currentState!.save();
      doLogin(txtEditEmployeeID.text, txtEditPwd.text);
    }
  }

  doLogin(employeeID, password) async {
    //final GlobalKey<State> _keyLoader = GlobalKey<State>();
    //Dialogs.loading(context, _keyLoader, "Proses ...");
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );

    try {
      final response = await http.post(
          Uri.parse("https://patroli-satpam.startdev.my.id/api/v1/proses-login"),
          body: {
            "employeeID": employeeID,
            "password": password,
          });
          // headers: {
          //   'Content-Type': 'application/json; charset=UTF-8',
          //   'Access-Control-Allow-Origin': '*',
          //   'Accept': '*/*'
          // },
          // body: jsonEncode({
          //   "username": username,
          //   "password": password,
          // }));

      final output = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if(context.mounted){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
              output['message'],
              style: const TextStyle(fontSize: 16),
            )),
          );
        }

        if (output['success'] == true) {
          saveSession(employeeID);
        }
      } else {
        if(context.mounted){
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              output.toString(),
              style: const TextStyle(fontSize: 16),
            )),
          );
        }
      }
    } catch (e) {
      Navigator.pop(context, '$e');
      debugPrint('$e');
    }
  }

  saveSession(String employeeID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("employeeID", employeeID);
    await pref.setBool("is_login", true);

    if(context.mounted){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const PageHome(),
          // builder: (BuildContext context) => const PageHome(),
        ),
        (route) => false,
      );
    }
  }

  void ceckLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var islogin = pref.getBool("is_login");
    if (islogin != null && islogin) {
      if(context.mounted){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const PageHome(),
            // builder: (BuildContext context) => const PageHome(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    ceckLogin();
    super.initState();
    // requestPermission();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 110, 129, 149),
      body: Container(
        margin: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 110, 129, 149), Color.fromARGB(255, 207, 210, 216)],
        )),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 60.0, bottom: 0),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 80,
                    child: Icon(Icons.person_2_outlined, size: 50, color: Colors.white,),
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  "Form Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    inputEmployeeID(),
                    const SizedBox(height: 20.0),
                    inputPassword(),
                    const SizedBox(height: 5.0),
                  ],
                )
              ),
              Container(
                padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 16, 36, 151),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: const BorderSide(color: Colors.white60),
                    ),
                    elevation: 10,
                    minimumSize: const Size(200, 58)
                  ),
                  onPressed: () => _validateInputs(),
                  icon: const Icon(Icons.login_outlined, color: Colors.white,),
                  label: const Text(
                    "Masuk",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
