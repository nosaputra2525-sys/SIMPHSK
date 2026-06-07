import 'package:frontend/models/user_model.dart';

class AuthService {
  // Dummy data - database user
  static final List<User> _users = [
    User(
      id: '1',
      name: 'Budi Santoso',
      email: 'budi@example.com',
      password: 'password123',
      phone: '081234567890',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    User(
      id: '2',
      name: 'Siti Nurhaliza',
      email: 'siti@example.com',
      password: 'password123',
      phone: '081234567891',
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
    User(
      id: '3',
      name: 'Ahmad Wijaya',
      email: 'ahmad@example.com',
      password: 'password123',
      phone: '081234567892',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    User(
      id: '4',
      name: 'Dewi Lestari',
      email: 'dewi@example.com',
      password: 'password123',
      phone: '081234567893',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  // Current logged in user
  static User? _currentUser;

  User? get currentUser => _currentUser;

  /// Login dengan email dan password
  Future<bool> login(String email, String password) async {
    // Simulasi delay jaringan
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      _currentUser = user;
      return true;
    } catch (e) {
      _currentUser = null;
      return false;
    }
  }

  /// Register user baru
  Future<bool> register(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    // Simulasi delay jaringan
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // Cek apakah email sudah terdaftar
      final isEmailExists = _users.any((u) => u.email == email);
      if (isEmailExists) {
        return false; // Email sudah terdaftar
      }

      // Buat user baru
      final newUser = User(
        id: (int.parse(_users.last.id) + 1).toString(),
        name: name,
        email: email,
        password: password,
        phone: phone,
        createdAt: DateTime.now(),
      );

      // Tambah ke daftar user
      _users.add(newUser);
      _currentUser = newUser;
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  /// Get all users (untuk testing)
  List<User> getAllUsers() => List.from(_users);

  /// Check apakah user sudah login
  bool isLoggedIn() => _currentUser != null;

  /// Get user by email
  User? getUserByEmail(String email) {
    try {
      return _users.firstWhere((u) => u.email == email);
    } catch (e) {
      return null;
    }
  }
}
