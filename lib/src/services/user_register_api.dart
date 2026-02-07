import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Enum for API status (clean state handling)
enum ApiStatus { idle, loading, success, error }

class UserRegisterApi extends ChangeNotifier {
  /// =============================
  /// API CONFIG
  /// =============================
  static const String _baseUrl =
      'https://umra.noonari.pk/api/auth/register/';

  static const String _csrfToken =
      'VGLRuX9I1stmACnMjGO0b2TQXS95ixnrpNdAcg290VRHWMV7jBXBtrHQh0yk3vCJ';

  /// =============================
  /// STATES
  /// =============================
  ApiStatus _status = ApiStatus.idle;
  String? _errorMessage;

  ApiStatus get status => _status;
  bool get isLoading => _status == ApiStatus.loading;
  bool get isSuccess => _status == ApiStatus.success;
  String? get errorMessage => _errorMessage;

  /// =============================
  /// REGISTER USER
  /// =============================
  Future<void> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth,
  }) async {
    _setLoading();

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: jsonEncode({
          "email": email,
          "password": password,
          "first_name": firstName,
          "last_name": lastName,
          "phone_number": phoneNumber,
          "date_of_birth": dateOfBirth, // yyyy-MM-dd
        }),
      );

      _handleResponse(response);
    } catch (e) {
      _setError("Something went wrong. Please try again.");
    }
  }

  /// =============================
  /// HEADERS
  /// =============================
  Map<String, String> get _headers => {
    'accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CSRFTOKEN': _csrfToken,
  };

  /// =============================
  /// RESPONSE HANDLER
  /// =============================
  void _handleResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      _setSuccess();
    } else {
      try {
        final decoded = jsonDecode(response.body);
        _setError(
          decoded['message'] ??
              decoded.toString(),
        );
      } catch (_) {
        _setError("Invalid server response");
      }
    }
  }

  /// =============================
  /// STATE HELPERS
  /// =============================
  void _setLoading() {
    _status = ApiStatus.loading;
    _errorMessage = null;
    notifyListeners();
  }

  void _setSuccess() {
    _status = ApiStatus.success;
    notifyListeners();
  }

  void _setError(String message) {
    _status = ApiStatus.error;
    _errorMessage = message;
    notifyListeners();
  }

  /// =============================
  /// RESET (Optional)
  /// =============================
  void reset() {
    _status = ApiStatus.idle;
    _errorMessage = null;
    notifyListeners();
  }
}
