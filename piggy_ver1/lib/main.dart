import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 匯入 Flutter 套件
import 'feedPage.dart';
import 'historyPage.dart';

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
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            backgroundColor: const Color.fromARGB(255, 99, 93, 76),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(223, 248, 197, 197), // 橘色系按鈕
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('點我開始餵BABUY吃', style: TextStyle(fontSize: 18),),
            ),
            ElevatedButton(
              onPressed: () {
                // 【關鍵代碼】：切換到紀錄頁面
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryPage(title: 'History Page')),
                );
              },            
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 222, 175, 132), // 橘色系按鈕
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('點我看BABUY吃過的', style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
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