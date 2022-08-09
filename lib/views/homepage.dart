import 'package:cocktail_app/controllers/cocktail_controller.dart';
import 'package:cocktail_app/models/cocktail_model.dart';
import 'package:cocktail_app/views/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cocktail App'),
          backgroundColor: Colors.orangeAccent,
          elevation: 1,
        ),
        body: GetBuilder<CocktailController>(
          init: CocktailController(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<CocktailModel>>(
                  future: controller.getCocktails(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orangeAccent,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: controller.cocktails.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final cocktail = snapshot.data![index].drinks[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                        title: cocktail.strDrink,
                                        image: cocktail.strDrinkThumb),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                color: Colors.orangeAccent,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      child: Image.network(
                                        cocktail.strDrinkThumb,
                                        height: 110,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Id : ${cocktail.idDrink}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          cocktail.strDrink,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white54),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
