import 'package:flutter/material.dart';
import 'package:fluttersearchviewpk/Constants.dart';
class gstModel {
  String gstName;
  String gstCity;

  @override
  String toString() {
    return '$gstName $gstCity';
  }

  gstModel(this.gstName, this.gstCity);
}


class DataListScreen extends StatefulWidget {
  @override
  _DataListScreenState createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
//  List<gstModel> gstModelList = [];

  List<gstModel> gstModelList = <gstModel>[
    gstModel('Shell gas station', 'Salaya'),
    gstModel('PT gas station', 'Samphran'),
    gstModel('PTT gas station', 'Chiang Mai'),
    gstModel('Caltex gas station', 'Huahin'),
    gstModel('ESSO gas station', 'Pattaya'),
    gstModel('Susco gas station', 'Kra-bee')
  ];

  @override
  void initState() {
    gstModelListGlobal = gstModelList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade50,
      height: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: gstModelList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: tileViewWithIcon(
                    Icons.local_gas_station,
                    gstModelList[index].gstName,
                    gstModelList[index].gstCity,
                    context),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget tileViewWithIcon(
      IconData icon, String title, String subTitle, BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 0.0, right: 5.0, bottom: 0.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 40,
              maxHeight: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(icon, color: Colors.deepPurple.shade200),
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 8.0, 0.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title, style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 1),
                      Text(subTitle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
