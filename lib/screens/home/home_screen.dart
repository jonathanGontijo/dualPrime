import 'package:dual/common/custom_drawer/custom_drawer.dart';
import 'package:dual/models/home_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/section_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 128, 128, 128),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end:Alignment.bottomCenter
              )
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('Dual'),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.of(context).pushNamed('/order'),
                      icon: Icon(Icons.car_rental),
                    color: Colors.white,
                  ),
                ],
              ),
              Consumer<HomeManager>(
                  builder: (_, homeManager, __){
                    final List<Widget> children = homeManager.sections
                        .map<Widget>((section) {
                          switch(section.type){
                            case 'List':
                              return SectionList(section);
                            case 'Staggered':
                              return Container();
                            default:
                              return Container();
                          }

                    }).toList();

                    return SliverList(
                      delegate: SliverChildListDelegate(children),
                    );
                  },
              )
            ],
          ),
        ],
      ),
    );
  }
}
