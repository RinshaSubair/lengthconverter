import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:length_conversion/conversion_history.dart';
import 'package:length_conversion/history.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final _textController = TextEditingController();
  String _result = '';
  String? _convertto;
  String? _convertfrom;

  final _list = [
    'Millimeters (mm)',
    'Centimeters (cm)',
    'Meters (m) ',
    'Kilometers (km)',
    'Inches (inch)',
    'Feet (ft)',
  ];

  final Map<String, double> _toBaseUnit = {
    'Millimeters (mm)': 0.001,
    'Centimeters (cm)': 0.01,
    'Meters (m)': 1.0,
    'Kilometers (km)': 1000.0,
    'Inches (inch)': 0.0254,
    'Feet (ft)': 0.3048,
  };

  final Map<String, double> _fromBaseUnit = {
    'Millimeters (mm)': 1000.0,
    'Centimeters (cm)': 100.0,
    'Meters (m)': 1.0,
    'Kilometers (km)': 0.001,
    'Inches (inch)': 39.3701,
    'Feet (ft)': 3.28084,
  };

  void _convert() {
    final input = double.tryParse(_textController.text);
    if (input == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    final fromRate = _toBaseUnit[_convertfrom] ?? 1.0;

    final toRate = _fromBaseUnit[_convertto] ?? 1.0;

    final resultInMeters = input * fromRate;

    final resultInTargetUnit = resultInMeters * toRate;

    setState(() {
      _result = resultInTargetUnit.toStringAsFixed(4);
    });

    _addHistoryEntry(input, _convertfrom!, _convertto!, resultInTargetUnit);
  }

  void _addHistoryEntry(
    double originalValue,
    String sourceUnit,
    String targetUnit,
    double convertedResult,
  ) {
    final historyEntry = ConversionHistory(
        originalValue: originalValue,
        sourceUnit: sourceUnit,
        targetUnit: targetUnit,
        convertedResult: convertedResult,
        timestamp: DateTime.now());

    _saveHistory(historyEntry);
  }

  Future<void> _saveHistory(ConversionHistory historyEntry) async {
    final box = await Hive.openBox<ConversionHistory>('conversion_history');
    await box.add(historyEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 185, 157),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(225, 3, 96, 46))),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 2, 51, 4))),
                  hintText: 'Enter the length'),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(228, 7, 83, 9))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 2, 51, 4))),
                    ),
                    hint: Text('Convert from'),
                    items: _list.map(
                      (unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _convertfrom = value as String?;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(228, 7, 83, 9))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 2, 51, 4))),
                    ),
                    hint: Text('Convert to'),
                    items: _list.map(
                      (unit) {
                        return DropdownMenuItem(
                          value: unit,
                          child: Text(unit),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        _convertto = value as String?;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  _convert();
                },
                style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 24, 109, 27),
                    backgroundColor: Color.fromARGB(255, 196, 237, 198)),
                child: Text('CONVERT')),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 156, 207, 159),
                  border: Border.all(color: Color.fromARGB(255, 2, 51, 4))),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(225, 3, 96, 46))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 2, 51, 4))),
                    hintText: 'Result'),
                style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 3, 49, 22),
                    fontWeight: FontWeight.bold),
                controller: TextEditingController(text: _result),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return History();
                }));
              },
              style: TextButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 24, 109, 27),
                  backgroundColor: Color.fromARGB(255, 196, 237, 198)),
              child: Text('History'),
            ),
          ],
        ),
      )),
    );
  }
}


