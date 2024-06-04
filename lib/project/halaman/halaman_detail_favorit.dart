import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projek/project/query/hive_favorit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:projek/project/model/hive_model.dart';
import 'package:projek/project/model/detail_resep.dart';
import 'package:projek/project/api_data_source.dart';
import '../../main.dart';
import 'halaman_hasil.dart';
import 'halaman_favorit.dart';
import 'halaman_akun.dart';

class HalamanDetailFavorit extends StatefulWidget {
  final String username;
  final List<dynamic> list;
  final int index;
  const HalamanDetailFavorit({Key? key, required this.list, required this.index, required this.username})
      : super(key: key);

  @override
  State<HalamanDetailFavorit> createState() => _HalamanDetailFavoritState();
}

class _HalamanDetailFavoritState extends State<HalamanDetailFavorit> {
  final HiveDatabaseFav _hiveFav = HiveDatabaseFav();
  bool isFavorite = true;
  late int index = widget.index;

  @override
  void initState() {
    isFavorite = _hiveFav.checkFavorite(
        "${widget.list[index].username}", "${widget.list[index].idMeal}");
    debugPrint("$isFavorite");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details of ${widget.list[index].nameMeal}",
          style: TextStyle(
              fontFamily: 'Caveat',
              fontWeight: FontWeight.bold,
              fontSize: 24.0),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (isFavorite == false) {
                _hiveFav.addData(
                  MyFavorite(
                    username: widget.list[index].username,
                    nameMeal: widget.list[index].strMeal,
                    idMeal: widget.list[index].idMeal,
                    imageMeal: widget.list[index].strMealThumb,
                  ),
                );
                setState(() {
                  isFavorite = true;
                });
                debugPrint('false');
              } else if (isFavorite == true) {
                _hiveFav.deleteData(
                  widget.list[index].username,
                  widget.list[index].idMeal,
                );
                setState(() {
                  isFavorite = false;
                });
                debugPrint('true');
              }
            },
            iconSize: 30,
            icon: (isFavorite == true)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: _buildDetailMeal(),

      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favorit(username: widget.username)),
                );
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

  Widget _buildDetailMeal() {
    return FutureBuilder(
        future: ApiDataSource.instance
            .loadDetail(idMeal: "${widget.list[index].idMeal}"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            MealDetail mealdetail = MealDetail.fromJson(snapshot.data);
            return _buildSuccessSection(mealdetail);
          }
          return _buildLoadingSection();
        });
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorSection() {
    return const Text("Error2");
  }

  Widget _buildSuccessSection(MealDetail data) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildHeader(data),
            _buildDescription(data),
            _buildIngredient(data),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(MealDetail data) {
    return Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1.0, color: Colors.amber),
          borderRadius: BorderRadius.circular(25),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  "${data.meals![0].strMealThumb}",
                  fit: BoxFit.fill,
                  width: 120.0,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 200.0,
              height: 140.0,
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.meals![0].strMeal}".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      "Meal ID. ${data.meals![0].idMeal}",
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Koulen'),
                    ),
                    Text(
                      "Meal Category: ${data.meals![0].strCategory}",
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Koulen'),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  Widget _buildDescription(MealDetail data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 9),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "INSTRUCTIONS",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Text(
                "${data.meals![0].strInstructions}",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredient(MealDetail data) {
    List<String> value = [
      "${data.meals![0].strIngredient1}",
      "${data.meals![0].strIngredient2}",
      "${data.meals![0].strIngredient3}",
      "${data.meals![0].strIngredient4}",
      "${data.meals![0].strIngredient5}",
      "${data.meals![0].strIngredient6}",
      "${data.meals![0].strIngredient7}",
      "${data.meals![0].strIngredient8}",
      "${data.meals![0].strIngredient9}",
      "${data.meals![0].strIngredient10}",
      "${data.meals![0].strIngredient11}",
      "${data.meals![0].strIngredient12}",
      "${data.meals![0].strIngredient13}",
      "${data.meals![0].strIngredient14}",
      "${data.meals![0].strIngredient15}",
    ];
    List<String> valueMeasure = [
      "${data.meals![0].strMeasure1}",
      "${data.meals![0].strMeasure2}",
      "${data.meals![0].strMeasure3}",
      "${data.meals![0].strMeasure4}",
      "${data.meals![0].strMeasure5}",
      "${data.meals![0].strMeasure6}",
      "${data.meals![0].strMeasure7}",
      "${data.meals![0].strMeasure8}",
      "${data.meals![0].strMeasure9}",
      "${data.meals![0].strMeasure10}",
      "${data.meals![0].strMeasure11}",
      "${data.meals![0].strMeasure12}",
      "${data.meals![0].strMeasure13}",
      "${data.meals![0].strMeasure14}",
      "${data.meals![0].strMeasure15}",
    ];
    value.removeWhere((value) => value == "");
    value.removeWhere((value) => value == "null");
    valueMeasure.removeWhere((value) => value == "");
    valueMeasure.removeWhere((value) => value == "null");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              const Text(
                "MAIN INGREDIENTS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (context, i) {
                  return Card(
                      color: Colors.amber.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return HasilPencarian(value: value[i], index: 2);
                          }));
                        },
                        splashColor: Colors.amber.shade200,
                        highlightColor: Colors.amber.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(
                                "https://www.themealdb.com/images/ingredients/${value[i]}-Small.png",
                                width: 100.0,
                              ),
                              Text(
                                value[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                valueMeasure[i],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                itemCount: value.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// var data =
// (await GithubDataSource.instance.loadUsersData(_search));
