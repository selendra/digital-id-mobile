import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/components/component.dart';
import 'package:wallet_apps/src/components/custom_button_c.dart';
import 'package:wallet_apps/src/models/document_schema.dart';
import 'package:wallet_apps/src/models/kyc_content_m.dart';
import 'package:wallet_apps/src/provider/documents_p.dart';
import 'package:wallet_apps/theme/color.dart';

class SetUpKYCBody extends StatelessWidget {

  final bool? isShowMorePopularDocs;
  final bool? isShowMoreIssuer;
  final Function? onShowMorePopularDocs;
  final Function? onShowMoreIssuer;

  const SetUpKYCBody({
    Key? key,
    this.isShowMorePopularDocs,
    this.isShowMoreIssuer,
    this.onShowMorePopularDocs,
    this.onShowMoreIssuer
  }) : super(key: key);

  final double titleSize = 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left_2,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: MyText(
          textAlign: TextAlign.left,
          text: "Documents Type",
          fontSize: 18,
          color: AppColors.newText,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Consumer<DocumentProvider>(
        builder: (context, provider, widget){
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: paddingSize),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.lsDocs!.length,
                  itemBuilder: (context, index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: paddingSize, right: paddingSize, bottom: paddingSize),
                          child: MyText(
                            text: provider.lsDocs![index].type,
                            fontSize: titleSize,
                            fontWeight: FontWeight.bold,
                            color: AppColors.newText,
                          ),
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: provider.lsDocs![index].docsList!.length,
                          itemBuilder: (context, j){
                            return docsCardComponent(context, provider.lsDocs![index].docsList![j], provider.lsDocs![index].docsProperty!);
                          }
                        ),
                      ],
                    );
                  },
                ),
          
              ],
            ),
          );
        },
      ),
    );
  }

  Widget docsCardComponent(BuildContext context, Map<String, dynamic> doc, List<dynamic> docsProperty) {
    final _random = Random();
    return GestureDetector(
      onTap: () async{
        Provider.of<DocumentProvider>(context, listen: false).title = 'National ID';
        MyBottomSheet().createIDBottomSheet(context, docsProperty);
      },
      child: Padding(
        padding: EdgeInsets.only(left: paddingSize, right: paddingSize, bottom: paddingSize),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // color: hexaCodeToColor(AppColors.blue),
              color: hexaCodeToColor(doc['color'])//Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
            ),
            padding: EdgeInsets.only(top: 1, bottom: 5, left: 1, right: 1,),
            // Data Inside Card
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: hexaCodeToColor(AppColors.newCard),
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: paddingSize+5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  // MyText(text: [_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100].toString()),
                  
                  SizedBox(
                    height: 50,
                    child: doc['image'].contains("http") ? Image.network(doc['image']) : SvgPicture.asset(doc['image']),
                  ),
                  MyText(
                    top: 2.h,
                    text: doc['title'],
                    fontSize: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}