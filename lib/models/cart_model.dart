class CartItem {
  final String id;
  final String batchId;
  final String farmId;
  final String farmName;
  final String eggType;
  final double pricePerUnit;
  int quantity;
  final String? batchImage;
  final double freshnessScore;

  CartItem({
    required this.id,
    required this.batchId,
    required this.farmId,
    required this.farmName,
    required this.eggType,
    required this.pricePerUnit,
    required this.quantity,
    this.batchImage,
    required this.freshnessScore,
  });

  double get totalPrice => pricePerUnit * quantity;

  Map<String, dynamic> toJson() => {
    'id': id,
    'batchId': batchId,
    'farmId': farmId,
    'farmName': farmName,
    'eggType': eggType,
    'pricePerUnit': pricePerUnit,
    'quantity': quantity,
    'batchImage': batchImage,
    'freshnessScore': freshnessScore,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    batchId: json['batchId'],
    farmId: json['farmId'],
    farmName: json['farmName'],
    eggType: json['eggType'],
    pricePerUnit: (json['pricePerUnit'] ?? 0.0).toDouble(),
    quantity: json['quantity'],
    batchImage: json['batchImage'],
    freshnessScore: (json['freshnessScore'] ?? 0.0).toDouble(),
  );
}
