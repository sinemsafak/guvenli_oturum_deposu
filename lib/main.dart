
import 'package:flutter/material.dart';

import 'services/token_storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const SecureStorageApp());
}

class SecureStorageApp extends StatelessWidget {
  const SecureStorageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Güvenli Oturum Deposu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const TokenDemoPage(),
    );
  }
}

class TokenDemoPage extends StatefulWidget {
  const TokenDemoPage({super.key});

  @override
  State<TokenDemoPage> createState() => _TokenDemoPageState();
}

class _TokenDemoPageState extends State<TokenDemoPage> {
  final TokenStorageService _tokenService =
      TokenStorageService();

  // Yalnızca test amacıyla oluşturulmuş sahte belirteç.
  // Gerçek bir kullanıcı veya sunucuya ait değildir.
  static const String _testToken =
      'SAHTE_TEST_TOKEN_2026_NOT_REAL';

  String _message = 'Henüz bir işlem yapılmadı.';

  bool _isLoading = false;

  Future<void> _saveToken() async {
    setState(() {
      _isLoading = true;
      _message = 'Belirteç kaydediliyor...';
    });

    try {
      await _tokenService.saveToken(_testToken);

      if (!mounted) return;

      setState(() {
        _message = 'Sahte test belirteci başarıyla kaydedildi.';
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _message = 'Belirteç kaydedilirken hata oluştu.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _readToken() async {
    setState(() {
      _isLoading = true;
      _message = 'Belirteç kontrol ediliyor...';
    });

    try {
      final String? savedToken =
          await _tokenService.readToken();

      if (!mounted) return;

      setState(() {
        if (savedToken == _testToken) {
          _message = 'Başarılı: Test belirteci doğrulandı.';
        } else if (savedToken == null) {
          _message = 'Depolama alanında belirteç bulunamadı.';
        } else {
          _message = 'Kayıtlı belirteç beklenen değerle eşleşmiyor.';
        }
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _message = 'Belirteç okunurken hata oluştu.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _clearToken() async {
    setState(() {
      _isLoading = true;
      _message = 'Belirteç siliniyor...';
    });

    try {
      await _tokenService.clearToken();

      final String? savedToken =
          await _tokenService.readToken();

      if (!mounted) return;

      setState(() {
        if (savedToken == null) {
          _message = 'Başarılı: Belirteç silindi ve null doğrulandı.';
        } else {
          _message = 'Hata: Belirteç hâlâ depolama alanında.';
        }
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _message = 'Belirteç silinirken hata oluştu.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Güvenli Oturum Deposu'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.security,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 20),

              const Text(
                'Güvenli Belirteç Yönetimi',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              const Text(
                'Bu uygulama yalnızca sahte bir test '
                'belirteci kullanır. Belirteç değeri '
                'ekranda veya konsolda gösterilmez.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _saveToken,
                  icon: const Icon(Icons.save),
                  label: const Text('Test Belirteci Kaydet'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _readToken,
                  icon: const Icon(Icons.visibility),
                  label: const Text('Belirteci Oku ve Doğrula'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : _clearToken,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Belirteci Sil'),
                ),
              ),

              const SizedBox(height: 28),

              if (_isLoading)
                const CircularProgressIndicator(),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
