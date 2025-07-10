import 'package:ekart/features/home/data/models/product_item.dart';

class Offer{
  final String offerPercentage;
  final String offerMassage;
  final ProductItem item;

  Offer({required this.offerPercentage, required this.offerMassage, required this.item});
}