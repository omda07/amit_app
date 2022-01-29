import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

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
        return Scaffold(
          body: ConditionalBuilder(
            condition: AppCubit.get(context).changeFavoritesModel != null,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  AppCubit.get(context)
                      .favoritesModel!
                      .data!
                      .data![index]
                      .product,
                  context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount:
                  AppCubit.get(context).favoritesModel!.data!.data!.length,
              physics: const BouncingScrollPhysics(),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
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
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          border: Border.all(color: ColorManager.swatch)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        child: Image(
                          image: NetworkImage(model.image),
                          width: 120.0,
                          height: 120.0,
                        ),
                      ),
                    ),
                    if (model.discount != 0 && isOldPrice)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s8),
                          color: ColorManager.swatch,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        margin: EdgeInsetsDirectional.only(
                            bottom: AppMargin.m4, start: AppMargin.m8),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: AppSize.s10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
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
                          fontSize: AppSize.s14,
                          height: 1.3,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            model.price.toString(),
                            style: TextStyle(
                              fontSize: AppSize.s12,
                              color: ColorManager.swatch,
                            ),
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
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).changeFavorites(model.id);
                            },
                            icon: Icon(
                              AppCubit.get(context).favorites[model.id]!
                                  ? Icons.favorite_rounded
                                  : IconBroken.Heart,
                              size: AppSize.s28,
                              // color: Colors.purple,
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
