import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import '../model/search_model.dart';
import '../repository/address_helper_repository.dart';

class SearchAddressDelegate extends SearchDelegate<String> {
  SearchAddressDelegate({
    this.contextPage,
    required this.provincecontroller,
    required this.amphurecontroller,
    required this.districtcontroller,
    required this.zipcodecontroller,
    required this.typeaheadcontroller,
  });
  final TextEditingController provincecontroller;
  final TextEditingController amphurecontroller;
  final TextEditingController districtcontroller;
  final TextEditingController zipcodecontroller;
  final TextEditingController typeaheadcontroller;
  BuildContext? contextPage;
  Color _color = Colors.transparent;

  List<Search> searchmodel = [];
  @override
  String get searchFieldLabel => "ค้นหา ตำบล อำเภอ จังหวัด";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: query == '' ? SizedBox() : Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        close(context, 'close');
        typeaheadcontroller.text = query;
        //Navigator.pop(context, 'close');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    SearchAddressHelperRepository().getProvince(query).then((value) async {
      searchmodel = await value;
      print(searchmodel.first.district);
      print(value.first.district);
    });
    return FutureBuilder<List<Search>>(
        future: SearchAddressHelperRepository().getProvince(query),
        builder: (context, AsyncSnapshot<List<Search>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingShimmer();
          }
          return Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (snapshot.data![index].zipcode.contains(',')) {
                        var dis = snapshot.data![index].zipcode;
                        List<String> zlist = dis.split(',');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.paperplane_fill,
                                          color: Colors.grey.shade700,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('กรุณาเลือกรหัสไปรษณีย์ปลายทาง',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    fontSize:
                                                        PlatformSize(context),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                    content: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black45,
                                                blurRadius: 3,
                                                blurStyle: BlurStyle.inner)
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: zlist
                                            .map((e) => GestureDetector(
                                                  onTap: () {
                                                    districtcontroller.text =
                                                        snapshot.data![index]
                                                            .district;
                                                    amphurecontroller.text =
                                                        snapshot.data![index]
                                                            .amphure;
                                                    provincecontroller.text =
                                                        snapshot.data![index]
                                                            .province;
                                                    typeaheadcontroller.text =
                                                        query;
                                                    zipcodecontroller.text = e;
                                                    close(context, 'close');
                                                    print(e);
                                                  },
                                                  child: Column(children: [
                                                    ListTile(
                                                      title: Text(
                                                        '$e\n${snapshot.data![index].amphure} ${snapshot.data![index].district} ${snapshot.data![index].province}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4!
                                                            .copyWith(
                                                                fontSize:
                                                                    PlatformSize(
                                                                        context)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                    )
                                                  ]),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            });
                      } else {
                        districtcontroller.text =
                            snapshot.data![index].district;
                        amphurecontroller.text = snapshot.data![index].amphure;
                        provincecontroller.text =
                            snapshot.data![index].province;
                        zipcodecontroller.text = snapshot.data![index].zipcode;
                        typeaheadcontroller.text = query;
                        close(context, 'close');
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              child: Row(
                                children: [
                                  Text(
                                    '${snapshot.data![index].district}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize:
                                                PlatformSize(context) * 1.1),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${snapshot.data![index].amphure}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize:
                                                PlatformSize(context) * 1.1),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '${snapshot.data![index].province}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                            fontSize:
                                                PlatformSize(context) * 1.1),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.keyboard_double_arrow_right_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${snapshot.data![index].zipcode}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              fontSize:
                                                  PlatformSize(context) * 1.1),
                                    ),
                                  ),
                                ],
                              )
                              // Text(
                              //   '${snapshot.data![index].district} >> ${snapshot.data![index].amphure} >> ${snapshot.data![index].province} >> ${snapshot.data![index].zipcode}',
                              //   style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: PlatformSize(context) * 1.1),
                              // ),
                              ),
                          Divider(
                            thickness: 2,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ));
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
