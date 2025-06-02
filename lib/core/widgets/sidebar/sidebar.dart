import 'package:app_smart_wallet_ifpr/core/widgets/sidebar/sidebar_controller.dart';
import 'package:app_smart_wallet_ifpr/shared/constants/sidebar_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants/app_colors.dart';
import '../../routes/app_routes.dart';

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
          Positioned.fill(child: widget.child),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 56,
              color: AppColors.loginSecondary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  setState(() {
                    isSidebarVisible = !isSidebarVisible;
                  });
                },
              ),
            ),
          ),

          if (isSidebarVisible)
            Positioned(
              top: 56,
              bottom: 0,
              left: 0,
              width: 200,
              child: Container(
                color: AppColors.loginSecondary,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildMenuItem(
                            icon: Icons.home,
                            label: SidebarConstants.menuHome,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.home,
                              );
                            },
                          ),
                          _buildMenuItem(
                            icon: Icons.credit_card,
                            label: SidebarConstants.menuWallet,
                            onTap: () {
                              // TODO -> Criar componente
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.home,
                              );
                            },
                          ),
                          _buildMenuItem(
                            icon: Icons.credit_card,
                            label: SidebarConstants.requestWallet,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.requestWallet,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      label: SidebarConstants.logout,
                      onTap: () {
                        final sidebarController =
                            Provider.of<SidebarController>(
                              context,
                              listen: false,
                            );
                        sidebarController.logout();
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      },
                    ),
                  ],
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