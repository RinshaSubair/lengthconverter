import 'package:hive/hive.dart';
part 'conversion_history.g.dart';

@HiveType(typeId: 0)
class ConversionHistory {
  @HiveField(0)
  double originalValue;
  @HiveField(1)
  String sourceUnit;
  @HiveField(2)
  String targetUnit;
  @HiveField(3)
  double convertedResult;
  @HiveField(4)
  DateTime timestamp;

  ConversionHistory(
      {required this.originalValue,
      required this.sourceUnit,
      required this.targetUnit,
      required this.convertedResult,
      required this.timestamp});
}
