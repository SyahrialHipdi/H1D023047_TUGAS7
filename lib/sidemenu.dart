import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_page.dart';
import 'home_page.dart';
import 'login_page.dart';

class SideMenu extends StatefulWidget {
  final String? username;

  const SideMenu({super.key, this.username});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    if (_username == null) {
      _loadUsername();
    }
  }

  @override
  void didUpdateWidget(covariant SideMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.username != oldWidget.username && widget.username != null) {
      setState(() => _username = widget.username);
    }
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _username = prefs.getString('username') ?? 'Pengguna');
  }

  void _navigateTo(String routeName) {
    Navigator.pop(context);
    final current = ModalRoute.of(context)?.settings.name;
    if (current == routeName) return;
    Navigator.pushReplacementNamed(context, routeName);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('username');
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_username ?? 'Pengguna'),
              accountEmail: const Text('NIM_Tugas7'),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () => _navigateTo(HomePage.routeName),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () => _navigateTo(AboutPage.routeName),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            )
          ],
        ),
      ),
    );
  }
}
