import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/new_bloc/create_order/create_order_bloc.dart';

class SelectCourierScreen extends StatefulWidget {
  const SelectCourierScreen({Key? key}) : super(key: key);

  @override
  State<SelectCourierScreen> createState() => _SelectCourierScreenState();
}

class _SelectCourierScreenState extends State<SelectCourierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Color.fromARGB(200, 43, 166, 223),
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Colors.black45,
                )),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('เลือกขนส่ง'),
          ],
        ),
      ),
      body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) {
          if (state is CreateOrderData) {
            return ListView.builder(
              itemCount: state.courierNewModels.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, state.courierNewModels[index]);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: state.courierNewModel.code == state.courierNewModels[index].code ? Colors.blue : Colors.grey[100]!,
                              blurRadius: 0.0,
                              spreadRadius: 1.5,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: state.courierNewModels[index].logo,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    state.courierNewModels[index].name,
                                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color.fromARGB(255, 67, 80, 101),
                                size: 20,
                              )
                            ],
                          ),
                        )),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('บางอย่างผิดพลาด'));
          }
        },
      ),
    );
  }
}
