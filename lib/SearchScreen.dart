import 'package:flutter/material.dart';
import 'package:fluttersearchviewpk/Constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fluttersearchviewpk/pk_search_bar/pk_search_bar.dart';
import 'package:fluttersearchviewpk/DataListScreen.dart';
import 'package:flutter/services.dart';


class SearchScreen extends StatefulWidget {

  final List<gstModel> gstModelList;
  @override
  _SearchScreenState createState() => _SearchScreenState();

  const SearchScreen(this.gstModelList);
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Container(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: searchBar(context)),
          )),
    );
  }

  // TODO: gstSearchBar
  Widget searchBar(BuildContext context) {
    return SearchBar<gstModel>(
      searchBarPadding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
      headerPadding: EdgeInsets.only(left: 0, right: 0),
      listPadding: EdgeInsets.only(left: 0, right: 0),
      hintText: "Search Placeholder",
      hintStyle: TextStyle(
        color: Colors.black54,
      ),
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      iconActiveColor: Colors.deepPurple,
      shrinkWrap: true,
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      suggestions: widget.gstModelList,
      cancellationWidget: Text("Cancel"),
      minimumChars: 1,
//      placeHolder: Center(
//        child: Padding(
//          padding: const EdgeInsets.only(left: 10, right: 10),
//          child: Text(searchMessage, textAlign: TextAlign.center, style: CustomTextStyle.textSubtitle1(context).copyWith(fontSize: 14),),
//        ),
//      ),
      emptyWidget: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text("There is no any data found"),
        ),
      ),
      onError: (error) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text("$error", textAlign: TextAlign.center),
          ),
        );
      },
      loader: Center(
        child: LoadingIndicator(),
      ),
      onSearch: gstSearchWithSuggestion, /// gstSearch  // if want to search with API then use thi ----> getgstListFromApi
      onCancelled: () {
        Navigator.pop(context);
      },
      buildSuggestion: (gstModel gstModel, int index) {
        return gstGenerateColumn(gstModel, index);
      },
      onItemFound: (gstModel gstModel, int index) {
        return gstGenerateColumn(gstModel, index);
      },
    );
  }

  Widget gstGenerateColumn(gstModel gstModel, int index) => InkWell(
    child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 5.0),
                  width: MediaQuery.of(context).size.width * .60,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(gstModel.gstName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis
                      ),
                      Text(
                        gstModel.gstCity,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Divider(height: 0.5)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );


//  Future<List<gstModel>> getgstListFromApi(String search) async {
//    var _param = {
//      "search_value":search,
//      "user_token": "",
//    };
//    print("Resident search = $search");
//    if (search == "empty") return [];
//    if (search == "error") throw Error();
//
//    var response = await ApiManager.instance
//        .postAPICall(BASE_URL_Local + get_search_gst_list, _param, context);
//    var data = response["data"];
//    List<gstModel> gstModelList = [];
//    for (var u in data) {
//      gstModel gstModel = gstModel(
//        u["gstName"],
//        u["gstCode"]
//      );
//      gstModelList.add(gstModel);
//    }
//    return gstModelList;
//  }

  Future<List<gstModel>> getgstSearch(String search) async {
    print("Resident search = $search");
    if (search == "empty") return [];
    if (search == "error") throw Error();
    List<gstModel> filtergstList = [];

    widget.gstModelList.forEach((gstModel) {
      if (gstModel.gstName
          .toLowerCase()
          .contains(search.toLowerCase()) ||
          gstModel.gstCity
              .toLowerCase()
              .contains(search.toLowerCase()))
        filtergstList.add(gstModel);
    });

    return filtergstList;
  }

  Future<List<gstModel>> gstSearchWithSuggestion(
      String search) async {
    print("Resident search = $search");
    if (search == "empty") return [];
    if (search == "error") throw Error();
    List<gstModel> filtergstList = [];

    widget.gstModelList.forEach((gstModel) {
      if (gstModel.gstName
          .toLowerCase()
          .contains(search.toLowerCase()) ||
          gstModel.gstCity
              .toLowerCase()
              .contains(search.toLowerCase()))
        filtergstList.add(gstModel);
    });

    final suggestionList =
    search.isEmpty ? widget.gstModelList : filtergstList;

    return suggestionList;
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
      ),
    );
  }
}