import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/layout/product/product_details_screen.dart';
import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/shared/component.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessChangeFavoritesState) {
          if (state.model.status!) {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                backgroundColor: ColorManager.swatch,
                message: '${state.model.message}',
              ),
            );
          } else {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: '${state.model.message}',
              ),
            );
          }
        }
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: ConditionalBuilder(
            condition: AppCubit.get(context).homeModel != null,
            builder: (context) => productsBuilder(
                AppCubit.get(context).homeModel!, context, size),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
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
            Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                items: model.data!.products
                    .map(
                      (e) => Container(
                        width: double.infinity,
                        height: AppSize.s100 * 1.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s16),
                            border: Border.all(color: ColorManager.swatch),
                            color: Colors.white),
                        child: Image(
                          image: NetworkImage('${e.image}'),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
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
                    press: () => navigateTo(
                          context,
                          ProductDetailsScreen(
                              productModel: model.data!.products[index]),
                        ),
                    context: context),
              ),
            ),
          ],
        ),
      );

  Widget itemBuildGridProduct(
      {required ProductModel product,
      required BuildContext context,
      required Function press}) {
    return GestureDetector(
      //go to product screen details
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
                  color: ColorManager.swatch,
                ),
              ),
              //animate the image
              child: Hero(
                tag: "${product.id}",
                //border
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage('${product.image}'),
                        width: double.infinity,
                      ),
                      // condition lo feh discount y show it
                      if (product.discount != 0)
                        Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: ColorManager.swatch,
                          ),
                          child: Text(
                            'DISCOUNT',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.white, fontSize: 10),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text(
            '${product.name}',
            style: Theme.of(context).textTheme.subtitle1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (product.discount != 0)
            Text(
              product.oldPrice.toString(),
              style: const TextStyle(
                fontSize: AppSize.s12,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          Row(
            children: [
              Text(
                "${product.price} EGP ",
                style: TextStyle(color: ColorManager.swatch),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeFavorites(product.id!);
                  print(product.id);
                },
                icon: Icon(
                  AppCubit.get(context).favorites[product.id]!
                      ? Icons.favorite_rounded
                      : IconBroken.Heart,
                  //size: 14.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
