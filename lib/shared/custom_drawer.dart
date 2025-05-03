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
              color: secondaryColor, // Sesuaikan warna tema
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

          // Ganjil / Genap
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
        ],
      ),
    );
  }
}
