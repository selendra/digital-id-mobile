import 'package:flutter/material.dart';

class AssetListModel {
  String? title;
  String? balance;
  ImageProvider? image;

  AssetListModel({this.title, this.balance, this.image}); 

}

List<AssetListModel> assetList =  <AssetListModel>[  
  AssetListModel(title: 'RIEL', balance: '0.00', image: const AssetImage('assets/icons/riel_icon.png')),
  AssetListModel(title: 'BTC', balance: '0.00', image: const AssetImage('assets/icons/btc_icon.jpg')),
  AssetListModel(title: 'SEL', balance: '0.00', image: const AssetImage('assets/logos/sel.png')),
];