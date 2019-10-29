import 'package:flutter_test/flutter_test.dart';
import 'package:pq_toast/web_toast.dart';

void main() {
  test('show toast', () {
    Toast.showErrorToast("Success message");
    Toast.showSuccessToast("Error message");
    Toast.showInfoToast("Info message");
    Toast.showWarningToast("Warning message");
  });
}
