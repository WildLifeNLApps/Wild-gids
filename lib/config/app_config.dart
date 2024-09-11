import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wildgids/models/enums/flavor.dart';

Flavor getFlavorByPackageName(String packageName) {
  if (packageName == 'com.example.wildeBuren.development') {
    return Flavor.development;
  } else {
    //com.example.wildeBuren
    return Flavor.production;
  }
}

class AppConfig {
  String baseUrl = dotenv.get('PROD_BASE_URL');
  Flavor flavor = Flavor.production;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({Flavor flavor = Flavor.production}) {
    switch (flavor) {
      case Flavor.development:
        return shared = AppConfig(
          flavor,
          dotenv.get('DEV_BASE_URL'),
        );
      case Flavor.production:
        return shared = AppConfig(
          flavor,
          dotenv.get('PROD_BASE_URL'),
        );
    }
  }

  AppConfig(this.flavor, this.baseUrl);
}
