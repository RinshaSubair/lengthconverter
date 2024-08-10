import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:length_conversion/conversion_history.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<ConversionHistory> _historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final box = await Hive.openBox<ConversionHistory>('conversion_history');
    setState(() {
      _historyList = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONVERSION HISTORY',style: TextStyle(color: Color.fromARGB(255, 12, 54, 15)),),
        backgroundColor: Color.fromARGB(255, 68, 143, 113),
        
      ),

      backgroundColor: Color.fromARGB(255, 116, 185, 157),
      body: ListView.builder(
        itemCount: _historyList.length,
        itemBuilder: (context, index) {
          final history = _historyList[index];
          return ListTile(
            title: Text(
              '${history.originalValue} ${history.sourceUnit} to ${history.targetUnit}: ${history.convertedResult}',
            ),
            subtitle: Text('Converted on: ${history.timestamp}'),
          );
        },
      ),
    );
  }
}









