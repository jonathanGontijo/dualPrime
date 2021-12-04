import 'package:dual/common/custom_drawer/custom_drawer_header.dart';
import 'package:dual/common/custom_drawer/drawer_tile.dart';
import 'package:dual/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                 Color.fromARGB(255, 128, 128, 128),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              Divider(),
              DrawerTile(iconData: Icons.home, title: 'Início', page: 0,),
              DrawerTile(iconData: Icons.list, title: 'Benefícios',page: 1,),
              DrawerTile(iconData: Icons.playlist_add_check, title: 'Sinistros',page: 2,),
              DrawerTile(iconData: Icons.location_on, title: 'Meus Chamados',page: 3,),
              DrawerTile(iconData: Icons.perm_device_information, title: 'Informações',page: 4,),
              Consumer<UserManager>(
                  builder: (_, userManager, __) {
                    if (userManager.adminEnable) {
                      return Column(
                        children: [
                          Divider(),
                          DrawerTile(iconData: Icons.settings, title: 'Usuários', page: 5,),
                          DrawerTile(iconData: Icons.settings, title: 'Serviços', page: 6,),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
              )
            ],
          ),
        ]
      ),
    );
  }
}
