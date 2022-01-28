import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      listener: (context, state) {},
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
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s24),
                  topRight: Radius.circular(AppSize.s24),
                ),
              ),
              child: Column(
                children: <Widget>[
                  description(product: product),
                  const SizedBox(height: AppPadding.p8),
                  // CounterWithFavBtn(),

                  counter(context),
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
  Widget counter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: () {},
              child: Icon(
                IconBroken.Plus,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Text(
              '1',
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
              onPressed: () {},
              child: Icon(
                IconBroken.Paper_Negative,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            iconSize: AppSize.s28,
            onPressed: () {},
            icon: const Icon(
              IconBroken.Heart,
              color: Colors.white,
            ),
          )
        ],
      ),
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
              child: CircularProgressIndicator(),
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
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
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
