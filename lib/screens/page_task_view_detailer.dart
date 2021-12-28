import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/utils/page_task_detailer.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_bottom_nav_bar.dart';

// jobs page detailer
class HistoryPageDetailer extends StatefulWidget {
  final User user;
  final String token;
  HistoryPageDetailer({@required this.user, @required this.token});
  @override
  _HistoryPageDetailerState createState() =>
      _HistoryPageDetailerState(user, token);
}

class _HistoryPageDetailerState extends State<HistoryPageDetailer>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final User user;
  final String token;
  bool isDetailer = false;
  bool loadData = false;

  _HistoryPageDetailerState(this.user, this.token);
  buildTab(String name) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      child: Center(child: Text(name)),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
    tabController = TabController(length: 2, vsync: this);
    setState(() {
      tabController.index;
    });
  }

  getData() async {
    bool isDetailerRes = await CallApi(context).isDetailer();

    setState(() {
      isDetailer = isDetailerRes;
      loadData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationUtils(
          initValue: 1,
          user: user,
          token: token,
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(72),
          child: AppBarCommonUtils('Jobs'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: TaskPageDetailer(),
        ));
  }
}
