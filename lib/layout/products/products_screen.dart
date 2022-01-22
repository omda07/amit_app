import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);
  List<ProductModel> products = [
    ProductModel(
        id: 1,
        price: 200,
        name: 'Man white T shirt',
        image:
            'https://www.target.com.au/medias/static_content/product/images/full/62/32/A1766232.jpg?impolicy=product_portrait_hero'),
    ProductModel(
        id: 2,
        price: 160.63,
        name: 'Mobile Phone Holder',
        image:
            'https://student.valuxapps.com/storage/uploads/products/1638738160hkG50.1.jpg'),
    ProductModel(
        id: 3,
        price: 400,
        name: 'Xiaomi Mi Motion Activated Night Light 2 - White',
        image:
            'https://student.valuxapps.com/storage/uploads/products/1638738391RrZ5V.21.jpg'),
    ProductModel(
        id: 4,
        price: 1083,
        name: 'Stark Iron Kettlebell, 24 KG',
        image:
            'https://student.valuxapps.com/storage/uploads/products/161545152160GOl.item_XXL_39275650_152762070.jpeg'),
    ProductModel(
        id: 4,
        price: 1606.5,
        name: 'Nike Flex Essential Mesh Training Shoes For Women - White',
        image:
            'https://student.valuxapps.com/storage/uploads/products/1638737146iLO2c.11.jpg'),
    ProductModel(
        id: 4,
        price: 1085,
        name: 'Nike Men',
        image:
            'https://student.valuxapps.com/storage/uploads/products/1638737571de5EF.21.jpg'),
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
                childAspectRatio: 1 / 1.75,
                crossAxisCount: 2,
                children: List.generate(
                  products.length,
                  (index) => buildGridProduct(products[index], context),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        //
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
              ),
              child: Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                height: 200,
                // fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3),
                  ),
                  Text(
                    '${model.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, height: 1.3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          print(model.id);
                        },
                        icon: Icon(
                          IconBroken.Plus

                          //size: 14.0,
                          ,
                          color: Colors.red,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${model.price} EGP',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
