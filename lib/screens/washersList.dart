import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/models/washer.dart';
import 'package:washing_love/screens/add_service.dart';
import 'package:washing_love/screens/washer_with_packages.dart';

// washers list widget
class WashcentersList extends StatefulWidget {
  @override
  _WashcentersListState createState() => _WashcentersListState();
}

class _WashcentersListState extends State<WashcentersList> {
  bool isDetailer = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    bool isDetailerRes = await CallApi(context).isDetailer();
    setState(() {
      isDetailer = isDetailerRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: FutureBuilder(
        future: isDetailer
            ? CallApi(context).getWashersByUserId()
            : CallApi(context).getWashers(),
        builder:
            (BuildContext context, AsyncSnapshot<List<WashCenter>> snapshot) {
          if (snapshot.hasData) {
            List<WashCenter> data = snapshot.data;
            if (data.length <= 0) {
              if (isDetailer) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddServicePage()));
                      },
                      // color: AppColors.color('FFD54F'),
                      child: Container(
                        width: double.infinity,
                        height: 25,
                        child: Text(
                          ' + Add Service',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                );
              } else {
                return Center(
                  child:
                      Text('No service stations available for your location.'),
                );
              }
            } else
              return ListView(
                scrollDirection: Axis.horizontal,
                children: data
                    .map(
                      (WashCenter washCenterVar) => InkWell(
                        onTap: () {
                          // if (isDetailer)
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AddServicePage(
                          //             washCenter: washCenterVar)));
                          // else
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WasherWithPackages(
                                      washCenter: washCenterVar)));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          padding: EdgeInsets.all(2.0),
                          width: 260,
                          decoration: BoxDecoration(
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
                                          'https://5.imimg.com/data5/EW/GO/SZ/GLADMIN-51741270/selection-092-500x500.png'),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Container(
                                width: 140,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 130,
                                        child: Text(washCenterVar.name)),
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
                                                Icons.location_on,
                                                size: 12,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text('${washCenterVar.city}',
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ],
                                          ),
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
                                              Text(
                                                  'Rs: ${washCenterVar.totalRate}',
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.lock_clock,
                                                size: 12,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  '${washCenterVar.totalSlot} slots per day',
                                                  style:
                                                      TextStyle(fontSize: 12)),
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
                                              Text(
                                                  '${washCenterVar.packages.length} packages',
                                                  style:
                                                      TextStyle(fontSize: 12)),
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
                      ),
                    )
                    .toList(),
              );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
