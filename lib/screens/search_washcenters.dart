import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/screens/search_Results.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';
import 'package:washing_love/utils/utils_theme.dart';

// search wash centers page
class SearchWashers extends StatefulWidget {
  @override
  _SearchWashersState createState() => _SearchWashersState();
}

class _SearchWashersState extends State<SearchWashers> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final dateController = TextEditingController();
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTimeFrom = TimeOfDay.fromDateTime(DateTime.now());
  TimeOfDay selectedTimeTo = TimeOfDay.fromDateTime(DateTime.now());

  final _formKey = GlobalKey<FormState>();

  List<WashCenter> washcenters = [];

  @override
  void initState() {
    // getData();
    super.initState();
  }

  getData() async {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var date = outputFormat.format(selectedDate);
    var timeFrom = '${selectedTimeFrom.hour}:${selectedTimeFrom.minute}:00';
    var timeTo = '${selectedTimeTo.hour}:${selectedTimeTo.minute}:00';

    var res = await CallApi(context).filter(nameController.text,
        cityController.text, date.toString(), timeFrom, timeTo);

    setState(() {
      washcenters = res;
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Results(
                  washers: washcenters,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Search services'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Form(
                    key: _formKey,
                    child: Wrap(
                      runSpacing: 20,
                      children: [
                        TextFormFieldNormalUtils(
                          textLabel: "Washcenter name",
                          controller: nameController,
                          isPhonekey: false,
                        ),
                        TextFormFieldNormalUtils(
                          textLabel: "City",
                          controller: cityController,
                          isPhonekey: false,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: TextFormFieldNormalUtils(
                            textLabel: "Date",
                            controller: dateController,
                            isPhonekey: false,
                            disabled: true,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: TextFormFieldNormalUtils(
                            textLabel: "From Time",
                            controller: fromController,
                            isPhonekey: false,
                            disabled: true,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _selectTimeTo(context);
                          },
                          child: TextFormFieldNormalUtils(
                            textLabel: "to Time",
                            controller: toController,
                            isPhonekey: false,
                            disabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      onPressed: () async {
                        getData();
                      },
                      color: AppColors.color('FFD54F'),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'search',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 30)));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat.yMd().format(selectedDate);
        // DateFormat.yMd().format(picked);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeFrom,
    );
    if (picked != null)
      setState(() {
        selectedTimeFrom = picked;
        fromController.text = '${picked.hour}:${picked.minute}:00';
      });
  }

  Future<Null> _selectTimeTo(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTimeTo,
    );
    if (picked != null)
      setState(() {
        selectedTimeTo = picked;
        toController.text = '${picked.hour}:${picked.minute}:00';
      });
  }
}
