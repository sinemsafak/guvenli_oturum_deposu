#  Güvenli Oturum Deposu

Flutter kullanılarak geliştirilen bu proje, erişim belirteçlerinin (access token) cihaz üzerinde güvenli şekilde saklanmasını, okunmasını ve silinmesini uygulamalı olarak göstermektedir.

Proje kapsamında `flutter_secure_storage` paketi kullanılarak temel bir güvenli belirteç yönetimi servisi oluşturulmuştur.

> **Önemli:** Bu proje eğitim ve test amaçlıdır. Gerçek kullanıcı parolası veya gerçek erişim belirteci kullanılmamaktadır.

## Projenin Amacı

Bu çalışmanın amacı:

- Flutter'da güvenli yerel veri saklamayı öğrenmek.
- `flutter_secure_storage` paketini projeye dahil etmek.
- Belirteç kaydetme, okuma ve silme işlemlerini gerçekleştirmek.
- Uygulama yeniden başlatıldığında belirtecin saklanmaya devam ettiğini doğrulamak.
- Dart dilinde asenkron işlemleri (`Future`, `async`, `await`) kullanmak.
- Servis sınıfı mimarisini uygulamak.
- Git ve GitHub ile proje sürüm kontrolünü gerçekleştirmek.

##  Kullanılan Teknolojiler

| Teknoloji | Açıklama |
|---|---|
| Flutter | Mobil uygulama geliştirme |
| Dart | Programlama dili |
| flutter_secure_storage | Güvenli veri saklama |
| Material 3 | Kullanıcı arayüzü |
| Git | Sürüm kontrolü |
| GitHub | Proje barındırma |

##  Proje Dosya Yapısı

```text
guvenli_oturum_deposu/
│
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   │
│   └── services/
│       └── token_storage_service.dart
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── .gitignore
└── README.md
```

##  Kurulum

### 1. Gereksinimler

Projeyi çalıştırmak için aşağıdaki araçların kurulu olması gerekir:

- Flutter SDK
- Dart SDK
- Visual Studio Code
- Flutter ve Dart VS Code eklentileri
- Git
- Hedef platforma uygun geliştirme araçları (Android Studio, Xcode vb.)

Kurulumları kontrol etmek için:

```bash
flutter --version
dart --version
git --version
flutter doctor -v
```

### 2. Projeyi klonlama

```bash
git clone https://github.com/KULLANICI_ADIN/guvenli_oturum_deposu.git
```

Proje dizinine gir:

```bash
cd guvenli_oturum_deposu
```

### 3. Bağımlılıkları yükleme

```bash
flutter pub get
```

### 4. Uygulamayı çalıştırma

Bağlı cihazları listele:

```bash
flutter devices
```

Uygulamayı başlat:

```bash
flutter run
```

##  Kullanılan Paket

Projede kullanılan temel paket:

```bash
flutter pub add flutter_secure_storage
```

`flutter_secure_storage`, platforma özgü güvenli depolama mekanizmalarını kullanarak hassas verilerin yerel ortamda saklanmasını sağlar.

Paketin resmi sayfası:

https://pub.dev/packages/flutter_secure_storage

##  TokenStorageService

Belirteç işlemleri `TokenStorageService` sınıfı içerisinde yönetilmektedir.

**Dosya konumu:**

```text
lib/services/token_storage_service.dart
```

Servis üç temel metot içerir:

### 1. saveToken()

```dart
Future<void> saveToken(String token) async {
  await _storage.write(
    key: 'access_token',
    value: token,
  );
}
```

Verilen belirteci `access_token` anahtarıyla güvenli depolama alanına kaydeder.

### 2. readToken()

```dart
Future<String?> readToken() async {
  return await _storage.read(
    key: 'access_token',
  );
}
```

Kaydedilmiş belirteci okur. Belirteç bulunmuyorsa `null` döndürür.

### 3. clearToken()

```dart
Future<void> clearToken() async {
  await _storage.delete(
    key: 'access_token',
  );
}
```

Kaydedilmiş belirteci güvenli depolama alanından siler.

##  Uygulama Özellikleri

Uygulama üzerinde üç temel işlem gerçekleştirilebilir:

| İşlem | Açıklama |
|---|---|
| Test Belirteci Kaydet | Sahte test belirtecini güvenli alana kaydeder. |
| Belirteci Oku ve Doğrula | Saklanan değeri test belirteciyle karşılaştırır. |
| Belirteci Sil | Belirteci siler ve ardından `null` olduğunu doğrular. |

Kullanılan test belirteci:

```text
SAHTE_TEST_TOKEN_2026_NOT_REAL
```

Bu değer yalnızca test amacıyla oluşturulmuştur.

**Güvenlik gereği belirteç uygulama ekranında veya terminalde gösterilmez.**

##  Test İşlemleri

### 1. Kod analizi

```bash
flutter analyze
```

### 2. Otomatik test

```bash
flutter test
```

### 3. Manuel test

Aşağıdaki adımlar cihaz üzerinde uygulanır:

1. Uygulama başlatılır.
2. Test Belirteci Kaydet butonuna basılır.
3. Belirteci Oku ve Doğrula butonuna basılarak kayıt doğrulanır.
4. Uygulama tamamen kapatılıp yeniden başlatılır.
5. Belirteç tekrar okunarak kalıcılığı kontrol edilir.
6. Belirteci Sil butonuna basılır.
7. Silme işleminden sonra okuma sonucu `null` olarak doğrulanır.

##  Güvenlik Notları

- Gerçek kullanıcı parolaları bu uygulamada saklanmaz.
- Parolalar sunucu tarafında Argon2id veya bcrypt gibi uygun parola hashleme algoritmalarıyla işlenmelidir.
- Erişim belirteçleri `print()` veya `debugPrint()` ile loglanmamalıdır.
- Sunucu iletişiminde HTTPS kullanılmalıdır.
- Oturum kapatılırken gerekiyorsa sunucu tarafındaki oturum ve refresh token da geçersiz kılınmalıdır.
- Android ve iOS platformlarının güvenli depolama mekanizmaları birbirinden farklıdır.
- Web platformunun güvenlik özellikleri mobil platformlarla eşdeğer kabul edilmemelidir.
- Cihaz güvenliği, yedekleme politikaları ve uygulama yapılandırması ayrıca değerlendirilmelidir.

##  Platform Bilgileri

| Platform | Depolama mekanizması |
|---|---|
| Android | Android Keystore tabanlı şifreleme |
| iOS | Apple Keychain |
| macOS | Keychain |
| Windows | Windows güvenli veri koruma mekanizmaları |
| Linux | Desteklenen masaüstü anahtar zinciri hizmetleri |
| Web | Tarayıcı tabanlı güvenlik ve depolama mekanizmaları |

Platformlara özgü ayrıntılar için resmi paket dokümantasyonu incelenmelidir.

##  Öğrenme Kazanımları

Bu proje tamamlandığında:

- Flutter paket yönetimi öğrenilmiş olur.
- Dart asenkron programlama yapısı uygulanmış olur.
- Güvenli yerel veri saklama işlemleri gerçekleştirilmiş olur.
- Servis sınıfı mimarisi kullanılmış olur.
- Uygulama yeniden başlatıldığında veri kalıcılığı test edilmiş olur.
- Git commit ve GitHub push işlemleri uygulanmış olur.

##  Gelecek Geliştirmeler

Proje ilerleyen aşamalarda aşağıdaki özelliklerle geliştirilebilir:

- Gerçek kimlik doğrulama API entegrasyonu.
- Access token ve refresh token yönetimi.
- Oturum süresi kontrolü.
- Sunucu tarafında token yenileme.
- Güvenli çıkış ve sunucu oturumu sonlandırma.
- Biyometrik doğrulama.
- Otomatik oturum kontrolü.

##  Lisans

Bu proje eğitim ve kişisel öğrenme amacıyla hazırlanmıştır.

##  Proje

**Proje adı:** Güvenli Oturum Deposu

**Klasör adı:** `guvenli_oturum_deposu`

**Geliştirme ortamı:** Visual Studio Code

**Programlama dili:** Dart

**Framework:** Flutter