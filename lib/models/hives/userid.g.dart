// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserIdAdapter extends TypeAdapter<UserId> {
  @override
  final int typeId = 0;

  @override
  UserId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserId(
      userid: fields[0] as String?,
      name: fields[1] as String?,
      avatarUrl: fields[2] as String?,
      avatarCloundinaryPublicId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserId obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(3)
      ..write(obj.avatarCloundinaryPublicId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
