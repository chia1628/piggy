import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 匯入 Flutter 套件
import 'package:flutter/cupertino.dart'; // 記得引入
import 'package:piggy_ver1/record.dart';
import 'feedPage.dart';



class HistoryPage extends StatefulWidget {
  final String title;
  // homepage 組件的「身分證登記」, required this.title 表示 title 是必須提供的參數
  const HistoryPage({super.key, required this.title});
  
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Map<String, List<Record>> historyRecords = groupRecordsByMonth(records);
  
  DateTime _selectedDate = DateTime.now(); // 預設為今天

  String get selectedMonthKey {
    return "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}";
  }

  Future<void> _pickYearMonth(BuildContext context) async {
    
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: Colors.white,
        child: Column(
          children: [
            // 上方的確認按鈕列
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
                  TextButton(
                    onPressed: () {
                      // 在這裡執行你的篩選邏輯
                      setState(() {
                        // _selectedDate 會根據滾輪停留的位置更新
                      });
                      Navigator.pop(context);
                    }, 
                    child: const Text('確認')
                  ),
                ],
              ),
            ),
            // 滾輪主體
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.monthYear, // 關鍵：設定為年月模式
                initialDateTime: _selectedDate,
                minimumDate: DateTime(2026, 1), // 允許選擇的最早日期 (2020年1月)
                maximumDate: DateTime(2030, 12), // 允許選擇的最晚日期 (2030年12月)
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Record> get filterRecords {
    return historyRecords[selectedMonthKey] ?? [];
  }

  int get allSpends {
    // 使用 record (單數) 來取得每一筆的金額
    return filterRecords.fold(0, (sum, record) => sum + record.amount);
  }

  Map<String, int> get categorySpends {
    Map<String, int> spends = {};
    for (var category in categories){
      spends[category] = 0;
    }
    for (var record in filterRecords) {
      spends[record.category] = (spends[record.category] ?? 0) + record.amount;
    }
    return spends;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('紀錄月份：', style: TextStyle(fontSize: 16))), // 固定標籤寬度

                OutlinedButton.icon(
                  onPressed: () => _pickYearMonth(context),
                  icon: const Icon(Icons.calendar_today),
                  label: Text(selectedMonthKey.split(' ')[0]), // 只顯示 yyyy-mm-dd
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(280, 45), // 調整到跟上面一樣
                    side: const BorderSide(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                  ),
                ),
              ],
            ),
          ),
          
          Container(
            width: 350, // 調整到跟上面一樣
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // 內距
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 133, 130, 127), // 邊框顏色
                width: 2,             // 邊框粗細
              ),
              borderRadius: BorderRadius.circular(8), // 圓角
            ),
            alignment: Alignment.center,
            
            child: Text(
              '目前總花費: \$$allSpends',
              style: const TextStyle(
                color: Color.fromARGB(255, 138, 127, 111),
                fontSize: 20,
                fontWeight: FontWeight.bold,),
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: PageView(
              children: [
                Stack(
                  alignment:Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('本月支出統計', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        Flexible(
                          flex: 3, // 給清單較大的比例
                          child: filterRecords.isEmpty
                          ? Text("目前沒有紀錄，去餵BABUY吧！", style: const TextStyle(fontSize: 16),)
                          : ListView.builder(
                            itemCount: filterRecords.length,
                            itemBuilder: (context, index) {
                              final record = filterRecords[index];
                              return ListTile(
                                title: Text(record.title),
                                subtitle: Text('${record.time} - ${record.category}'),
                                trailing: Text('\$${record.amount}'),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 50,  // 距離底部 50 像素]
                          left: 20,
                          right: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              // 【關鍵代碼】：切換到記帳頁面
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const FeedPiggyPage(title: 'Records Page')),
                              );
                            },            
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(223, 248, 197, 197), // 橘色系按鈕
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('點我給BABUY食物', style: TextStyle(fontSize: 18),),
                          ),
                        ),
                        const SizedBox(height: 25),
                    
                      ],
                    ),
                    
                  ],  
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('各類別支出統計', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: categorySpends.isEmpty
                          ? const Center(child: Text("本月尚無類別資料"))
                          : ListView(
                              children: categorySpends.entries.map((entry) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                  child: ListTile(
                                    leading: Icon(categoryIcons[entry.key] ?? Icons.paid, color: Color(0xFFF8C5C5)),
                                    title: Text(entry.key, style: const TextStyle(fontSize: 18)),
                                    trailing: Text('\$${entry.value}', 
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ),
                                );
                              }).toList(),
                            ),
                    ),
                  ],
                ),
              ]
            ),
          ),          
        ]
        
      )
      
      
      
      
      
      
      
      
      
      
       
    );
  }
}
