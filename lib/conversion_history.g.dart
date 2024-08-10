// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversion_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversionHistoryAdapter extends TypeAdapter<ConversionHistory> {
  @override
  final int typeId = 0;

  @override
  ConversionHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConversionHistory(
      originalValue: fields[0] as double,
      sourceUnit: fields[1] as String,
      targetUnit: fields[2] as String,
      convertedResult: fields[3] as double,
      timestamp: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ConversionHistory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.originalValue)
      ..writeByte(1)
      ..write(obj.sourceUnit)
      ..writeByte(2)
      ..write(obj.targetUnit)
      ..writeByte(3)
      ..write(obj.convertedResult)
      ..writeByte(4)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversionHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
