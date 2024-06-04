import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:projek/main.dart';
import 'package:projek/project/halaman/halaman_favorit.dart';
import 'package:projek/project/query/hive_user.dart';
import 'package:projek/project/model/hive_model.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isExist = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final HiveUser _hive = HiveUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Akun",
          style: TextStyle(
              fontFamily: 'Caveat',
              fontWeight: FontWeight.bold,
              fontSize: 24.0),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Username',
                ),
                validator: (value) => value!.isEmpty ? 'Username tidak boleh kosong':null,
              ),
              SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: 'Password',
                ),
                validator: (value) => value!.isEmpty ? 'Password tidak boleh kosong':null,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: (){
                    isExist = _hive.checkUsers(_usernameController.text);
                    if (isExist == false && _usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                      _hive.addData(
                          UserAccountModel(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              foto: ''
                          )
                      );
                      _usernameController.clear();
                      _passwordController.clear();
                      setState(() {});

                      Navigator.pop(context);
                    }
                    else{
                      const snackBar = SnackBar(
                        content: Text('Akun sudah ada'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Register',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        backgroundColor: Colors.orange.shade300,
        items: <Widget>[
          Icon(Icons.home, size: 25),
          Icon(Icons.favorite, size: 25),
          Icon(Icons.account_circle, size: 25),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
                break;

              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Favorit(username: "")),
                );
                break;

              case 2:
                Navigator.pop(context);
                break;
            }
          });
        },
      ),
    );
  }
}

