import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/page/message_page/card_profile_provider.dart';

String nameUserCurrent(BuildContext context) {
  String name = 'Bạn🥰';
  name = Provider.of<CardProfileProvider>(context, listen: false).user.name;
  return name;
}
