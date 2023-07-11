import 'package:flutter/material.dart';

class UserData {
  String namaLengkap = '';
  String email = '';
  String password = '';
  String spesialis = '';
  String nomorHandphone = '';

  String changePassword({
    String inputPasswordLama = '',
    String inputPasswordBaru = '',
    String inputConfirmPasswordBaru = '',
  }) {
    if (inputPasswordLama == password) {
      if (inputPasswordBaru == inputConfirmPasswordBaru) {
        password = inputPasswordBaru;
        return 'Password berhasil diubah';
      } else {
        return 'Password baru tidak sama';
      }
    } else {
      return 'Password lama tidak tepat';
    }
  }
}
