import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 匯入 Flutter 套件

// main function
void main() {
  //debugPaintSizeEnabled = true;
  runApp(const MainApp());
}

// StatelessWidget = 無狀態元件: 不會有變化
class MainApp extends StatelessWidget { 
  // MainApp 組件的「身分證登記」。super.key 負責把唯一識別碼交給父類別 StatelessWidget
  const MainApp({super.key});
  @override
  // 告訴系統：「我要改寫父類別的方法」。爸爸（StatelessWidget）本來就有畫畫的能力，但我現在要定義我專屬的畫法。
  Widget build(BuildContext context) {
    // 每當畫面需要顯示時，系統就會跑這一段。context 就像是「地圖」，讓組件知道自己現在在 App 裡的哪個位置。
    return MaterialApp(
      // 1. 設定主題 (放在這裡)
      theme: ThemeData(
        fontFamily: 'openhuninn',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        canvasColor: const Color.fromARGB(255, 248, 232, 187), 
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 64, 63, 59),
            backgroundColor: const Color.fromARGB(255, 250, 227, 156),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      // 2. 設定首頁 (home 參數後面接的是一個 Widget)
      home: const HomePage(title: 'Piggy App'),
    );
  }
}
 
// StatefulWidget = 有狀態元件: 會有變化 不用build
class HomePage extends StatefulWidget {
  final String title;
  // homepage 組件的「身分證登記」, required this.title 表示 title 是必須提供的參數
  const HomePage({super.key, required this.title});
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

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
            //  Image.asset(
            //   'assets/Babuy_logo.png', // 檔案路徑
            //   width: 200,        // 設定寬度
            //   height: 200,       // 設定高度
            //   fit: BoxFit.contain, // 讓圖片完整顯示在框框內
            // ),
            Text('準備好要開始記帳了嗎?'),
            Text('start to feed your piggy bank'),
            // Text('$counter', style: Theme.of(context).textTheme.headlineMedium,),
            ElevatedButton(
              onPressed: () {
                // 【關鍵代碼】：切換到記帳頁面
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedPiggyPage(title: 'Records Page')),
                );
              },
              child: const Text('點我開始餵豬', style: TextStyle(fontSize: 18)),
            ),

          ],
        ),
      ),
    );
  }
}

class FeedPiggyPage extends StatefulWidget {
  final String title;
  // homepage 組件的「身分證登記」, required this.title 表示 title 是必須提供的參數
  const FeedPiggyPage({super.key, required this.title});
  
  @override
  _FeedPiggyPageState createState() => _FeedPiggyPageState();
}

class Record {
  final String title;
  final String time;
  final String category;
  final int amount;

  Record({required this.title, required this.time, required this.category, required this.amount});
}

class _FeedPiggyPageState extends State<FeedPiggyPage> {
  
  final List<Record> _records = [];

  // 2. 建立控制器，用來抓取輸入框裡的文字
  final TextEditingController _textController = TextEditingController();
  final Set<String> _categories = {'餐飲', '交通', '購物', '娛樂', '其他'};
  DateTime _selectedDate = DateTime.now(); // 預設為今天
  String _selectedCategory = '餐飲';
  void _addRecord() {
    // 檢查輸入框是否為空
    if (_textController.text.isEmpty) return;

    setState(() {
      // 3. 把新資料加進清單
      _records.add(Record(
        title: _textController.text,
        time: DateTime.now().toString().substring(0, 16), // 抓取現在時間
        category: _selectedCategory,
        amount: 0,
      ));
    });

    _textController.clear(); // 新增完後清空輸入框
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          // 上方輸入區
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const SizedBox(width: 90, child: Text('消費項目：', style: TextStyle(fontSize: 16))), // 固定標籤寬度
                SizedBox(
                  width: 280, // 【精確調整寬度】
                  height: 45, // 【精確調整高度】
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      hintText: '例如：好吃蘿蔔糕',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0), // 設定左右間距
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
                      items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
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
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _addRecord,
          ),
        ],
      ),
    );
  }
}


// TextDecoration.underline：文字底線
// TextDecoration.lineThrough：刪除線
// TextDecoration.overline：文字上方加線

// MaterialApp 的 home 參數指定了 Scaffold。
// Scaffold 的 body 參數指定了 Center。
// Center 的 child 參數則是用來指定要顯示的元件內容，即 Text。

          // 4. 下方清單區：使用 Expanded 讓清單佔滿剩餘空間
          // Expanded(
          //   child: _records.isEmpty 
          //     ? const Center(child: Text('目前沒有紀錄，餵豬囉！')) // 如果沒資料顯示這行
          //     : ListView.builder(
          //         itemCount: _records.length,
          //         itemBuilder: (context, index) {
          //           return ListTile(
          //             leading: const CircleAvatar(child: Icon(Icons.savings)),
          //             title: Text(_records[index]['title']),
          //             subtitle: Text(_records[index]['time']),
          //             trailing: IconButton(
          //               icon: const Icon(Icons.delete, color: Colors.red),
          //               onPressed: () {
          //                 setState(() {
          //                   _records.removeAt(index); // 刪除該筆資料
          //                 });
          //               },
          //             ),
          //           );
          //         },
          //       ),
          // ),