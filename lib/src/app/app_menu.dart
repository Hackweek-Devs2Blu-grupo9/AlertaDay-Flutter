import 'package:flutter/material.dart';
import 'package:alertaday/src/app/app_routes.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  Widget _buildListTile(
    BuildContext context,
    IconData icon,
    String title,
    String route, {
    bool replace = false,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        final currentRoute = ModalRoute.of(context)?.settings.name;
        if (currentRoute == route) return;
        if (replace) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('AlertaDay'),
              accountEmail: Text('adm@alertaday.app'),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.notifications)),
            ),
            _buildListTile(context, Icons.home, 'Home', AppRoutes.home, replace: true),
            _buildListTile(context, Icons.radar, 'alerta', AppRoutes.alertlistpage),
            _buildListTile(context, Icons.settings, 'Configurações', AppRoutes.settings),
            _buildListTile(context, Icons.event_available_sharp, 'Avaliação', AppRoutes.avaliacao),
            _buildListTile(context, Icons.info, 'Sobre', AppRoutes.about),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Fechar'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}