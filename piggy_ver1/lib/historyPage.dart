import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 匯入 Flutter 套件
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), // 內距
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 133, 130, 127), // 邊框顏色
                  width: 2,             // 邊框粗細
                ),
                borderRadius: BorderRadius.circular(8), // 圓角
              ),
              child: Text(
                '目前總花費: \$$allSpends',
                style: const TextStyle(
                  color: Color.fromARGB(255, 138, 127, 111),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Flexible(
              flex: 3, // 給清單較大的比例
              child: records.isEmpty
              ? const Text('目前沒有任何記錄喔！')
              : ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return ListTile(
                    title: Text(record.title),
                    subtitle: Text('${record.time} - ${record.category}'),
                    trailing: Text('\$${record.amount}'),
                  );
                },
              ),
            ),
            ElevatedButton(
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
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
