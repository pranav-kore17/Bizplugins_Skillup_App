
import 'package:intl/intl.dart';
// import 'package:irujul_erp/utils/ApiManager/ApiManager.dart';
import 'package:bizplugins_skillup/utils/ApiManager/ApiManager.dart';
import '../../app_manager.dart';

String baseUrl = "https://testerp.irujul.com";
String verifyServerPinApi = "/apis/v1/mpin";
String loginApi = "/apis/v1/login";
String getRecordsApi  = "/apis/v1/getRecords";
String getItemInfoApi = "/apis/v1/getItemInfo";
String createApi = "/apis/v1/create";
String updateApi = "/apis/v1/update";

class AppRepository {

  final BaseApiManager apiManager = ApiManager();

  Future<dynamic> loginAPI(String username, String password) async {
    dynamic request = {
      "client_id": username,
      "client_secret": password
    };

    final url = "$baseUrl$loginApi";

    print("LOGIN URL => $url");

    var response = await apiManager.postApi(url, request);

    print("LOGIN RESPONSE => $response");

    return response;
  }

}