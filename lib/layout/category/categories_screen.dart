import 'package:amit_app/models/categories_model.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  List<CategoriesModel> category = [
    CategoriesModel(
        id: 1,
        name: 'Fashion',
        image:
            'https://cdn1.vectorstock.com/i/1000x1000/33/75/vintage-fashion-pattern-background-vector-923375.jpg'),
    CategoriesModel(
        id: 2,
        name: 'Electronics',
        image:
            'https://i.dlpng.com/static/png/1390209-electronics-electronics-png-560_420_preview.png'),
    CategoriesModel(
        id: 3,
        name: 'Baby Products',
        image:
            'https://previews.123rf.com/images/famveldman/famveldman1605/famveldman160500043/56545406-baby-on-white-background-with-clothing-toiletries-toys-and-health-care-accessories-wish-list-or-shop.jpg'),
    CategoriesModel(
        id: 4,
        name: 'Healthy and Beauty',
        image:
            'https://s.tmimgcdn.com/scr/800x500/216900/health-beauty-shop-logo-design_216952-original.jpg'),
    CategoriesModel(
        id: 4,
        name: 'Phones',
        image:
            'https://i2.wp.com/www.campus.sg/wp-content/uploads/2019/02/maxresdefault.jpg?fit=1200%2C675&ssl=1'),
    CategoriesModel(
        id: 4,
        name: 'Supermarket',
        image: 'http://www.bestwaysupermarket.com/images/10.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: productsBuilder(
        context,
      ),
    );
  }

  Widget productsBuilder(context) => SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                //  childAspectRatio: 1 / 1.75,
                crossAxisCount: 2,
                children: List.generate(
                  category.length,
                  (index) => buildCategoryItem(category[index], context),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildCategoryItem(CategoriesModel model, BuildContext context) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(
                .5,
              ),
              width: 100,
              child: Text(
                '${model.name}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
