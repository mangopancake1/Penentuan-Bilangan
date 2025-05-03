part of 'shared.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: secondaryColor,
            ),
            child: const Text(
              'Menu Navigasi',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),

          // Halaman Utama
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Halaman Utama'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name == '/home') {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),

          // Penentuan Bilangan
          ListTile(
            leading: const Icon(Icons.filter_9_plus),
            title: const Text('Penentuan Bilangan'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name ==
                  '/Penentuan Bilangan') {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/Penentuan Bilangan');
              }
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              bool confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text('Apakah Anda yakin ingin logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );

              if (confirm) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('isLoggedIn'); // Hapus status login
                Navigator.pushReplacementNamed(
                    context, '/login'); // Arahkan ke halaman login
              }
            },
          ),
        ],
      ),
    );
  }
}
