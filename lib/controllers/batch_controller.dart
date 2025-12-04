import 'package:get/get.dart';
import '../data/models/batch.dart';
import '../data/repositories/batch_repository.dart';

class BatchController extends GetxController {
  final BatchRepository _repo = BatchRepository();   // <‑ here

  var batches = <Batch>[].obs;
  var isLoading = false.obs;

  Future<void> loadBatchesForFarm(int farmId) async {
    isLoading.value = true;
    try {
      final data = await _repo.getBatchesByFarm(farmId);
      batches.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createBatch({
    required int farmId,
    required String name,
    required int quantity,
    required double pricePerUnit,
    required String harvestDate,
  }) async {
    try {
      isLoading.value = true;
      final newBatch = await _repo.createBatch(
        farmId: farmId,
        name: name,
        quantity: quantity,
        pricePerUnit: pricePerUnit,
        harvestDate: harvestDate,
      );
      batches.add(newBatch);
      Get.back(); // close dialog
      Get.snackbar('Success', 'Batch created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create batch: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateBatch(
      int batchId, {
        String? eggType,
        int? quantity,
        double? price,
      }) async {
    try {
      isLoading.value = true;
      final updated = await _repo.updateBatch(
        batchId,
        eggType: eggType,
        quantity: quantity,
        price: price,
      );

      final index = batches.indexWhere((b) => b.id == batchId);
      if (index != -1) {
        batches[index] = updated;
        batches.refresh();
      }
      Get.snackbar('Success', 'Batch updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update batch: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBatch(int batchId) async {
    try {
      isLoading.value = true;
      await _repo.deleteBatch(batchId);
      batches.removeWhere((b) => b.id == batchId);
      Get.snackbar('Success', 'Batch deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete batch: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
