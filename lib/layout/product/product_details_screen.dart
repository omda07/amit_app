import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  ProductDetailsScreen({
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
          //backgroundColor: ColorManager.swatch,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(IconBroken.Arrow___Left),
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(IconBroken.Search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(IconBroken.Buy),
                onPressed: () {},
              ),
              const SizedBox(width: AppSize.s12)
            ],
          ),
          body: productDetails(
              product: productModel, context: context, size: size),
        );
      },
    );
  }

  Widget productDetails(
          {required ProductModel product,
          required BuildContext context,
          required Size size}) =>
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
              // height: 500,
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
                  const SizedBox(height: AppPadding.p8),
                  counter(context),
                  Spacer(),
                  addToCart(context),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                ],
              ),
            ),
            imageWithTitle(product: product, context: context),
          ],
        ),
      );
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

  Widget counter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 40,
            height: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: ColorManager.white),
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
              '0',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: ColorManager.white),
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
                      text: "${product.price} EGP",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      color: ColorManager.white,
                      height: 180,
                      width: 250,
                      child: Image(
                        image: NetworkImage('${product.image}'),
                        // fit: BoxFit.cover,
                        width: 250,
                        height: 180,
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

  Widget addToCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
      child: Row(
        children: <Widget>[
          Container(
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
              onPressed: () {},
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
