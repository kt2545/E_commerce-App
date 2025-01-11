import 'package:e_commerce_app/features/admin/models/sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductsChart({
    super.key,
    required this.seriesList,
  });

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
