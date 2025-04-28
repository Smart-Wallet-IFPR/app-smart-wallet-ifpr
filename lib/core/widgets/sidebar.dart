import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Widget child;

  const Sidebar({super.key, required this.child});

  @override
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  bool isSidebarVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.child,
          ),
          if (isSidebarVisible)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: 200,
              child: Container(
                color: Colors.blueGrey[900],
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            isSidebarVisible = false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMenuItem(
                            icon: Icons.home,
                            label: "Home",
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                          ),
                          _buildMenuItem(
                            icon: Icons.person,
                            label: "Perfil",
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/profile');
                            },
                          ),
                          _buildMenuItem(
                            icon: Icons.settings,
                            label: "Configurações",
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/settings');
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      label: "Sair",
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            top: 16,
            left: 16,
            child: Visibility(
              visible: !isSidebarVisible,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.blueGrey[900],
                onPressed: () {
                  setState(() {
                    isSidebarVisible = true;
                  });
                },
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}