import 'package:carousel_slider/carousel_options.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/home/home/body_home.dart';
import 'package:web3dart/web3dart.dart';

class HomePage1 extends StatefulWidget {

  static final String route = "/home";

  const HomePage1({ Key? key }) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  
  HomePageModel _model = HomePageModel();

  ContractProvider? _contractProvider;

  @override
  void initState() {
    super.initState();
    
    _model.pageController!.addListener(() {
      if(_model.activeIndex != _model.pageController){
        setState(() {
          _model.activeIndex = _model.pageController!.page!.toInt();
        });
      }
    });

    _model.activeIndex = 2;
    _model.carouActiveIndex = 0;
    _model.globalKey = GlobalKey<ScaffoldState>();
    _model.onCarouselChanged = (int index, CarouselPageChangedReason reason) {
      setState(() {
        this._model.carouActiveIndex = index;
      });
    };
    _contractProvider = Provider.of<ContractProvider>(context, listen: false);
  }
  


  void onPageChanged(int index){
    setState(() {
      _model.activeIndex = index;
    });
    _model.pageController!.jumpToPage(index);
    // _model.pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  final bool? pushReplacement = true;
  
  @override
  Widget build(BuildContext context) {
    return HomePageBody(
      homePageModel: _model,
      onPageChanged: onPageChanged,
      pushReplacement: pushReplacement
    );
  }
}