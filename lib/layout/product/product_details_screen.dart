import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessChangeCartsState) {
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
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left,
                color: ColorManager.swatch,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  IconBroken.Search,
                  color: ColorManager.swatch,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  IconBroken.Buy,
                  color: ColorManager.swatch,
                ),
                onPressed: () {},
              ),
              const SizedBox(width: AppSize.s12)
            ],
          ),
          body: productDetails(
              product: productModel,
              context: context,
              size: size,
              state: state),
        );
      },
    );
  }

//image and title widget
  Widget imageWithTitle(
      {required ProductModel product, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Amit Shop",
          ),
          Text(
            '${product.name}',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSize.s20),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Price\n",
                        style: Theme.of(context).textTheme.subtitle1),
                    TextSpan(
                      text: "${product.price} EGP\n",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    if (product.discount != 0)
                      TextSpan(
                        text: product.oldPrice.toString(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 14.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSize.s20),
              Expanded(
                child: Hero(
                  tag: "${product.id}",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      height: 180,
                      width: 250,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image(
                            image: NetworkImage('${product.image}'),
                            // fit: BoxFit.cover,
                            width: 250,
                            height: 180,
                          ),
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
                                    .copyWith(
                                        color: Colors.white, fontSize: 10),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget productDetails(
          {required ProductModel product,
          required BuildContext context,
          required Size size,
          required AppStates state}) =>
      SizedBox(
        height: size.height,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: size.height * 0.3),
              padding: EdgeInsets.only(
                top: size.height * 0.10,
                left: AppPadding.p20,
                right: AppPadding.p20,
              ),
              decoration: BoxDecoration(
                color: ColorManager.swatch,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s24),
                  topRight: Radius.circular(AppSize.s24),
                ),
              ),
              child: Column(
                children: <Widget>[
                  description(product: product),
                  const SizedBox(height: AppPadding.p8),
                  // CounterWithFavBtn(),

                  counter(context: context, product: productModel),
                  const Spacer(),
                  // add to cart widget
                  addToCart(product: product, context: context, state: state),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                ],
              ),
            ),
            //image and title widget
            imageWithTitle(product: product, context: context),
          ],
        ),
      );
  //description widget
  Widget description({required ProductModel product}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      child: Text(
        '${product.description}',
        maxLines: 6,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(height: AppSize.s1_5, color: Colors.white),
      ),
    );
  }

// quantity widget
  Widget counter({
    required BuildContext context,
    required ProductModel product,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () {
                AppCubit.get(context).changeQuantityInc();
              },
              child: Icon(
                IconBroken.Plus,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Text(
              '${AppCubit.get(context).quantity}',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 40,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () {
                AppCubit.get(context).changeQuantityDec();
              },
              child: Icon(
                IconBroken.Paper_Negative,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              AppCubit.get(context).changeFavorites(product.id!);
              print(product.id);
            },
            icon: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  color: Colors.white),
              child: Icon(
                AppCubit.get(context).favorites[product.id]!
                    ? Icons.favorite_rounded
                    : IconBroken.Heart,
                size: AppSize.s16 * 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

// add to cart widget
  Widget addToCart(
      {required ProductModel product,
      required BuildContext context,
      required AppStates state}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
      child: Row(
        children: <Widget>[
          ConditionalBuilder(
            condition: state is! AppLoadingChangeCartsState,
            builder: (context) => Container(
              margin: const EdgeInsets.only(right: AppPadding.p20),
              height: 50,
              width: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  IconBroken.Buy,
                ),
                onPressed: () {
                  AppCubit.get(context).changeCarts(product.id!);

                  print(product.id);
                },
              ),
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {},
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.swatch,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
