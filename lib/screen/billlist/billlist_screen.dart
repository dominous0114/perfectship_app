import 'package:flutter/material.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';

class BillListScreen extends StatefulWidget {
  const BillListScreen({Key? key}) : super(key: key);

  @override
  State<BillListScreen> createState() => _BillListScreenState();
}

class _BillListScreenState extends State<BillListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Billist', backArrow: false),
    );
  }
}
