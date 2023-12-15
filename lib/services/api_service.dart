import 'package:http/http.dart';

class ApiServices {
  Future<Response> ApiGet({int surah = 114}) async {
    Response response = await get(Uri.parse(
        "https://quranenc.com/api/v1/translation/sura/indonesian_sabiq/$surah"));
    return response;
  }
}
