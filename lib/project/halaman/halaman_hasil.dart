import 'package:flutter/material.dart';
import 'package:projek/main.dart';
import 'package:projek/project/api_data_source.dart';
import 'package:projek/project/halaman/halaman_favorit.dart';
import 'package:projek/project/model/model_resep.dart';
import 'halaman_akun.dart';
import 'package:flutter/foundation.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'halaman_detail_resep.dart';
import 'halaman_favorit.dart';
import '../model/shared_preferences.dart';

class HasilPencarian extends StatefulWidget {
  final String value;
  final int index;
  HasilPencarian({Key? key, required this.value, required this.index}) : super(key: key);

  @override
  State<HasilPencarian> createState() => _HasilPencarianState();
}

class _HasilPencarianState extends State<HasilPencarian> {
  late int index = widget.index;
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        //backgroundColor: Colors.orange[300],
        title: Text("Hasil Pencarian ${widget.value}"),
      ),
      body: _buildListHasil(),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.orange.shade300,
        items: <Widget>[
          Icon(Icons.home, size: 25),
          Icon(Icons.favorite, size: 25),
          Icon(Icons.account_circle, size: 25),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            _page = index;

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Akun()),
                );
                break;
            }
          });
        },
      ),
    );
  }

  Widget _buildListHasil(){
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadBySearch(search: widget.value.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (snapshot.hasError) {
             return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MealList mealList = MealList.fromJson(snapshot.data);
             return _buildSuccessSection(mealList);
          }
          return _buildLoadingSection();
          }),

    );
  }

  Widget _buildErrorSection() {
    return Center(
        child: Text("Error",
            textAlign: TextAlign.center, style: TextStyle(fontSize: 30.0)));
  }

  Widget _buildSuccessSection(MealList data) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: data.meals != null
                ? ListView.builder(
                itemCount: data.meals?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () async {
                        String username = await SharedPreference.getUsername();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return HalamanDetail(
                                  username: username,
                                  data: data,
                                  index: index);
                            }));
                      },
                    child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    clipBehavior: Clip.antiAlias,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: _buildItemList(data, index)),
                    )
                  );
                })
                : Center(
                child: Center(
                    child: Text("Resep Tidak Ada",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30.0)))),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItemList(MealList data, int index) {
    String imageUrl = "${data.meals![index].strMealThumb}";
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${data.meals![index].strMeal}",
                        style: const TextStyle(fontSize: 28.0)),
                    Text("${data.meals![index].strArea}")
                  ],
                ),
                
              )),
          // Expanded(child: Text(value2.toTitleCase(), style: const TextStyle(fontSize: 26.0))),
        ],
      ),
    );
    return text;
  }

  }
