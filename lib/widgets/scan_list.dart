import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/scan_provider.dart';

class ScanList extends StatelessWidget {

  final String type;

 const ScanList({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    final scans = scanProvider.scans;

    if (scans.isEmpty) {
      return Center(
        child: Text('Toque el botón para escanear un código QR', style: TextStyle(color: Colors.blue, fontSize: 18),),
      );
    }

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) => Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction){
            Provider.of<ScanProvider>(context, listen: false).deleteScanForId(scans[index].id!);
          },
          child: ListTile(
            leading: Icon(
                type == 'http'
                ? Icons.home_outlined
                : Icons.map_outlined,
                color: Theme.of(context).primaryColor),
            title: Text(scans[index].value),
            subtitle: Text(scans[index].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: () => launchUrls(context, scans[index]),
          ),
        )
    );
  }
}
