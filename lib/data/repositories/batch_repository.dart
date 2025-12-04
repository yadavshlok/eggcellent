// lib/data/repositories/batch_repository.dart
import '../models/batch.dart';
import '../services/api_service.dart';

class BatchRepository {
  final ApiService _api = ApiService();

  Future<Batch> createBatch({
    required int farmId,
    required String name,
    required int quantity,
    required double pricePerUnit,
    required String harvestDate, // ISO string
  }) async {
    final body = {
      'farmId': farmId,
      'name': name,
      'quantity': quantity,
      'pricePerUnit': pricePerUnit,
      'harvestDate': harvestDate,
    };

    final response = await _api.post('/batches', body);
    return Batch.fromJson(response);
  }

  Future<List<Batch>> getBatchesByFarm(int farmId) async {
    final res = await _api.get('/batches?farmId=$farmId');
    return (res as List).map((e) => Batch.fromJson(e)).toList();
  }

  Future<Batch> updateBatch(
      int batchId, {
        String? eggType,
        int? quantity,
        double? price,
      }) async {
    final body = <String, dynamic>{};
    if (eggType != null) body['egg_type'] = eggType;
    if (quantity != null) body['quantity'] = quantity;
    if (price != null) body['price'] = price;

    final response = await _api.put('/batches/$batchId', body);
    return Batch.fromJson(response);
  }

  Future<void> deleteBatch(int batchId) async {
    await _api.delete('/batches/$batchId');
  }

}
