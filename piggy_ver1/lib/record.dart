import 'package:flutter/material.dart';

class Record {
  final String title;
  final String time;
  final String category;
  final int amount;
  Record({required this.title, required this.time, required this.category, required this.amount});
}

class SplitRecord {
  final String member;
  final int amount;
  SplitRecord({required this.member, required this.amount});
}

Map<String, List<Record>> groupRecordsByMonth(List<Record> records) {
  Map<String, List<Record>> groups = {};
  for (var r in records) {
    String month = r.time.substring(0, 7);
    groups.putIfAbsent(month, () => []).add(r);
  }
  return groups;
}

Map<String, int> splitAmountByMember(List<SplitRecord> recordsplitRecordss) {
  Map<String, int>  groups = {};

  for (var member in membersExceptMe){
    groups[member] = 0; 
  }
  for (var record in splitRecords){
    groups[record.member] = (groups[record.member] ?? 0) + record.amount;
  }
  return groups;
}


final List<Record> records = [];
final List<SplitRecord> splitRecords = [];
final Set<String> categories = {'餐飲', '交通', '購物', '娛樂', '其他'};
final Map<String, IconData> categoryIcons = {
  '餐飲': Icons.restaurant,
  '交通': Icons.directions_car,
  '購物': Icons.shopping_cart,
  '娛樂': Icons.movie,
  '其他': Icons.more_horiz,
};
final Set<String> members = {'自作自受', '熊叔叔', '宋', '林語晞'};
final Set<String> membersExceptMe = {'熊叔叔', '宋', '林語晞'};
final int allSpends = records.fold(0, (sum, record) => sum + record.amount);
