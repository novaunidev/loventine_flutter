// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison, use_build_context_synchronously
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loventine_flutter/models/profile/user_education.dart';
import 'package:loventine_flutter/models/profile/user_language.dart';
import 'package:loventine_flutter/models/profile/user_resume.dart';
import 'package:loventine_flutter/models/profile/user_review.dart';
import 'package:loventine_flutter/models/profile/user_skill.dart';
import 'package:loventine_flutter/models/profile/user_work.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';

import '../../../config.dart';

class User {
  late String password;
  late String email;
  late String name;
  late bool verified;
  String? about;
  String? bio;
  String? birthday;
  String? phone;
  String? address;
  String? sex;
  late List<String> fcmTokens;
  String? walletPassword;
  User(
      {required this.password,
      required this.email,
      required this.name,
      required this.verified,
      this.about,
      this.bio,
      this.birthday,
      this.phone,
      this.address,
      this.sex,
      this.walletPassword});

  User.fromJson(Map json) {
    password = json['password'];
    name = json['name'];
    email = json['email'] ?? "";
    verified = json['verified'];
    about = json['about'] ?? "";
    bio = json['bio'] ?? "";
    birthday = json['birthday'] ?? "";
    phone = json['phone'] ?? "";
    address = json['address'] ?? "";
    sex = json['sex'] ?? "";
    walletPassword = json['walletPassword'] ?? "";
  }
}

class CardProfileProvider with ChangeNotifier {
  User user = User(
    password: '',
    email: '',
    name: '',
    verified: false,
  );
  User userOther = User(
    password: '',
    email: '',
    name: '',
    verified: false,
  );

  List<UserReview> _reviews = [];

  List<UserReview> get reviews => _reviews;

  List<UserWork> _works = [];

  List<UserWork> get works => _works;

  List<UserEducation> _educations = [];

  List<UserEducation> get educations => _educations;

  List<UserResume> _resumes = [];

  List<UserResume> get resumes => _resumes;

  List<UserSkill> _skills = [];

  List<UserSkill> get skills => _skills;

  List<UserLanguage> _languages = [];

  List<UserLanguage> get languages => _languages;

  Future<void> fetchCurrentUser(String current_user_id) async {
    print("💯Đang lấy dữ liệu ở cardprofile");
    final url = Uri.parse('$baseUrl/auth/getUser/$current_user_id');
    final Map<String, dynamic> extractedData;
    try {
      final response = await get(url);
      extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      //USER
      user = User.fromJson(extractedData['message']);
      //REVIEW
      var reviewsServer = extractedData["message"]["reviews"];
      _reviews = [];
      for (int i = 0; i < reviewsServer.length; i++) {
        _reviews.add(
            UserReview.toUserReview(reviewsServer[i] as Map<String, dynamic>));
      }

      //WORK
      var worksServer = extractedData["message"]["works"];
      _works = [];
      for (int i = 0; i < worksServer.length; i++) {
        _works.add(UserWork.toUserWork(worksServer[i] as Map<String, dynamic>));
      }

      //EDUCATION
      var educationsServer = extractedData["message"]["educations"];
      _educations = [];
      for (int i = 0; i < educationsServer.length; i++) {
        _educations.add(UserEducation.toUserEducation(
            educationsServer[i] as Map<String, dynamic>));
      }

      //RESUMES
      var resumesServer = extractedData["message"]["resumes"];
      _resumes = [];
      for (var resume in resumesServer) {
        String title = resume['title'];
        String _id = resume['_id'];
        List<dynamic> content = resume['content'];
        _resumes.add(UserResume(title: title, content: content, id: _id));
      }

      //SKILL
      var skillsServer = extractedData["message"]["skills"];
      _skills = [];
      for (int i = 0; i < skillsServer.length; i++) {
        _skills.add(
            UserSkill.toUserSkill(skillsServer[i] as Map<String, dynamic>));
      }

      //LANGUAGE
      var languagesServer = extractedData["message"]["languages"];
      _languages = [];
      for (int i = 0; i < languagesServer.length; i++) {
        _languages.add(UserLanguage.toUserLanguage(
            languagesServer[i] as Map<String, dynamic>));
      }
    } catch (error) {
      throw (error);
    }

    notifyListeners();
  }

  Future<void> fetchOtherUser(String userId) async {
    final url = Uri.parse('$baseUrl/auth/getUser/$userId');
    try {
      final response = await get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      //USER
      userOther = User.fromJson(extractedData['message']);
      //REVIEW
      var reviewsServer = extractedData["message"]["reviews"];
      _reviews = [];
      for (int i = 0; i < reviewsServer.length; i++) {
        _reviews.add(
            UserReview.toUserReview(reviewsServer[i] as Map<String, dynamic>));
      }

      //WORK
      var worksServer = extractedData["message"]["works"];
      _works = [];
      for (int i = 0; i < worksServer.length; i++) {
        _works.add(UserWork.toUserWork(worksServer[i] as Map<String, dynamic>));
      }

      //EDUCATION
      var educationsServer = extractedData["message"]["educations"];
      _educations = [];
      for (int i = 0; i < educationsServer.length; i++) {
        _educations.add(UserEducation.toUserEducation(
            educationsServer[i] as Map<String, dynamic>));
      }

      //RESUMES
      var resumesServer = extractedData["message"]["resumes"];
      _resumes = [];
      for (var resume in resumesServer) {
        String title = resume['title'];
        String _id = resume['_id'];
        List<dynamic> content = resume['content'];
        _resumes.add(UserResume(title: title, content: content, id: _id));
      }

      //SKILL
      var skillsServer = extractedData["message"]["skills"];
      _skills = [];
      for (int i = 0; i < skillsServer.length; i++) {
        _skills.add(
            UserSkill.toUserSkill(skillsServer[i] as Map<String, dynamic>));
      }

      //LANGUAGE
      var languagesServer = extractedData["message"]["languages"];
      _languages = [];
      for (int i = 0; i < languagesServer.length; i++) {
        _languages.add(UserLanguage.toUserLanguage(
            languagesServer[i] as Map<String, dynamic>));
      }
    } catch (error) {
      throw (error);
    }
    notifyListeners();
  }

  //Update CardProfile
  Future<void> updateCardProfile(
      String current_user_id,
      String about,
      String name,
      String birthday,
      String email,
      String phone,
      String sex,
      String address,
      BuildContext context) async {
    final url = '$baseUrl/auth/updateUser/$current_user_id';
    try {
      var response = await Dio().put(url, data: {
        'about': about,
        'name': name,
        'birthday': birthday,
        'email': email,
        'phone': phone,
        'address': address,
        'sex': sex
      });
      if (response.statusCode == 200) {
        CustomSnackbar.show(
          context,
          title: 'Cập nhật thành công',
          type: SnackbarType.success,
        );
        Navigator.pop(context);
      } else {
        CustomSnackbar.show(
          context,
          title: 'Cập nhật thất bại',
          type: SnackbarType.failure,
        );
        Navigator.pop(context);
      }
    } catch (error) {
      CustomSnackbar.show(
        context,
        title: 'Cập nhật thất bại',
        type: SnackbarType.failure,
      );
      Navigator.pop(context);
    }
    await fetchCurrentUser(current_user_id);
  }

  Future<void> updateAddress(String address, String current_user_id) async {
    final url = '$baseUrl/auth/updateUser/$current_user_id';
    try {
      Dio().put(url, data: {
        'address': address,
      });
    } catch (error) {}
  }
}
