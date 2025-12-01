import 'package:flutter/material.dart';

import 'sidemenu.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'NIM_Tugas7',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Contoh aplikasi Flutter dengan implementasi routing, '
              'side menu, halaman login, dan penyimpanan lokal '
              'menggunakan SharedPreferences.',
            ),
            SizedBox(height: 12),
            Text(
              'Fitur utama:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('• Navigasi multi-halaman dengan named routes'),
            Text('• Side menu untuk berpindah halaman'),
            Text('• Login sederhana dengan validasi'),
            Text('• Penyimpanan username & status login secara lokal'),
          ],
        ),
      ),
    );
  }
}
