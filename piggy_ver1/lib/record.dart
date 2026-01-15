
class Record {
  final String title;
  final String time;
  final String category;
  final int amount;

  Record({required this.title, required this.time, required this.category, required this.amount});
}

final List<Record> records = [];
final int allSpends = records.fold(0, (sum, record) => sum + record.amount);
