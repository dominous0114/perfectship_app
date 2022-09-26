import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/bloc/orders_bloc/order_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/config/app_router.dart';
import 'package:perfectship_app/config/checkScreen.dart';
import 'package:perfectship_app/repository/address_repository.dart';
import 'package:perfectship_app/repository/bank_repository.dart';
import 'package:perfectship_app/repository/getuserdata_repository.dart';
import 'package:perfectship_app/repository/order_repository.dart';
import 'package:perfectship_app/screen/login.dart';
import 'package:perfectship_app/widget/fontsize.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserDataBloc(
                addressRepository: AddressRepository(),
                getUserDataRepository: GetUserDataRepository(),
                bankRepository: BankRepository()),
          ),
          BlocProvider(
            create: (context) =>
                AddressBloc(addressrepository: AddressRepository()),
          ),
          BlocProvider(
            create: (context) => OrderBloc(orderRepository: OrderRepository()),
          )
        ],
        child: MaterialApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.ibmPlexSansThaiTextTheme(
                              Theme.of(context).textTheme)
                          .bodyText2!
                          .copyWith(fontSize: 16),
                    ),
                    useMaterial3: true,
                    secondaryHeaderColor: Colors.blue,
                    primaryColor: Colors.blue.shade900,
                    buttonBarTheme: ButtonBarThemeData(
                        buttonTextTheme: ButtonTextTheme.primary),
                    appBarTheme: AppBarTheme(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            toolbarTextStyle:
                                GoogleFonts.ibmPlexSansThaiTextTheme(
                                        Theme.of(context).textTheme)
                                    .bodyText2!
                                    .copyWith(fontSize: 16),
                            titleTextStyle:
                                GoogleFonts.ibmPlexSansThaiTextTheme(
                                        Theme.of(context).textTheme)
                                    .headline6!
                                    .copyWith(fontSize: 16))
                        .copyWith(),
                    colorScheme: ColorScheme.fromSwatch()
                        .copyWith(secondary: Colors.blue, primary: Colors.blue))
                .copyWith(
              textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(Theme.of(context)
                  .textTheme
                  .copyWith(
                      headline6: TextStyle(fontSize: 16, color: Colors.black))),

              snackBarTheme: SnackBarThemeData(
                contentTextStyle: GoogleFonts.ibmPlexSansThai(),
              ),
              //colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.red, background: Colors.white, primary: Colors.green, brightness: Brightness.dark, onBackground: Colors.green),
            ),
            home: CheckScreen()));
  }
}
