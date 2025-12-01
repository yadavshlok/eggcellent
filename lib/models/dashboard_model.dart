class DashboardStats {
  final int totalBatches;
  final double totalEarnings;
  final int activeOrders;
  final double freshnessScore;

  DashboardStats({
    required this.totalBatches,
    required this.totalEarnings,
    required this.activeOrders,
    required this.freshnessScore,
  });
}

class EarningTrend {
  final String date;
  final double amount;

  EarningTrend({required this.date, required this.amount});
}

class EggTypeDistribution {
  final String eggType;
  final int count;
  final double percentage;

  EggTypeDistribution({
    required this.eggType,
    required this.count,
    required this.percentage,
  });
}

class OrderStatusBreakdown {
  final String status;
  final int count;

  OrderStatusBreakdown({required this.status, required this.count});
}
