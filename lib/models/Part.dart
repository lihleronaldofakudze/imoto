class Part {
  final String id;
  final String uid;
  final String brand;
  final String part;
  final double price;
  final String condition;
  final List images;

  Part(
      {required this.id,
      required this.uid,
      required this.brand,
      required this.part,
      required this.price,
      required this.condition,
      required this.images});
}
