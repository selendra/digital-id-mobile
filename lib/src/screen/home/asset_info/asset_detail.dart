import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../index.dart';

class AssetDetail extends StatefulWidget {
  final Market marketData;
  const AssetDetail(this.marketData);

  @override
  _AssetDetailState createState() => _AssetDetailState();
}

class _AssetDetailState extends State<AssetDetail> {
  String totalSupply = '';

  String circulatingSupply = '';

  String marketCap = '';

  String marketCapChange24h = '';

  String convert(String? supply) {
    var formatter = NumberFormat.decimalPattern();

    if (supply != null) {
      if (supply.contains('.')) {
        var value = supply.replaceFirst(RegExp(r"\.[^]*"), "");
        return formatter.format(int.parse(value));
      }
    }

    return formatter.format(int.parse(supply!));
  }

  @override
  void initState() {
    if (widget.marketData.totalSupply != 'null') {
      totalSupply = convert(widget.marketData.totalSupply!);
    }
    if (widget.marketData.circulatingSupply != 'null') {
      circulatingSupply = convert(widget.marketData.circulatingSupply!);
    }

    if (widget.marketData.marketCap != 'null') {
      marketCap = convert(widget.marketData.marketCap!);
    }

    if (widget.marketData.marketCapChange24H != 'null') {
      marketCapChange24h = convert(widget.marketData.marketCapChange24H!);
    }
    // totalSupply = convert(widget.marketData.totalSupply);
    // circulatingSupply = convert(widget.marketData.circulatingSupply);
    // marketCap = convert(widget.marketData.marketCap);
    // marketCapChange24h = convert(widget.marketData.marketCapChange24H);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).isDark;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: 'Price Today',
              textAlign: TextAlign.left,
              fontWeight: FontWeight.bold,
              top: 16.0,
              bottom: 16.0,
              color:
                  isDarkTheme ? AppColors.whiteColorHexa : AppColors.textColor,
            ),
            line(),
            textRow('Price', '\$${widget.marketData.currentPrice}', ''),
            line(),
            textRow(
                'Price Change 24h',
                '\$${widget.marketData.priceChange24H} ',
                ' ${widget.marketData.priceChangePercentage24H}%'),
            line(),
            textRow(
                '24h Low / 24 High',
                '\$${widget.marketData.low24H} / \$${widget.marketData.high24H}',
                ''),
            line(),
            textRow('Market Rank', '#${widget.marketData.marketCapRank}', ''),
            line(),
            MyText(
              text: 'Market Cap',
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              top: 16,
              bottom: 16.0,
              color:
                  isDarkTheme ? AppColors.whiteColorHexa : AppColors.textColor,
            ),
            line(),
            textRow('Market Cap', '\$$marketCap', ''),
            line(),
            textRow('Market Cap Change 24h', '\$$marketCapChange24h', ''),
            line(),
            MyText(
              text: 'Price History',
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              top: 16.0,
              bottom: 16.0,
              color:
                  isDarkTheme ? AppColors.whiteColorHexa : AppColors.textColor,
            ),
            line(),
            textRow('All Time High', '\$${widget.marketData.ath}', ''),
            line(),
            textRow('All Time Low', '\$${widget.marketData.atl}', ''),
            line(),
            MyText(
              text: 'Supply',
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.left,
              top: 16.0,
              bottom: 16.0,
              color:
                  isDarkTheme ? AppColors.whiteColorHexa : AppColors.textColor,
            ),
            line(),
            textRow(
                'Circulating Supply',
                '$circulatingSupply ${widget.marketData.symbol!.toUpperCase()}',
                ''),
            line(),
            textRow('Total Supply',
                '$totalSupply ${widget.marketData.symbol!.toUpperCase()}', ''),
          ],
        ),
      ),
    );
  }

  Widget line() {
    final isDarkTheme =
        Provider.of<ThemeProvider>(context, listen: false).isDark;
    return Container(
      height: 1,
      color: isDarkTheme
          ? hexaCodeToColor(AppColors.titleAssetColor)
          : hexaCodeToColor(AppColors.textColor),
    );
  }

  Widget textRow(String leadingText, String trailingText, String endingText) {
    final isDarkTheme =
        Provider.of<ThemeProvider>(context, listen: false).isDark;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            text: leadingText,
            color: isDarkTheme ? AppColors.whiteColorHexa : AppColors.textColor,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              MyText(
                text: trailingText,
                color: isDarkTheme
                    ? AppColors.whiteColorHexa
                    : AppColors.textColor,
                overflow: TextOverflow.ellipsis,
              ),
              MyText(
                text: endingText,
                color: endingText != '' && endingText.substring(1, 2) == '-'
                    ? '#FF0000'
                    : isDarkTheme
                        ? '#00FF00'
                        : '#66CD00',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
