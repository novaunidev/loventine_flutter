String formatTimeDiffString(String postingTime) {
  String diffString = formatTimeDifference(postingTime);
  return diffString;
}

String formatTimeDifference(String jsonTime) {
  jsonTime = jsonTime.replaceAll('Z', '');
  DateTime postTime = DateTime.parse(jsonTime);
  Duration diff = DateTime.now().difference(postTime);

  if (diff.inSeconds < 180) {
    return 'Vừa xong';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} phút';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} giờ';
  } else if (diff.inDays < 30) {
    return '${diff.inDays} ngày';
  } else {
    return '${diff.inDays ~/ 30} tháng';
  }
}

String formatTimeDifferenceDelete(String jsonTime) {
  DateTime postTime = DateTime.parse(jsonTime);
  Duration diff = DateTime.now().difference(postTime);
  return diff.inDays.toString();
}

int formatTimeDifferenceDeleteRemaining(String jsonTime) {
  DateTime postTime = DateTime.parse(jsonTime);
  Duration diff = DateTime.now().difference(postTime);

  return (60 - diff.inDays);
}

getMonth(type) {
  String month;

  const map = {
    'Jan': '01',
    'Feb': '02',
    'Mar': '03',
    'Apr': '04',
    'May': '05',
    'Jun': '06',
    'Jul': '07',
    'Aug': '08',
    'Sep': '09',
    'Oct': '10',
    'Nov': '11',
    'Dec': '12',
  };

  month = map[type] ?? 'Not found';

  return month;
}

String formatTimeDiffStringComment(String postingTime) {
  String diffString = formatTimeDifferenceComment(postingTime);
  return diffString;
}

String formatTimeDifferenceComment(String jsonTime) {
  DateTime postTime = DateTime.parse(jsonTime);
  Duration diff = DateTime.now().difference(postTime);

  if (diff.inSeconds < 180) {
    return 'Vừa xong';
  } else if (diff.inMinutes < 60) {
    return '${diff.inMinutes} phút';
  } else if (diff.inHours < 24) {
    return '${diff.inHours} giờ';
  } else if (diff.inDays < 30) {
    return '${diff.inDays} ngày';
  } else {
    return '${diff.inDays ~/ 30} tháng';
  }
}
