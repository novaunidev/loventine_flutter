// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageUrlAdapter extends TypeAdapter<ImageUrl> {
  @override
  final int typeId = 2;

  @override
  ImageUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageUrl(
      bannerMorning: fields[0] as String?,
      bannerAfternoon: fields[1] as String?,
      bannerEvening: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageUrl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.bannerMorning)
      ..writeByte(1)
      ..write(obj.bannerAfternoon)
      ..writeByte(2)
      ..write(obj.bannerEvening);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
