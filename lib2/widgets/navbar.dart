import 'package:flutter/material.dart';
import 'package:digital_id/all_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_id/core/config/app_config.dart';
class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar>
{
  
  int _selectedIndex = 0;

  static const List<Widget> _options  = <Widget> [
    // DashboardPage(),
    // AccountPage(),
    // CryptosPage(),
    // StoragesPage(),
    // ToolsPage(),
  ];

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final double iconSize = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: HexColor('#FFFFFF'),
          border: Border(top: BorderSide(color: HexColor('#E0E0E0'), width: 1.0))
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppConfig.iconPath+"profile.svg", width: iconSize, height: iconSize,),
              activeIcon: SvgPicture.asset(AppConfig.iconPath+"profile.svg", width: iconSize + 5, height: iconSize + 5, color: Colors.blue,),
              label: 'Profile',
              backgroundColor: HexColor('#FFFFFF'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppConfig.iconPath+"account.svg", width: iconSize, height: iconSize),
              activeIcon: SvgPicture.asset(AppConfig.iconPath+"account.svg", width: iconSize + 5, height: iconSize + 5, color: Colors.blue,),
              label: 'Account',
              backgroundColor: HexColor('#FFFFFF'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppConfig.iconPath+"crypto.svg", width: iconSize, height: iconSize),
              activeIcon: SvgPicture.asset(AppConfig.iconPath+"crypto.svg", width: iconSize + 5, height: iconSize + 5, color: Colors.blue,),
              label: 'Cryptos',
              backgroundColor: HexColor('#FFFFFF'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppConfig.iconPath+"storage.svg", width: iconSize, height: iconSize),
              activeIcon: SvgPicture.asset(AppConfig.iconPath+"storage.svg", width: iconSize + 5, height: iconSize + 5, color: Colors.blue,),
              label: 'Storages',
              backgroundColor: HexColor('#FFFFFF'),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(AppConfig.iconPath+"tool.svg", width: iconSize, height: iconSize),
              activeIcon: SvgPicture.asset(AppConfig.iconPath+"tool.svg", width: iconSize + 5, height: iconSize + 5, color: Colors.blue,),
              label: 'Tools',
              backgroundColor: HexColor('#FFFFFF'),
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black,
          iconSize: 30,
          onTap: _onItemTap,
          elevation: 5,
        ),
      ),
    );
  }
}