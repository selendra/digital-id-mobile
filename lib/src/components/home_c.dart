import 'package:wallet_apps/index.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet_apps/src/screen/home/assets/assets.dart';
import 'package:wallet_apps/src/screen/home/discover/discover.dart';
import 'package:wallet_apps/src/screen/home/home/home.dart';
import 'package:wallet_apps/src/screen/home/swap/swap.dart';

const fontSizePort = 17.0;
const fontColorPort = Colors.white;

List<Color> _gradientColors = [
  hexaCodeToColor(AppColors.secondary),
  hexaCodeToColor("#00ff6b")
];

final portfolioChart = LineChartData(
  borderData: FlBorderData(show: false),
  gridData: FlGridData(
    show: false,
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: const Color(0xff37434d),
        strokeWidth: 0.3,
      );
    },
    getDrawingVerticalLine: (value) {
      return FlLine(
        color: const Color(0xff37434d),
        strokeWidth: 0.3,
      );
    },
  ),
  titlesData: FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      reservedSize: 6,
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return '';
          case 1:
            return '2h';
          case 2:
            return '4h';
          case 3:
            return '6h';
          case 4:
            return '8h';
          case 5:
            return '10h';
        }
        return '12h';
      },
      margin: 0,
    ),
    leftTitles: SideTitles(
      getTitles: (value) {
        switch (value.toInt()) {
          case 0:
            return '';
          case 1:
            return '50';
          case 2:
            return '100';
          case 3:
            return '150';
        }
        return '200';
      },
      reservedSize: 3,
      margin: 0,
    ),
  ),
  minX: 0,
  maxX: 6,
  minY: 0,
  maxY: 4,
  lineBarsData: [
    LineChartBarData(
      spots: [
        FlSpot(0, 0),
        FlSpot(0.5, 0.5),
        FlSpot(1, 1),
        FlSpot(1.5, 2),
        FlSpot(2, 2.5),
        FlSpot(2.5, 3),
        FlSpot(3, 3),
        FlSpot(3.5, 3),
        FlSpot(4, 4),
        FlSpot(4.5, 3.5),
        FlSpot(5, 2),
        FlSpot(5.5, 2),
        FlSpot(6, 1),
      ],
      isCurved: true,
      colors: _gradientColors,
      barWidth: 2.5,
      // isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
        colors: _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      ),
    ),
  ],
);

Widget homeAppBar(BuildContext context, {Function? query}) {
  final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
  return Container(
    height: 70,
    color: isDarkTheme
      ? hexaCodeToColor(AppColors.darkCard)
      : hexaCodeToColor(AppColors.whiteHexaColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          AppConfig.assetsPath+'bitriel_home.png',
          width: 170,
          height: 170,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            iconSize: 30,
            color: isDarkTheme ? Colors.white : Colors.black,
            icon: SvgPicture.asset(AppConfig.iconsPath+"list.svg"),
            onPressed: () async {
              await MyBottomSheet().listToken(context: context, query: query);
              // Navigator.push(
              //   context,
              //   RouteAnimation(
              //     enterPage: AddAsset(),
              //   ),
              // );
            },
          ),
        ),
      ],
    ),
  );
}

Widget cardToken(
  /* Card Token Display */
  String title,
  String tokenAmount,
  String rateColor,
  String greenColor,
  String rate,
  IconData rateIcon,
  double paddingeBottom6,
) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: hexaCodeToColor(AppColors.borderColor)),
        borderRadius: BorderRadius.circular(size5)),
    child: Padding(
      padding: const EdgeInsets.all(19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: paddingeBottom6),
            child: const Text("Most Active Token"),
          ),
          Container(
            margin: EdgeInsets.only(bottom: paddingeBottom6),
            child: Row(
              children: <Widget>[
                Container(
                  height: 38.0,
                  alignment: Alignment.center,
                  child: textDisplay(
                      /* Token number */
                      tokenAmount,
                      TextStyle(
                          color: hexaCodeToColor(AppColors.lightBlueSky),
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0)),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: paddingeBottom6, left: paddingeBottom6),
                  child: Text(
                    "Token",
                    style: TextStyle(color: hexaCodeToColor(greenColor)),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Icon(
                rateIcon,
                color: hexaCodeToColor(rateColor),
                size: 17.0,
              ),
              Text(
                rate,
                style: TextStyle(color: hexaCodeToColor(rateColor)),
              )
            ],
          )
        ],
      ),
    ),
  );
}

class AddAssetRowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, AddAsset.route);
      },
      child: rowDecorationStyle(
        child: Row(
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              margin: const EdgeInsets.only(right: 10.0),
              decoration: BoxDecoration(
                color: hexaCodeToColor(AppColors.secondary),
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(40.0),
              ),
              alignment: Alignment.center,
              child: const Icon(
                LineAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
            const Text(
              "Add asset",
              style: TextStyle(
                color: fontColorPort,
                fontSize: fontSizePort,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// /* Build Portfolio If Have List Of Portfolio */
// Widget buildRowList(
//     List<dynamic> portfolioData, int rate, CreateAccModel sdkModel) {
//   return ListView.builder(
//     shrinkWrap: true,
//     itemCount: 1,
//     physics: const BouncingScrollPhysics(),
//     itemBuilder: (BuildContext context, int index) {
//       return portFolioItemRow(portfolioData, index, rate, sdkModel);
//     },
//   );
// }

// Widget portFolioItemRow(
//     List<dynamic> portfolioData, int index, int rate, CreateAccModel sdkModel) {
//   return rowDecorationStyle(
//       child: Row(
//     children: <Widget>[
//       Container(
//         width: 50,
//         height: 50,
//         padding: const EdgeInsets.all(6),
//         margin: const EdgeInsets.only(right: 20),
//         decoration: BoxDecoration(
//             color: hexaCodeToColor(AppColors.secondary),
//             borderRadius: BorderRadius.circular(40)),
//         child: Image.asset('assets/koompi_white_logo.png'),
//       ),
//       Expanded(
//         child: Container(
//           margin: const EdgeInsets.only(right: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyText(
//                 text: sdkModel.contractModel.pTokenSymbol,
//                 color: "#FFFFFF",
//               ),
//               const MyText(text: ModelAsset.assetOrganization, fontSize: 15),
//             ],
//           ),
//         ),
//       ),
//       Expanded(
//         child: Container(
//           margin: const EdgeInsets.only(right: 16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               MyText(
//                   width: double.infinity,
//                   text: sdkModel.contractModel
//                       .pBalance, //portfolioData[0]["data"]['balance'],
//                   color: "#FFFFFF",
//                   textAlign: TextAlign.right,
//                   overflow: TextOverflow.ellipsis),
//             ],
//           ),
//         ),
//       ),
//     ],
//   ));
// }

// Portfolow Row Decoration
Widget rowDecorationStyle({Widget? child, double mTop = 0, double mBottom = 16}) {
  return Container(
    margin: EdgeInsets.only(top: mTop, left: 16, right: 16, bottom: 16),
    padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
    height: 90,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
            color: Colors.black12, blurRadius: 2.0, offset: Offset(1.0, 1.0))
      ],
      color: hexaCodeToColor(AppColors.whiteHexaColor),
      borderRadius: BorderRadius.circular(8),
    ),
    child: child,
  );
}

class MyBottomAppBar extends StatelessWidget {

  final int? index;
  final bool? apiStatus;
  final HomeModel? homeM;
  final Function? scanReceipt;
  final Function? toReceiveToken;
  final Function? fillAddress;
  final Function? contactPiker;
  final void Function()? openDrawer;
  final void Function(int index)? onIndexChanged;
  final double iconSize = 7.w;

  MyBottomAppBar({
    required this.index,
    this.apiStatus,
    this.homeM,
    this.scanReceipt,
    this.toReceiveToken,
    this.fillAddress,
    this.contactPiker,
    this.openDrawer,
    this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
    return BottomAppBar(
      color: Colors.white,
      // isDarkTheme
      //   ? hexaCodeToColor(AppColors.darkBgd)
      //   : hexaCodeToColor(AppColors.whiteHexaColor),
      // shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 9.5.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            // Expanded(
            //   child: MyIconButton(
            //     child: Icon(Iconsax.discover_1, size: iconSize, color: index == 0 ? Colors.white : hexaCodeToColor(AppColors.iconColor)),
            //     title: "Discover",
            //     txtColor: index == 0 ? AppColors.whiteColorHexa : AppColors.iconColor,
            //     onPressed: () {
            //       // Navigator.push(context, RouteAnimation(enterPage: DiscoverPage()));
            //       onIndexChanged!(0);
            //     }
            //   ),
            // ),
            Expanded(
              child: MyIconButton(
                child: Icon(Iconsax.wallet_check, size: iconSize, color: hexaCodeToColor(index == 0 ? AppColors.primary : AppColors.greyCode)),
                title: "Wallet",
                txtColor: index == 0 ? AppColors.primary : AppColors.greyCode,
                isActive: index == 0 ? true : false,
                onPressed: () {
                  onIndexChanged!(0);
                  // Navigator.push(context, RouteAnimation(enterPage: AssetsPage()));
                }
              ),
            ),

            Expanded(
              child: MyIconButton(
                child: Icon(Iconsax.home, size: iconSize, color: hexaCodeToColor(index == 1 ? AppColors.primary : AppColors.greyCode)),
                title: "Docs",
                txtColor: index == 1 ? AppColors.primary : AppColors.greyCode,
                isActive: index == 1 ? true : false,
                onPressed: () {
                  // Navigator.push(context, RouteAnimation(enterPage: HomePage()));
                  onIndexChanged!(1);
                }
              ),
            ),

            // Expanded(
            //   child: MyIconButton(
            //     child: Icon(Iconsax.card_coin, size: iconSize, color: index == 3 ? Colors.white : hexaCodeToColor(AppColors.iconColor)),
            //     title: "Swap",
            //     txtColor: index == 3 ? AppColors.whiteColorHexa : AppColors.iconColor,
            //     onPressed: () {
            //       onIndexChanged!(3);
            //     }
            //   ),
            // ),

            Expanded(
              child: MyIconButton(
                child: Icon(Iconsax.setting, size: iconSize, color: hexaCodeToColor(index == 2 ? AppColors.primary : AppColors.greyCode)),
                title: "Account",
                txtColor: index == 2 ? AppColors.primary : AppColors.greyCode ,
                isActive: index == 2 ? true : false,
                onPressed: () {
                  onIndexChanged!(2);
                }
              ),
            ),

          ],
        ),
      ),
    );
    // Container(
    //   color: isDarkTheme ? hexaCodeToColor(AppColors.darkBgd):  hexaCodeToColor(AppColors.whiteColorHexa),
    //   child: ,
    // );
  }
}

Widget fabsButton(
  { Animation? degOneTranslationAnimation,
    IconData? icon,
    Duration? duration,
    bool? visible,
    double? radien,
    double? distance,
    void Function()? onPressed}) {
  return AnimatedOpacity(
    duration: duration!,
    opacity: visible! ? 1.0 : 0.0,
    child: Transform.translate(
      offset: Offset.fromDirection(AppServices.getRadienFromDegree(radien!),
          double.parse(degOneTranslationAnimation!.value.toString()) * distance!),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    ),
  );
}

class MyHomeAppBar extends StatelessWidget {
  final double? pLeft;
  final double? pTop;
  final double? pRight;
  final double? pBottom;
  final EdgeInsetsGeometry? margin;
  final String? title;

  final Function? action;

  const MyHomeAppBar({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.margin = const EdgeInsets.fromLTRB(0, 12, 0, 0),
    @required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      margin: margin,
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        children: [
          MyLogo(
            width: 50,
            height: 50,
            logoPath: AppConfig.assetsPath+"sld_logo.svg",
          ),
          MyText(
            color: "#FFFFFF",
            text: title,
            left: 15,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  action!();
                },
                child: const Icon(
                  LineAwesomeIcons.bell,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

LineChartData mainData() {
  return LineChartData(
    borderData: FlBorderData(show: false),
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      drawHorizontalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 0.3,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 0.3,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 6,
        getTextStyles: (context, value) => const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '';
            case 1:
              return '2h';
            case 2:
              return '4h';
            case 3:
              return '6h';
            case 4:
              return '8h';
            case 5:
              return '10h';
          }
          return '';
        },
        margin: 0,
      ),
      leftTitles: SideTitles(
        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return '';
            case 1:
              return '50';
            case 2:
              return '100';
            case 3:
              return '150';
          }
          return '200';
        },
        reservedSize: 3,
        margin: 0,
      ),
    ),
    // borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 6,
    minY: 0,
    maxY: 4,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(0.5, 2.5),
          FlSpot(1, 1),
          FlSpot(1.5, 2),
          FlSpot(2, 2.5),
          FlSpot(2.5, 3),
          FlSpot(3, 3),
          FlSpot(3.5, 3),
          FlSpot(4, 2),
          FlSpot(4.5, 3.5),
          FlSpot(5, 2),
          FlSpot(5.5, 2),
          FlSpot(6, 1),
        ],
        isCurved: true,
        colors: _gradientColors,
        barWidth: 3,
        // isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors:
              _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );
}