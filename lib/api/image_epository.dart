import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import '../models/image_data.dart';

class ImageRepository {
  Future<List<ImageData>> fetchImages(int page, int limit) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    final String url = 'https://picsum.photos/v2/list?page=$page&limit=$limit';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      if (androidInfo.version.sdkInt <= 30) {
        return data.map((json) {
          return ImageData(
              author: json['author'],
              id: json['id'],
              imageUrl: 'https://picsum.photos/id/${json['id']}/200/200');
        }).toList();
      } else {
        return data.map((json) => ImageData.fromJson(json)).toList();
      }
    } else {
      throw Exception('Failed to load images');
    }
  }
}
