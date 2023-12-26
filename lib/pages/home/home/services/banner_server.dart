// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../providers/banner/banner_home_provider.dart';
import '../../../../providers/page/message_page/message_page_provider.dart';

void maybeRunOncePerDay(context) async {
  final now = DateTime.now();
  final startOfDay = DateTime(
      now.year, now.month, now.day, 5, 30); //Bắt đầu lấy API vào 5h30p sáng

  final prefs = await SharedPreferences.getInstance();
  final lastRunString = prefs.getString('last_run_time') ?? '';
  final lastRun = DateTime.tryParse(lastRunString);
  if (lastRun == null ||
      !isSameDay(lastRun, now) ||
      now.isBefore(startOfDay) ||
      Provider.of<MessagePageProvider>(context, listen: false)
          .bannerMorning
          .isEmpty) {
    runFunctions(context);
    prefs.setString('last_run_time', now.toIso8601String());
  }
}

bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

void runFunctions(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    await Provider.of<BannerHomeProvider>(context, listen: false)
        .fetchBannerHomes();
    final bannerURL =
        Provider.of<BannerHomeProvider>(context, listen: false).bannerHome;
    await Provider.of<MessagePageProvider>(context, listen: false)
        .setBannerUrl(bannerURL);
  });
}
