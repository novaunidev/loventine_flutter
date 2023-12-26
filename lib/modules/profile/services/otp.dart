import '/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OTPService {
  Future<int> sendOTPbyPhone(BuildContext context, String phoneNumber) async {
    try {
      final response = await Dio().post(
        '$baseUrl/api/otp/sendOtp',
        data: {'phoneNumber': phoneNumber},
      );
      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 429) {
        return 429;
      } else {
        return 500;
      }
    }
    return 500;
  }

  Future<int> sendOTPbyEmail(BuildContext context, String email) async {
    try {
      final response = await Dio().post(
        '$baseUrl/api/otp/sendOtpByEmail',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        return 200;
      } 
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 429) {
        return 429;
      } else {
        return 500;
      }
    }
    return 500;
  }

//Xác thực OTP
  Future<bool> verifyOTPbyPhone(String phoneNumber, String otp) async {
    try {
      final response = await Dio().post(
        '$baseUrl/api/otp/verifyOtp',
        data: {'phoneNumber': phoneNumber, 'otp': otp},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> verifyOTPbyEmail(String email, String otp) async {
    try {
      print(otp);
      final response = await Dio().post(
        '$baseUrl/api/otp/verifyOtp',
        data: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
