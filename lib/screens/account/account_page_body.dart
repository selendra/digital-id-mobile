import 'package:digital_id/all_export.dart';
import 'package:digital_id/models/dashboard_m.dart';

class AccountPageBody extends StatelessWidget {
  const AccountPageBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: MyNestedScrollView(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                DashboardOptions(),
                LinkedAccountInfo()
              ],
            ),
          ),
        ),
      ),
    );
  }
}