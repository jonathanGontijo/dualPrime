import 'package:dual/common/custom_drawer/custom_drawer.dart';
import 'package:dual/models/casualty_manager.dart';
import 'package:dual/screens/casualties/components/casualty_list_tile.dart';
import 'package:dual/screens/casualties/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClasualtiesScreen extends StatelessWidget {
  const ClasualtiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<CasualtyManager>(
          builder: (_, casualtyManager, __){
            if (casualtyManager.search.isEmpty) {
              return const Text('Sinistros');
            }  else {
              return LayoutBuilder(
                  builder: (_, constraints){
                    return GestureDetector(
                        onTap: () async {
                          final search = await showDialog<String>(context: context,
                            builder: (_) => SearchDialog(
                              casualtyManager.search
                            ));
                      if (search != null) {
                        casualtyManager.search = search;
                      }
                    },
                      child: Container(
                        width: constraints.biggest.width,
                        child: Text(
                            casualtyManager.search,
                            textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
              );
            }
          },
        ),
        centerTitle: true,
        actions: [
          Consumer<CasualtyManager>(
              builder: (_, casualtyManager, __){
                if (casualtyManager.search.isEmpty) {
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(
                            casualtyManager.search
                          ));
                      if (search != null) {
                        casualtyManager.search = search;
                      }
                    },
                  );
                }  else {
                  return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: ()async{
                      casualtyManager.search= '';
                      },
                     );
                    }
                 },
          )
        ],
      ),
      body: Consumer<CasualtyManager>(
        builder: (_, casualtyManager, __){
          final filteredCasualty = casualtyManager.filteredCasualty;
          return ListView.builder(
            padding: EdgeInsets.all(4),
            itemCount: casualtyManager.filteredCasualty.length,
            itemBuilder: (_, index){
              return ListTile(
                title: CasualtyListTile(casualtyManager.filteredCasualty[index])
              );
          }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/order');
        },
        child: Icon(Icons.car_rental_sharp),
      ),
    );
  }
}
