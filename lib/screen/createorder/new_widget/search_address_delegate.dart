
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectship_app/model/new_model/address_search_new_model.dart';
import 'package:perfectship_app/repository/new_repository/address_repository.dart';

import '../../../widget/fontsize.dart';
import '../../../widget/shimmerloading.dart';

class SearcgAddressNewDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: query == '' ? SizedBox() : Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        close(context, 'close');

        //Navigator.pop(context, 'close');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    AddressNewRepository().getAddress(query).then((value) async {
      print(value.first.district);
    });
    return FutureBuilder<List<AddressSearchNewModel>>(
        future: AddressNewRepository().getAddress(query),
        builder: (context, AsyncSnapshot<List<AddressSearchNewModel>> snapshot) {
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
                      if (snapshot.data![index].zipcode!.contains(',')) {
                        var dis = snapshot.data![index].zipcode;
                        List<String> zlist = dis!.split(',');
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
                                                .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    content: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, blurStyle: BlurStyle.inner)]),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: zlist
                                            .map((e) => GestureDetector(
                                                  onTap: () {
                                                    close(
                                                        context,
                                                        AddressSearchNewModel(
                                                            amphure: snapshot.data![index].amphure,
                                                            district: snapshot.data![index].district,
                                                            id: snapshot.data![index].id,
                                                            province: snapshot.data![index].province,
                                                            zipcode: e));
                                                    print(e);
                                                  },
                                                  child: Column(children: [
                                                    ListTile(
                                                      title: Text(
                                                        '$e\n${snapshot.data![index].amphure} ${snapshot.data![index].district} ${snapshot.data![index].province}',
                                                        style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: PlatformSize(context)),
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
                        close(
                            context,
                            AddressSearchNewModel(
                              amphure: snapshot.data![index].amphure,
                              district: snapshot.data![index].district,
                              id: snapshot.data![index].id,
                              province: snapshot.data![index].province,
                              zipcode: snapshot.data![index].zipcode,
                            ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '${snapshot.data![index].district}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '  >>  ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold, color: Colors.blue)),
                                  TextSpan(
                                      text: '${snapshot.data![index].amphure}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '  >>  ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold, color: Colors.blue)),
                                  TextSpan(
                                      text: '${snapshot.data![index].province}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: '  >>  ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold, color: Colors.blue)),
                                  TextSpan(
                                      text: '${snapshot.data![index].zipcode}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Row(
                          //     children: [
                          //       Text(
                          //         '${snapshot.data![index].district}',
                          //       ),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Icon(
                          //         Icons.keyboard_double_arrow_right_outlined,
                          //         size: 16,
                          //       ),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Text(
                          //         '${snapshot.data![index].amphure}',
                          //       ),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Icon(
                          //         Icons.keyboard_double_arrow_right_outlined,
                          //         size: 16,
                          //       ),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Text(
                          //         '${snapshot.data![index].province}',
                          //       ),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Icon(
                          //         Icons.keyboard_double_arrow_right_outlined,
                          //         size: 16,
                          //       ),
                          //       SizedBox(
                          //         width: 4,
                          //       ),
                          //       Text(
                          //         '${snapshot.data![index].zipcode}',
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
}
