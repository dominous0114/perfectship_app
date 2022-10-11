import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/bloc/bill_bloc/bill_bloc.dart';
import 'package:perfectship_app/bloc/bill_detail_bloc/bill_detail_bloc.dart';
import 'package:perfectship_app/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:perfectship_app/bloc/orders_bloc/order_bloc.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/config/app_router.dart';
import 'package:perfectship_app/config/checkScreen.dart';
import 'package:perfectship_app/repository/address_repository.dart';
import 'package:perfectship_app/repository/bank_repository.dart';
import 'package:perfectship_app/repository/bill_repository.dart';
import 'package:perfectship_app/repository/courier_repository.dart';
import 'package:perfectship_app/repository/dashboard_repository.dart';
import 'package:perfectship_app/repository/getuserdata_repository.dart';
import 'package:perfectship_app/repository/order_repository.dart';
import 'package:perfectship_app/repository/track_repository.dart';
import 'package:perfectship_app/screen/login.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Plugin must be initialized before using
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Permission.storage.request();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DashboardBloc(dashboardRepository: DashboardRepository()),
          ),
          BlocProvider(
            create: (context) =>
                BillDetailBloc(billRepository: BillRepository()),
          ),
          BlocProvider(
            create: (context) => BillBloc(billRepository: BillRepository()),
          ),
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
          ),
          BlocProvider(
            create: (context) => TrackBloc(
                orderRepository: OrderRepository(),
                trackRepository: TrackRepository(),
                courierRepository: CourierRepository()),
          )
        ],
        child: MaterialApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                    primarySwatch: Colors.blue,
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.ibmPlexSansThaiTextTheme(
                              Theme.of(context).textTheme)
                          .bodyMedium!
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
