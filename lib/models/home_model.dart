class ProductModel {
  int? id;
  dynamic price;

  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;
  ProductModel(
      {this.id,
      this.price,
      this.name,
      this.image,
      this.inFavorites,
      this.inCart});
}
