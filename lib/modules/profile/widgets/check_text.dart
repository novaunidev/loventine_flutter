final List<String> forbiddenWords = [
  "Loventine",
  "Đéo",
  "Cặc",
  "Lồn",
  "Đụ",
  "Địt",
  "Chịch",
  "Đách",
  "Đĩ",
  "Đỹ",
  "Con mẹ",
  "Dâm",
  "Fuck",
  "Bitch"
];
bool checkText(String value) {
  for (String word in forbiddenWords) {
    if (value.toLowerCase().contains(word.toLowerCase())) {
      return true;
    }
  }
  return false;
}
