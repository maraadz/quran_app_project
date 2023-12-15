import 'dart:convert';

import 'package:http/http.dart';
import 'package:quranapp_project/model/quran.dart';
import 'package:quranapp_project/services/api_service.dart';

class FetchController {
  // fetch api
  Future fetchData(int numberofSurah) async {
    Response response = await ApiServices().ApiGet(surah: numberofSurah);
    if (response.statusCode == 200) {
      return SurahModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
