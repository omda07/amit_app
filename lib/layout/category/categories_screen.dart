import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.start,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              children: [
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 2,
                  children: List.generate(
                    AppCubit.get(context).categoriesModel!.data!.data.length,
                    (index) => buildCategoryItem(
                        AppCubit.get(context)
                            .categoriesModel!
                            .data!
                            .data[index],
                        context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoryItem(model, BuildContext context) => Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s12),
              border: Border.all(color: ColorManager.swatch),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: Image(
                image: NetworkImage('${model.image}'),
                height: 200.0,
                width: double.infinity,
              ),
            ),
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
      );
}
