import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 匯入 Flutter 套件
import 'record.dart';

class FeedPiggyPage extends StatefulWidget {
  final String title;
  // homepage 組件的「身分證登記」, required this.title 表示 title 是必須提供的參數
  const FeedPiggyPage({super.key, required this.title});
  
  @override
  _FeedPiggyPageState createState() => _FeedPiggyPageState();
}

class _FeedPiggyPageState extends State<FeedPiggyPage> {
  
  // 建立控制器，用來抓取輸入框裡的文字
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  
  
  DateTime _selectedDate = DateTime.now(); // 預設為今天
  String _selectedCategory = '餐飲';
  String _selectedMember = '自作自受';
  int _peopleCount = 1;      // 分錢人數
  double _amount = 0;       // 總金額


    // 開啟日期選擇器
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,      // 初始顯示日期
      firstDate: DateTime(2020),      // 允許選擇的最早日期
      lastDate: DateTime(2030),       // 允許選擇的最晚日期
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked; // 更新選中的日期
      });
    }
  }

  void _addRecord() {
    if (_textController.text.isEmpty) {
      // 如果沒填寫項目，彈出提示（可選）
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請輸入消費項目！')),
      );
      return;
    }
    int amountValue = int.tryParse(_amountController.text) ?? 0;
    setState(() {
      // 將資料打包存入清單
      records.add(Record(
        title: _textController.text,
        time: _selectedDate.toString().substring(0, 16), // 抓取現在時間
        category: _selectedCategory,
        amount: amountValue,
      ));
      
      // 存完後清空輸入框，方便下一筆輸入
      _textController.clear();
      _selectedCategory = '餐飲';
      _amountController.clear();
    });

    // 提示使用者存好了
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('成功餵食豬豬！')),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          // 上方輸入區
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('消費類別：',style: TextStyle(fontSize: 16))),
                Container(
                  width: 280, // 調整到跟上面一樣
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.orange.shade50, // 點開後的選單背景色（淡橘色）
                      value: _selectedCategory,
                      isExpanded: true,
                      onChanged: (val) => setState(() => _selectedCategory = val!),
                      items: categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('消費項目：', style: TextStyle(fontSize: 16))), // 固定標籤寬度
                SizedBox(
                  width: 280, // 【精確調整寬度】
                  height: 45, // 【精確調整高度】
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      hintText: '例如：好吃蘿蔔糕',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),), // 50% 的透明度
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        // 從 Map 中抓取對應圖標，如果找不到則預設顯示 paid
                        categoryIcons[_selectedCategory] ?? Icons.paid, 
                        color: const Color.fromARGB(255, 97, 85, 67),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('消費金額：', style: TextStyle(fontSize: 16))), // 固定標籤寬度
                SizedBox(
                  width: 280, // 【精確調整寬度】
                  height: 45, // 【精確調整高度】
                  child: TextField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                      prefixIcon: Visibility(
                        visible: true,
                        child: Icon(Icons.paid, color: Color.fromARGB(255, 97, 85, 67)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('消費日期：', style: TextStyle(fontSize: 16))), // 固定標籤寬度

                OutlinedButton.icon(
                  onPressed: () => _pickDate(context),
                  icon: const Icon(Icons.calendar_today),
                  label: Text("${_selectedDate.toLocal()}".split(' ')[0]), // 只顯示 yyyy-mm-dd
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(280, 45), // 調整到跟上面一樣
                    side: const BorderSide(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('要分錢嗎：',style: TextStyle(fontSize: 16))),
                Container(
                  width: 280, // 調整到跟上面一樣
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Colors.orange.shade50, // 點開後的選單背景色（淡橘色）
                      value: _selectedMember,
                      isExpanded: true,
                      icon: const Icon(Icons.pets, color: Color.fromARGB(255, 97, 85, 67)),
                      onChanged: (val) => setState(() => _selectedMember = val!),
                      items: members.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    ),
                  ),
                ),
              ],
            )
          ),
          const SizedBox(height: 15), // 【調整這裡】：增加 20 像素的垂直空隙
          if(_selectedMember != '自作自受')
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0), // 設定左右間距
              child: Row(
                children: [
                  const SizedBox(width: 90, child: Text('怎麼分錢：',style: TextStyle(fontSize: 16))),
                  Container(
                    width: 280, // 調整到跟上面一樣
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                    //   borderRadius: BorderRadius.circular(4),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 讓按鈕平均分配空間
                      children: [
                        ElevatedButton(onPressed: () {}, child: const Text('平分')),
                        ElevatedButton(onPressed: () {}, child: const Text('指定金額')),
                      ],
                    ),
                  ),
                ],
              )
            ),
          const SizedBox(height: 15), // 【調整這裡】：增加 20 像素的垂直空隙
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0), // 設定左右間距
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _addRecord, // 呼叫剛才寫的存入函式
                icon: const Icon(Icons.savings, size: 30.0,),
                label: const Text('BABUY 好餓', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 165, 152, 131), // 橘色系按鈕
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}