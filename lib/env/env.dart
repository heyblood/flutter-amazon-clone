import 'package:envied/envied.dart';

part 'env.g.dart';

/// Load enviroment variables from .env file under project root
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'CLOUDINARY_CLOUD_NAME', obfuscate: true)
  static final cloudinaryCloudName = _Env.cloudinaryCloudName;

  @EnviedField(varName: 'CLOUDINARY_UPLOAD_PRESET', obfuscate: true)
  static final cloudinaryUploadPreset = _Env.cloudinaryUploadPreset;

  @EnviedField(varName: 'API_BASR_URL')
  static const apiBaseUrl = _Env.apiBaseUrl;
}
