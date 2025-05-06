// TODO: Update this import once api_base_helper.dart is migrated.
// import 'package:api_sdk/rest/api_helpers/api_base_helper.dart';
import 'package:jump_off_platform/core/network/api_base_helper.dart'; // Assuming api_base_helper.dart will be here

class RestApiHandlerData {
  // TODO: Consider if ApiBaseHelper should be injected via DI
  static ApiBaseHelper _apiBaseHelper = ApiBaseHelper();
  static getData(String path) async {
    final response = await _apiBaseHelper.get('$path');
    return response;
  }

  static postData(String path, dynamic body) async {
    final response = await _apiBaseHelper.post('$path', body);
    return response;
  }
} 