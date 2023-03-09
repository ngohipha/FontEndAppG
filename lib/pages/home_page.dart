import 'package:flutter/material.dart';

import 'package:fontend/models/product.dart';
import 'package:fontend/widgets/product_card.dart';
import 'package:fontend/widgets/widget_home_categories.dart';
import 'package:fontend/widgets/widget_home_products.dart';
import 'package:fontend/widgets/widget_home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          child: ListView(
            children: const  [
              HomeSliderWidget(),
               HomeCategoriesWidget(),
               HomeProductsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
