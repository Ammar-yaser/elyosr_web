import 'package:alyosr_order/models/api_response.dart';
import 'package:alyosr_order/services/auth_services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthServiceImpl implements AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<ApiResponse<ConfirmationResult>> signInWithPhoneNumber(
      String phoneNum) async {
    late ApiResponse<ConfirmationResult> response;
    try {
      ConfirmationResult confirmationResult = await _auth.signInWithPhoneNumber(
        phoneNum,
        RecaptchaVerifier(
          // container: 'recaptcha',
          // size: RecaptchaVerifierSize.compact,
          // theme: RecaptchaVerifierTheme.dark,
          onSuccess: () => print('reCAPTCHA Completed!'),
          onError: (FirebaseAuthException error) => throw error,
          onExpired: () => print('reCAPTCHA Expired!'),
        ),
      );
      response = ApiResponse(data: confirmationResult);
    } on FirebaseException catch (e) {
      print('my error: ${e.code}');
      switch (e.code) {
        case "internal-error":
          response = ApiResponse(
            error: true,
            errorMessage: 'تأكد من اتصالك بالإنترنت',
          );
          break;
        case "network-request-failed":
          response = ApiResponse(
            error: true,
            errorMessage: 'تأكد من اتصالك بالإنترنت',
          );
          break;
        case "invalid-phone-number":
          response = ApiResponse(
            error: true,
            errorMessage: 'الرقم غير صحيح',
          );
          break;
        default:
          response = ApiResponse(
            error: true,
            errorMessage: "هناك خطأ ما تأكد من صحة الخطوات",
          );
      }
    }
    return response;
  }

  @override
  Future<ApiResponse<UserCredential>> confirmOTP(
      signInResult, String pinCode) async {
    late ApiResponse<UserCredential> response;
    try {
      UserCredential userData = await signInResult.confirm(pinCode);
      response = ApiResponse(
        data: userData,
      );
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      switch (e.code) {
        case "internal-error":
          response = ApiResponse(
            error: true,
            errorMessage: 'تأكد من اتصالك بالإنترنت',
          );
          break;
        case "network-request-failed":
          response = ApiResponse(
            error: true,
            errorMessage: 'تأكد من اتصالك بالإنترنت',
          );
          break;
        case "invalid-verification-code":
          response = ApiResponse(
            error: true,
            errorMessage: 'الكود الذي أدخلته غير صحيح',
          );
          break;
        default:
          response = ApiResponse(
            error: true,
            errorMessage: "هناك خطأ ما تأكد من صحة الخطوات",
          );
          break;
      }
    }
    return response;
  }
}
