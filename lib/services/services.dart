import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initialServices();
//   runApp(const MyApp());
// }


class SettingServices extends GetxService {
  late SharedPreferences sharedPrefer;

  Future<SettingServices> init() async {
    sharedPrefer = await SharedPreferences.getInstance();
    return this;
  }

  SharedPreferences get sharedPreferences => sharedPrefer;
}

Future<void> initialServices() async {
  await Get.putAsync(() async => await SettingServices().init());
}

SettingServices myService = Get.find();

// To use this service, you can access SharedPreferences like this:
// final preferences = myService.sharedPreferences;
// Use preferences to read/write data as needed.

