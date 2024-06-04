import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:projek/main.dart';
import 'package:projek/project/query/hive_favorit.dart';
import 'package:projek/project/halaman/halaman_akun.dart';
import 'halaman_detail_favorit.dart';


class Favorit extends StatefulWidget {
  final String username;
  const Favorit({Key? key, required this.username}) : super(key: key);

  @override
  State<Favorit> createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  final HiveDatabaseFav _hiveFav = HiveDatabaseFav();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Resep Favorit",
          style: TextStyle(
              fontFamily: 'Caveat',
              fontWeight: FontWeight.bold,
              fontSize: 24.0),
        ),
      ),
      body: _buildList(),

      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
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
                  MaterialPageRoute(builder: (context) => MyApp(username: widget.username)),
                );
                break;

              case 1:
                break;

              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Akun(user: widget.username)),
                );
                break;
            }
          });
        },
      ),
    );
  }

  Widget _buildList() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ValueListenableBuilder(
        valueListenable: _hiveFav.listenable(),
        builder: (BuildContext context, Box<dynamic> value, Widget? child) {
          return _buildSuccessSection(_hiveFav);
        },
      ),
    );
  }

  Widget _buildSuccessSection(HiveDatabaseFav _hiveFav) {
    int jml = _hiveFav.getLength(widget.username);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
              child: jml == 0
                  ? Center(child: Text("Data Kosong"))
                  : ListView.builder(
                  itemCount: _hiveFav.getLength(widget.username),
                  itemBuilder: (BuildContext context, int index) {
                    List filteredUsers = _hiveFav
                        .values()
                        .where((_localDB) => _localDB.username == widget.username)
                        .toList();
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return HalamanDetailFavorit(
                                          username: widget.username,
                                          list: filteredUsers,
                                          index: index
                                      );
                                    }));
                              },
                              child: _buildItemList(filteredUsers, index))),
                    );
                  })),
        ],
      ),
    );
  }

  Widget _buildItemList(List filteredUsers, int index) {
    String imageUrl = filteredUsers[index].imageMeal;
    var text = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    imageUrl,
                    width: 130.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(filteredUsers[index].nameMeal,
                    style: const TextStyle(fontSize: 28.0)),
              )),
        ],
      ),
    );
    return text;
  }
}
