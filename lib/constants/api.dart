// ignore_for_file: constant_identifier_names

class Api {
  static const String BASE_URL = 'https://shelbifinance.com/api/v1';

  static const String LOGIN = '/auth/login';
  static const String LOGOUT = '/user/logout';
  static const String GET_USER = '/user/get';
  static const String UPDATE_PROFILE = '/user/update-profile';
  static const String MY_INVESTMENT = '/user/my-investment-detail';
  static const String MY_PROFIT = '/user/my-profit';
  static const String PROFIT_DATA = '/user/my-profit-data';

  // Support url
  static const String SUPPORT =
      'https://shelbifinance.com/admin/support_tickets?status=active';
}
