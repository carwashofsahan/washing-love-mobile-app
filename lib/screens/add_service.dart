import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/packages.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/screens/add_package.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_theme.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';

// add service page
class AddServicePage extends StatefulWidget {
  final WashCenter washCenter;
  AddServicePage({this.washCenter});
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final totalrateController = TextEditingController();
  final totalslotController = TextEditingController();

  List<Packages> packages = [];

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    totalrateController.dispose();
    totalslotController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var packagesRes = await CallApi(context).getPackagesByUserId();

    if (packagesRes.length <= 0) {
      EasyLoading.showToast('No packages added. Please add package first.',
          toastPosition: EasyLoadingToastPosition.bottom);
      // Navigator.of(context).pop();
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => AddPackagePage()));
    } else {
      setState(() {
        packages = packagesRes;

        if (widget.washCenter != null) {
          nameController.text = widget.washCenter.name;
          cityController.text = widget.washCenter.city;
          totalrateController.text = widget.washCenter.totalRate.toString();
          totalslotController.text = widget.washCenter.totalSlot.toString();

          widget.washCenter.packages.forEach((element) {
            packages.where((ele) => ele.id == element.id).first.selected = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildForm() {
      return Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 20,
          children: [
            TextFormFieldNormalUtils(
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              textLabel: "Name",
              controller: nameController,
              isPhonekey: false,
            ),
            TextFormFieldNormalUtils(
              validator: (suburb) {
                if (suburb == null || suburb.isEmpty) {
                  return 'City is required';
                }
                return null;
              },
              textLabel: "City",
              controller: cityController,
              isPhonekey: false,
            ),
            TextFormFieldNormalUtils(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Total Rate is required';
                }
                return null;
              },
              textLabel: "Total Rate",
              controller: totalrateController,
              isPhonekey: true,
            ),
            TextFormFieldNormalUtils(
              validator: (suburb) {
                if (suburb == null || suburb.isEmpty) {
                  return 'Total slot is required';
                }
                return null;
              },
              textLabel: "Total slot",
              controller: totalslotController,
              isPhonekey: true,
            ),
            packages.length <= 0
                ? Column(
                    children: [
                      Center(
                        child: Text(
                          'No packages added. Please add package first.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddPackagePage()));
                            },
                            color: AppColors.color('FFD54F'),
                            child: Container(
                              width: double.infinity,
                              height: 25,
                              child: Text(
                                ' + Add Package',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      )
                    ],
                  )
                : Container(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: packages.map((Packages packageVar) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              packageVar.selected = !packageVar.selected;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 10.0),
                            padding: EdgeInsets.all(2.0),
                            width: 260,
                            decoration: BoxDecoration(
                                color: packageVar.selected
                                    ? Theme.of(context).accentColor
                                    : Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(
                                      left: 3.0,
                                      top: 3.0,
                                      bottom: 3.0,
                                      right: 10.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://img.lovepik.com/element/40174/3494.png_860.png'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Container(
                                  width: 140,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: 130,
                                          child: Text(packageVar.description)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.attach_money_outlined,
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('Rs: ${packageVar.price}',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.file_copy_sharp,
                                                  size: 12,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text('${packageVar.type.type}',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )),
            AuthButtonUtils(
              btnText: widget.washCenter != null ? 'update' : 'Add',
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (widget.washCenter != null)
                    _update();
                  else
                    _add();
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Add service'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Logo(),
              SizedBox(
                height: 40,
              ),
              _buildForm()
            ],
          ),
        ),
      ),
    );
  }

  void _add() async {
    var pckgs = packages.where((element) => element.selected).toList();
    await CallApi(context).addDetailer(
        nameController.text.toString(),
        cityController.text.toString(),
        totalrateController.text.toString(),
        totalslotController.text.toString(),
        pckgs);
  }

  void _update() async {
    var pckgs = packages.where((element) => element.selected).toList();
    await CallApi(context).updateDetailer(
        nameController.text.toString(),
        cityController.text.toString(),
        totalrateController.text.toString(),
        totalslotController.text.toString(),
        pckgs,
        widget.washCenter.id);
  }
}
