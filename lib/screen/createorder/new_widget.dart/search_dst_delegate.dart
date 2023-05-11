import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectship_app/model/new_model/address_dst_new_model.dart';
import 'package:perfectship_app/model/new_model/static_model/search_phone.dart';
import 'package:perfectship_app/repository/new_repository/address_repository.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

class SearchDstNewDelegate extends SearchDelegate {
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
  TextInputType get keyboardType => TextInputType.phone;

  @override
  String get searchFieldLabel => "ค้นหาจากเบอร์โทรศัพท์";

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        close(context, null);

        //Navigator.pop(context, 'close');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<AddressDstNewModel>>(
      future: AddressNewRepository().getDst(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingShimmer();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('tab');
                close(
                    context,
                    SearchPhoneModel(
                        name: snapshot.data![index].name!,
                        phone: snapshot.data![index].phone!,
                        address: snapshot.data![index].address!,
                        subDistrict: snapshot.data![index].subDistrict!,
                        district: snapshot.data![index].district!,
                        province: snapshot.data![index].province!,
                        zipcode: snapshot.data![index].zipcode!));
              },
              child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.shade100,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${snapshot.data![index].name!.substring(
                                          0,
                                          1,
                                        )}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'เบอร์โทร : ${snapshot.data![index].phone!}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ผู้รับ : ',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data![index].name!),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ที่อยู่ :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                '${snapshot.data![index].address!} ${snapshot.data![index].subDistrict!} ${snapshot.data![index].district!} ${snapshot.data![index].province!} ${snapshot.data![index].zipcode!}'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  )),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<AddressDstNewModel>>(
      future: AddressNewRepository().getDst(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingShimmer();
        }
        if (snapshot.data!.length == 0) {
          return Center(
              child: Text(
            'ไม่พบข้อมูล',
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('tab');
                close(
                    context,
                    SearchPhoneModel(
                        name: snapshot.data![index].name!,
                        phone: snapshot.data![index].phone!,
                        address: snapshot.data![index].address!,
                        subDistrict: snapshot.data![index].subDistrict!,
                        district: snapshot.data![index].district!,
                        province: snapshot.data![index].province!,
                        zipcode: snapshot.data![index].zipcode!));
              },
              child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.shade100,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${snapshot.data![index].name!.substring(
                                          0,
                                          1,
                                        )}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'เบอร์โทร : ${snapshot.data![index].phone!}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'ผู้รับ : ',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data![index].name!),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'ที่อยู่ :',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                '${snapshot.data![index].address!} ${snapshot.data![index].subDistrict!} ${snapshot.data![index].district!} ${snapshot.data![index].province!} ${snapshot.data![index].zipcode!}'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  )),
            );
          },
        );
      },
    );
  }
}
