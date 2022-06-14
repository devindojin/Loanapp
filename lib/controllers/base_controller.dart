import 'dart:convert';

import 'package:shelbi_finance/helpers/dialog_helper.dart';
import 'package:shelbi_finance/models/error_response.dart';
import 'package:shelbi_finance/services/api_client.dart';

class BaseController {
  void handleError(error) {
    hideLoading();

    if (error is BadRequestException) {
      DialogHelper.showErrorSnackBar(message: error.message);
    } else if (error is FetchDataException) {
      DialogHelper.showErrorSnackBar(message: error.message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorSnackBar(message: error.message);
    } else if (error is UnAuthorizedException) {
      final errorResponse =
          ErrorResponse.fromJson(jsonDecode(error.message ?? ''));
      DialogHelper.showErrorSnackBar(
          message: errorResponse.errors.first.message);
    } else {
      DialogHelper.showErrorSnackBar();
    }
  }

  showLoading() {
    DialogHelper.showLoading();
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
