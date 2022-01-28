import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/fonts_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! AppLoadingGetCartState,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => buildListProduct(
                        AppCubit.get(context)
                            .cartModel!
                            .data!
                            .cartItems![index]
                            .product,
                        context),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: AppCubit.get(context)
                        .cartModel!
                        .data!
                        .cartItems!
                        .length,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.swatch),
                            borderRadius: BorderRadius.circular(AppSize.s16)),
                        height: 50,
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.white),
                          onPressed: () {},
                          child: Text(
                            "Clear  Cart".toUpperCase(),
                            style: TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.swatch,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppSize.s8,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: ColorManager.swatch),
                          onPressed: () {},
                          child: Text(
                            "Buy  Now".toUpperCase(),
                            style: const TextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildListProduct(
    model,
    context, {
    bool isOldPrice = true,
  }) =>
      Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SizedBox(
            height: 120.0,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s16),
                    border: Border.all(
                      color: Colors.orange,
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage(model.image),
                        width: 120,
                        height: 100.0,
                        // fit: BoxFit.cover,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Container(
                          margin: EdgeInsets.all(4),
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
                                    color: Colors.white, fontSize: AppSize.s8),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: AppSize.s20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 32,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
                              onPressed: () {},
                              child: Icon(
                                IconBroken.Plus,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p16),
                            child: Text(
                              '1',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: ColorManager.swatch),
                            ),
                          ),
                          SizedBox(
                            width: 32,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white),
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
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            model.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: ColorManager.swatch),
                          ),
                          const SizedBox(
                            width: AppSize.s4,
                          ),
                          if (model.discount != 0 && isOldPrice)
                            Text(
                              model.oldPrice.toString(),
                              style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
