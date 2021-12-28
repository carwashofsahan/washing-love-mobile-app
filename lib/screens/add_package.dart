import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/vehicle_type.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';

// add packages page
class AddPackagePage extends StatefulWidget {
  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}

class _AddPackagePageState extends State<AddPackagePage> {
  final _formKey = GlobalKey<FormState>();

  final vehicleTypeController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final totalslotController = TextEditingController();

  VehicleType vehicleType;
  List<VehicleType> vehicleTypes = [];

  @override
  void dispose() {
    vehicleTypeController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    totalslotController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    var vehicleTypeRes = await CallApi(context).getVehicleTypes();
    setState(() {
      vehicleTypes = vehicleTypeRes;
      vehicleType = vehicleTypes[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildForm() {
      return Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 20,
          children: [
            DropdownButton<VehicleType>(
              value: vehicleType,
              elevation: 0,
              style: TextStyle(color: Colors.black),
              underline: SizedBox(),
              icon: Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: Colors.black,
              ),
              items: vehicleTypes
                  .map<DropdownMenuItem<VehicleType>>((VehicleType value) {
                return DropdownMenuItem<VehicleType>(
                  value: value,
                  child: Text(value.type),
                );
              }).toList(),
              hint: Text(
                "Vehicle Type",
              ),
              onChanged: (VehicleType value) {
                setState(() {
                  vehicleType = value;
                });
              },
            ),
            TextFormFieldNormalUtils(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Price is required';
                }
                return null;
              },
              textLabel: "Price (Rs.)",
              controller: priceController,
              isPhonekey: true,
            ),
            TextFormFieldNormalUtils(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
              textLabel: "Description",
              controller: descriptionController,
              isPhonekey: false,
            ),
            AuthButtonUtils(
              btnText: 'Add',
              onPressed: () {
                if (_formKey.currentState.validate()) {
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
        child: AppBarCommonUtils('Add package'),
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
    await CallApi(context).addPackage(vehicleType,
        priceController.text.toString(), descriptionController.text.toString());
  }
}
