import 'package:flutter/gestures.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digital_id/all_export.dart';

class MyNestedScrollView extends StatefulWidget {
  final ScrollController? controller;
  final Axis scrollDirection = Axis.vertical;
  final bool reverse = false;
  final ScrollPhysics? physics;
  final List<Widget> Function(BuildContext, bool)? headerSliverBuilder;
  final Widget body;
  final DragStartBehavior dragStartBehavior = DragStartBehavior.start;
  final bool floatHeaderSlivers = false;
  final Clip clipBehavior = Clip.hardEdge;
  final String? restorationId;
  final ScrollBehavior? scrollBehavior;
  const MyNestedScrollView({
    Key? key,
    this.controller, this.physics, this.headerSliverBuilder, required this.body, this.restorationId, this.scrollBehavior,

  }) : super(key: key);

  @override
  State<MyNestedScrollView> createState() => _MyNestedScrollViewState();
}

class _MyNestedScrollViewState extends State<MyNestedScrollView> {

  DashBoardModel dashBoardM = DashBoardModel();
  
  Future pickImage(ImageSource source, String? label) async {

    final pickedFile = await ImagePicker.platform.pickImage(source: source);
    
    if (pickedFile != null){
      setState(() {
        if (label == 'cover'){
          dashBoardM.cover = pickedFile.path;
        } else {

          dashBoardM.profile = pickedFile.path;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background:  profileWidget(context, model: dashBoardM, pickImage: pickImage),
            ),
          ),
        ];
      },
      body: widget.body,
    );
  }
}