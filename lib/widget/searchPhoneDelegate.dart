import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/model/addressfromphone_model.dart';
import 'package:perfectship_app/widget/shimmerloading.dart';

import 'fontsize.dart';

class SearchPhoneDelegate extends SearchDelegate {
  SearchPhoneDelegate(
      {this.contextPage,
      required this.provincecontroller,
      required this.amphurecontroller,
      required this.districtcontroller,
      required this.zipcodecontroller,
      required this.typeaheadcontroller,
      required this.namecontroller,
      required this.phonecontroller,
      required this.addresscontroller})
      : super(
          searchFieldLabel: 'ค้นหาจากเบอร์มือถือ',
          keyboardType: TextInputType.phone,
        );
  final TextEditingController provincecontroller;
  final TextEditingController amphurecontroller;
  final TextEditingController districtcontroller;
  final TextEditingController zipcodecontroller;
  final TextEditingController typeaheadcontroller;
  final TextEditingController namecontroller;
  final TextEditingController phonecontroller;
  final TextEditingController addresscontroller;
  BuildContext? contextPage;
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        context.read<AddressBloc>().add(AddressInitialEvent());
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        close(context, 'close');
        typeaheadcontroller.text = query;
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
    context
        .read<AddressBloc>()
        .add(AddressFromphoneSearchEvent(keyword: query));
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        if (state is AddressLoading) {
          return LoadingShimmer();
        } else if (state is AddressFromphoneLoaded) {
          List data = [];
          List<AddressfromphoneModel> address1 = [];
          List<AddressfromphoneModel> address = [];
          address1.addAll(state.addressphonemodel.map((e) => e));
          address1.retainWhere((element) =>
              element.phone!.toLowerCase().contains(query.toLowerCase()));
          for (int i = 0; i < address1.length; i++) {
            if (!data.contains(address1[i].name) ||
                !data.contains(address1[i].phone) ||
                !data.contains(address1[i].address) ||
                !data.contains(address1[i].district) ||
                !data.contains(address1[i].subDistrict) ||
                !data.contains(address1[i].province) ||
                !data.contains(address1[i].zipcode)) {
              data.add(address1[i].name);
              data.add(address1[i].phone);
              data.add(address1[i].address);
              data.add(address1[i].subDistrict);
              data.add(address1[i].district);
              data.add(address1[i].province);
              data.add(address1[i].zipcode);
              address.add(address1[i]);
            } else {}
          }
          return WillPopScope(
            onWillPop: () async {
              context.read<AddressBloc>().add(AddressInitialEvent());
              return false;
            },
            child: ListView.builder(
                itemCount: address.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.read<AddressBloc>().add(AddressInitialEvent());
                      districtcontroller.text = address[index].subDistrict!;
                      amphurecontroller.text = address[index].district!;
                      provincecontroller.text = address[index].province!;
                      zipcodecontroller.text = address[index].zipcode!;
                      typeaheadcontroller.text = query;
                      namecontroller.text = address[index].name!;
                      phonecontroller.text = address[index].phone!;
                      addresscontroller.text = address[index].address!;
                      close(context, 'close');
                    },
                    child: ListTile(
                      title: Text(
                        'คุณ : ${state.addressphonemodel[index].name}',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: PlatformSize(context)),
                      ),
                      subtitle: Text(
                        'ที่อยู่ : ${state.addressphonemodel[index].address} ${state.addressphonemodel[index].subDistrict} ${state.addressphonemodel[index].district} ${state.addressphonemodel[index].province} ${state.addressphonemodel[index].zipcode}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: PlatformSize(context) * .8),
                      ),
                      trailing: Text(
                        '${state.addressphonemodel[index].phone}',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: PlatformSize(context)),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
