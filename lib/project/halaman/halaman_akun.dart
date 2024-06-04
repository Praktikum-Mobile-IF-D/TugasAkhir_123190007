import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:projek/main.dart';
import 'package:projek/project/halaman/halaman_favorit.dart';
import 'package:projek/project/halaman/login.dart';
import 'package:projek/project/halaman/register.dart';

class Akun extends StatefulWidget {
  String user;
  Akun({Key? key, this.user="Tamu"}) : super(key: key);

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
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
        body: (widget.user=="Tamu") ? _buildTamu() : _buildProfil(),

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
                    MaterialPageRoute(builder: (context) => MyApp(username: widget.user)),
                  );
                  break;

                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favorit(username: widget.user)),
                  );
                  break;

                case 2:
                  break;
              }
            });
          },
        ),
    );
  }

  //===============================================================================

  Widget _buildTamu(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              )
            },
            child: Text("Login",
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 15),
          Text("atau"),
          SizedBox(height: 15),
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Register()),
              )
          },
            child: Text("Register",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfil(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
            height: 100,
          ),
          SizedBox(height: 15),
          Text(widget.user,
            style: TextStyle(
                fontFamily: 'Caveat',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(height: 30),
          TextButton(
            onPressed: () => {
              setState(() async {
                SharedPreferences userData = await SharedPreferences.getInstance();
                userData.clear();
                widget.user = "Tamu";
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Akun(user: widget.user)
                  ));
              })
            },
            child: Text("Logout",
              style: TextStyle(fontSize: 18),
            ),
          ),

        ],
      ),
    );
  }
}



