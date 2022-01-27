import 'package:amit_app/layout/home/amit_cubit.dart';
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

  Widget buildCategoryItem(model, BuildContext context) => ClipRRect(
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
