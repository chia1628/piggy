import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 匯入 Flutter 套件
import 'package:flutter/cupertino.dart'; // 記得引入
import 'package:piggy_ver1/record.dart';
import 'feedPage.dart';



class SplitPage extends StatefulWidget {
  final String title;
  // homepage 組件的「身分證登記」, required this.title 表示 title 是必須提供的參數
  const SplitPage({super.key, required this.title});
  
  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  String _selectedMember = '熊叔叔';

  final TextEditingController _textController = TextEditingController();
  Map<String, int> splitAmounts = splitAmountByMember(splitRecords);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(width: 90, child: Text('要分誰錢：',style: TextStyle(fontSize: 16))),
                      Container(
                        width: 250, // 調整到跟上面一樣
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
                            items: membersExceptMe.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                          ),
                        ),
                        
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(width: 90, child: Text('欠了多少：',style: TextStyle(fontSize: 16))),
                      Container(
                        width: 250, // 調整到跟上面一樣
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 97, 85, 67), width: 2.0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${splitAmounts[_selectedMember] ?? 0} 元',
                          style: const TextStyle(fontSize: 16,)
                        ),
                      ),
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      const SizedBox(width: 90, child: Text('還飼料嗎：', style: TextStyle(fontSize: 16))), // 固定標籤寬度
                      SizedBox(
                        width: 250, // 【精確調整寬度】
                        height: 45, // 【精確調整高度】
                        child: TextField(
                          controller: _textController,
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
              ],
            )
          ),
        ],
      ),
    );
  }
}
