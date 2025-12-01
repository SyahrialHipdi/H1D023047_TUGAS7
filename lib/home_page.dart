import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sidemenu.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _username;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('username') ?? 'Pengguna';
    if (mounted) {
      setState(() {
        _username = savedName;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      drawer: SideMenu(username: _username),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selamat datang, ${_username ?? 'Pengguna'}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sesi login Anda tersimpan di perangkat ini.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
