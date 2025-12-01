## NIM_Tugas7 – Dokumentasi Proyek

Proyek ini adalah aplikasi Flutter sederhana yang mengimplementasikan:

- **Routing (Named Routes)**
- **Side Menu (Drawer)**
- **Halaman Login**
- **Penyimpanan Lokal (SharedPreferences)**

Aplikasi dibuat sebagai tugas praktikum Flutter dengan nama proyek konseptual **`NIM_Tugas7`**.

---

## Fitur Utama

- **Splash Screen Otomatis**
  - Mengecek apakah user sudah login atau belum menggunakan `SharedPreferences` (kunci `isLoggedIn`).
  - Jika sudah login → langsung diarahkan ke **Home**.
  - Jika belum login → diarahkan ke **Login Page**.

- **Login dengan Penyimpanan Lokal**
  - Form login dengan validasi sederhana (username dan password wajib diisi).
  - Kredensial default: **username: `admin`**, **password: `admin`**.
  - Saat login berhasil:
    - Menyimpan `username` dan status `isLoggedIn = true` ke `SharedPreferences`.
    - Berpindah ke halaman **Home** menggunakan **named route**.
  - Username terakhir akan otomatis dimuat ke field input saat membuka login lagi.

- **Home Page dengan Side Menu**
  - Membaca `username` dari `SharedPreferences` dan menampilkan sapaan seperti:  
    _"Selamat datang, {username}!"_.
  - Memiliki **Drawer (Side Menu)** yang berisi:
    - Navigasi ke **Home**.
    - Navigasi ke **About**.
    - Tombol **Logout** (menghapus data login dan kembali ke halaman Login).

- **About Page**
  - Menjelaskan secara singkat tujuan dan fitur dari aplikasi.
  - Tetap menggunakan **Side Menu** untuk konsistensi navigasi.

---

## Struktur Halaman & Routing

- **`lib/main.dart`**
  - Menjadi entry point aplikasi dan mendefinisikan konfigurasi `MaterialApp`.
  - Mengatur:
    - `title` aplikasi (`NIM_Tugas7`).
    - `theme` (warna tema dan penggunaan Material 3).
    - `initialRoute` → `SplashPage.routeName` (`'/'`).
    - `routes` untuk:
      - `SplashPage` (`'/'`)
      - `LoginPage` (`'/login'`)
      - `HomePage` (`'/home'`)
      - `AboutPage` (`'/about'`)

- **`lib/splash_page.dart`**
  - Halaman pertama yang dijalankan.
  - Tugasnya:
    - Mengambil instance `SharedPreferences`.
    - Membaca nilai `isLoggedIn` (tipe `bool`, default `false`).  
    - Menentukan route tujuan:
      - `true` → `HomePage.routeName`
      - `false` → `LoginPage.routeName`
    - Menggunakan `Navigator.pushNamedAndRemoveUntil` supaya splash tidak bisa di-`back` lagi.

- **`lib/login_page.dart`**
  - Menyediakan UI form login dengan dua `TextFormField`:
    - `username`
    - `password` (disembunyikan dengan `obscureText: true`)
  - Menggunakan `Form` + `GlobalKey<FormState>` untuk validasi:
    - Field tidak boleh kosong.
  - Logika login:
    - Cek apakah username & password adalah `'admin'`.
    - Jika **benar**:
      - Simpan `username` dan `isLoggedIn = true` ke `SharedPreferences`.
      - Navigasi ke `HomePage` menggunakan `Navigator.pushNamedAndRemoveUntil`.
    - Jika **salah**:
      - Menampilkan `SnackBar` berisi pesan error.
  - Memuat ulang `username` terakhir yang tersimpan di `SharedPreferences` saat `initState`.

- **`lib/home_page.dart`**
  - `StatefulWidget` yang mewakili halaman utama setelah login.
  - Di `initState`, memanggil fungsi `_loadUsername()`:
    - Mengambil `username` dari `SharedPreferences` (default `'Pengguna'`).
    - Menyimpan ke variabel lokal state `_username` dan mengganti status `_isLoading` menjadi `false`.
  - Menampilkan:
    - Loading indicator jika `_isLoading == true`.
    - Teks sapaan jika data sudah dimuat.
  - Menyertakan `SideMenu` melalui properti `drawer`.

- **`lib/sidemenu.dart`**
  - Mengimplementasikan **Drawer** berbasis `UserAccountsDrawerHeader` dan beberapa `ListTile`.
  - Menampilkan:
    - Nama user (`username`) yang diteruskan dari `HomePage` atau diambil lagi dari `SharedPreferences`.
  - Fungsi penting:
    - `_navigateTo(routeName)`  
      - Menutup drawer, membaca route saat ini, dan hanya berpindah jika route tujuan berbeda (menghindari reload tidak perlu).
    - `_logout()`  
      - Menghapus `isLoggedIn` dan `username` dari `SharedPreferences`.
      - Menavigasi ke `LoginPage` dengan menghapus seluruh route stack.

- **`lib/about_page.dart`**
  - `StatelessWidget` yang hanya menampilkan informasi statis tentang aplikasi dan fitur-fitur yang diimplementasikan.
  - Tetap menggunakan `SideMenu` agar pola navigasi konsisten di seluruh halaman utama.

---

## Penyimpanan Lokal (SharedPreferences)

Penyimpanan lokal digunakan untuk dua hal utama:

- **Menyimpan status login**
  - Kunci: `isLoggedIn` (`bool`)
  - Digunakan di:
    - `SplashPage` → menentukan apakah langsung ke `Home` atau `Login`.
    - `SideMenu.logout()` → dihapus saat user logout.

- **Menyimpan username terakhir**
  - Kunci: `username` (`String`)
  - Digunakan di:
    - `LoginPage` → mengisi otomatis field username.
    - `HomePage` → menampilkan sapaan kepada user.
    - `SideMenu` → menampilkan nama di header akun.

---

## Cara Menjalankan Proyek

1. Pastikan Flutter sudah terpasang dan terkonfigurasi (`flutter doctor`).
2. Jalankan perintah berikut di folder proyek:

   ```bash
   flutter pub get
   flutter run
   ```

3. Masuk menggunakan kredensial:
   - **Username**: `admin`
   - **Password**: `admin`

---

## Catatan Pengembangan

- Proyek ini menggunakan:
  - **Named routes** untuk navigasi yang lebih terstruktur.
  - **Material 3** (`useMaterial3: true`) untuk tampilan modern.
  - **`shared_preferences`** versi `^2.0.17` (lihat `pubspec.yaml`).  
- Flow aplikasi:
  1. `SplashPage` → cek login.
  2. Jika belum login → `LoginPage`.
  3. Login sukses → simpan ke `SharedPreferences` → `HomePage`.
  4. Dari `SideMenu` user dapat:
     - Pindah ke `AboutPage`.
     - Logout dan kembali ke `LoginPage`.
