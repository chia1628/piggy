// 定義每一筆支出的模型
class Transaction {
  final String id;      // 唯一識別碼
  final String title;   // 項目名稱 (例如：午餐)
  final double amount;  // 金額
  final DateTime date;  // 日期
  final String category; // 分類 (例如：食、衣、住、行)

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}