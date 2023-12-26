String formatUserName(String fullName) {
  List<String> nameParts = fullName.split(' ');
  String formattedName = '';

  if (nameParts.length > 1) {
    // Nếu có nhiều hơn 1 phần trong tên, lấy phần cuối cùng và phần trước đó
    String lastName = nameParts[nameParts.length - 1];
    String firstName = nameParts[nameParts.length - 2];

    // Kết hợp phần cuối và phần trước để tạo tên format
    formattedName = firstName + ' ' + lastName;
  } else if (nameParts.length == 1) {
    // Nếu chỉ có một phần trong tên, sử dụng phần đó
    formattedName = nameParts[0];
  }

  // Đảm bảo tên format không dài quá 15 ký tự
  if (formattedName.length > 15) {
    formattedName = formattedName.substring(0, 15);
  }

  return formattedName;
}
