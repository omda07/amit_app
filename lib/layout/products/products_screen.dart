import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/layout/product/product_details_screen.dart';
import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        return ConditionalBuilder(
          condition: AppCubit.get(context).homeModel != null,
          builder: (context) =>
              productsBuilder(AppCubit.get(context).homeModel!, context, size),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, context, Size size) =>
      SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppPadding.p20),
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.data!.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppPadding.p20,
                    crossAxisSpacing: AppPadding.p20,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) => itemBuildGridProduct(
                      product: model.data!.products[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                                productModel: model.data!.products[index]),
                          )),
                      context: context)),
            ),
          ],
        ),
      );

  Widget itemBuildGridProduct(
      {required ProductModel product,
      required BuildContext context,
      required Function press}) {
    return GestureDetector(
      onTap: () {
        press();
        print(product.id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.orange,
                ),
              ),
              child: Hero(
                tag: "${product.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    image: NetworkImage('${product.image}'),
                    width: double.infinity,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
            child: Text(
              '${product.name}',
              style: Theme.of(context).textTheme.subtitle1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${product.price} EGP ",
            style: TextStyle(color: ColorManager.swatch),
          )
        ],
      ),
    );
  }

  // Widget buildGridProduct(ProductModel model, context) => Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       //
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           ClipRRect(
  //             borderRadius: const BorderRadius.only(
  //               topRight: Radius.circular(12.0),
  //               topLeft: Radius.circular(12.0),
  //             ),
  //             child: Image(
  //               image: NetworkImage('${model.image}'),
  //               width: double.infinity,
  //               height: 200,
  //               // fit: BoxFit.cover,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(6.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '${model.name}',
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(height: 1.3),
  //                 ),
  //                 Text(
  //                   '${model.name}',
  //                   maxLines: 1,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(color: Colors.grey, height: 1.3),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     IconButton(
  //                       onPressed: () {
  //                         print(model.id);
  //                       },
  //                       icon: const Icon(
  //                         IconBroken.Plus
  //
  //                         //size: 14.0,
  //                         ,
  //                         color: Colors.red,
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     Text(
  //                       '${model.price} EGP',
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: const TextStyle(color: Colors.red),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
}
