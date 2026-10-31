
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  // Güvenli depolama paketinin bir örneğini oluşturuyoruz.
  final FlutterSecureStorage _storage;

  // Sınıf oluşturulurken güvenli depolama nesnesi hazırlanır.
  TokenStorageService()
      : _storage = FlutterSecureStorage();

  // Belirteci güvenli alana kaydeder.
  Future<void> saveToken(String token) async {
    await _storage.write(
      key: 'access_token',
      value: token,
    );
  }

  // Daha önce kaydedilmiş belirteci okur.
  // Belirteç bulunmuyorsa null döndürür.
  Future<String?> readToken() async {
    return await _storage.read(
      key: 'access_token',
    );
  }

  // Kaydedilmiş belirteci siler.
  Future<void> clearToken() async {
    await _storage.delete(
      key: 'access_token',
    );
  }
}
