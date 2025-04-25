import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  //Metodo para agregar scan
  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.createScan(newScan);
    // Asignar el ID de la base de datos al modelo
    newScan.id = id;

    if (selectedType == newScan.type) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  // Metodo para cargar todos los scans
  Future<void> loadScans() async {
    final scansDB = await DBProvider.db.getAllScans();
    //Llena la lista con los valores que vienen de la base de datos
    scans = [...?scansDB];
    notifyListeners();
  }

  // Metodo para cargar scan por tipo
  Future<void> loadScanForType(String type) async {
    final scansDB = await DBProvider.db.getScansForType(type);
    scans = [...?scansDB];
    selectedType = type;
    notifyListeners();
  }

  //Metodo para eliminar todos los scans
  Future<void> deleteAll() async {
    await DBProvider.db.deleteAllScan();
    scans = [];
    notifyListeners();
  }

  //Metodo eliminar scan por id
  Future<void> deleteScanForId(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}
