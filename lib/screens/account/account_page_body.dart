import 'package:digital_id/all_export.dart';
import 'package:digital_id/models/dashboard_m.dart';

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              profileWidget(context, pickImage: (){}, model: DashBoardModel()),
              const DashboardOptions(),
              const LinkedAccountInfo()
            ],
          ),
        ),
      ),
    );
  }
}