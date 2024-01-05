import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectship_app/bloc/address_bloc/address_bloc.dart';
import 'package:perfectship_app/bloc/bill_bloc/bill_bloc.dart';
import 'package:perfectship_app/bloc/bill_detail_bloc/bill_detail_bloc.dart';

import 'package:perfectship_app/bloc/dropdown_courier_bloc/dropdown_courier_bloc.dart';

import 'package:perfectship_app/bloc/new_bloc/create_order/create_order_bloc.dart';
import 'package:perfectship_app/bloc/new_bloc/dashboard/dashboard_bloc.dart';
import 'package:perfectship_app/bloc/new_bloc/navbar/navbar_bloc.dart';
import 'package:perfectship_app/bloc/orders_bloc/order_bloc.dart';
import 'package:perfectship_app/bloc/track_bloc/track_bloc.dart';
import 'package:perfectship_app/bloc/userdata_bloc/user_data_bloc.dart';
import 'package:perfectship_app/config/app_router.dart';
import 'package:perfectship_app/config/checkScreen.dart';
import 'package:perfectship_app/config/localnoti_service.dart';
import 'package:perfectship_app/config/navkey.dart';
import 'package:perfectship_app/repository/address_repository.dart';
import 'package:perfectship_app/repository/bank_repository.dart';
import 'package:perfectship_app/repository/bill_repository.dart';
import 'package:perfectship_app/repository/courier_repository.dart';

import 'package:perfectship_app/repository/order_repository.dart';
import 'package:perfectship_app/repository/track_repository.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/new_bloc/bill_list/bill_list_bloc.dart';
import 'bloc/new_bloc/orderlist_new/orderlist_new_bloc.dart';
import 'bloc/new_bloc/tracking/tracking_bloc.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@pragma('vm:entry-point')
Future<void> backgroundHandlersss(RemoteMessage message) async {
  print('on bg handler');
  print(message.data['title']);

  LocalNotficationService.displaybackground(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await Firebase.initializeApp(
    name: "dev-project",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //FirebaseMessaging.onBackgroundMessage(backgroundHandlersss);
  var _messaging = FirebaseMessaging.instance;
  NotificationSettings settings =
      await _messaging.requestPermission(alert: true, badge: true, provisional: true, sound: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  // Plugin must be initialized before using
  await Permission.storage.request();

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
            create: (context) => DropdownCourierBloc(),
          ),
          // BlocProvider(
          //   create: (context) => DashboardBloc(dashboardRepository: DashboardRepository()),
          // ),
          BlocProvider(
            create: (context) => BillDetailBloc(billRepository: BillRepository()),
          ),
          BlocProvider(
            create: (context) => BillBloc(billRepository: BillRepository()),
          ),
          BlocProvider(
            create: (context) => UserDataBloc(addressRepository: AddressRepository(), bankRepository: BankRepository()),
          ),
          BlocProvider(
            create: (context) => AddressBloc(addressrepository: AddressRepository()),
          ),
          BlocProvider(
            create: (context) => OrderBloc(orderRepository: OrderRepository()),
          ),
          BlocProvider(
            create: (context) => TrackBloc(
                orderRepository: OrderRepository(),
                trackRepository: TrackRepository(),
                courierRepository: CourierRepository()),
          ),
          BlocProvider(
            create: (context) => CreateOrderBloc(),
          ),
          BlocProvider(
            create: (context) => OrderlistNewBloc(),
          ),
          BlocProvider(
            create: (context) => NavbarBloc(),
          ),
          BlocProvider(
            create: (context) => BillListBloc(),
          ),
          BlocProvider(
            create: (context) => TrackingBloc(),
          ),
          BlocProvider(
            create: (context) => DashboardBloc(),
          )
        ],
        child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('th')
            ],
            // localizationsDelegates: [
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: [
            //   Locale('en', ''),
            //   Locale('th', ''),
            // ],
            navigatorKey: NavKey.navKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                    primarySwatch: Colors.blue,
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.notoSansThaiTextTheme(Theme.of(context).textTheme)
                          .bodyMedium!
                          .copyWith(fontSize: 16),
                    ),
                    useMaterial3: false,
                    secondaryHeaderColor: Colors.blue,
                    primaryColor: Colors.blue.shade900,
                    buttonBarTheme: ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.primary),
                    appBarTheme: AppBarTheme(
                            elevation: 0,
                            backgroundColor: Colors.white,
                            toolbarTextStyle: GoogleFonts.notoSansThaiTextTheme(Theme.of(context).textTheme)
                                .bodyText2!
                                .copyWith(fontSize: 16),
                            titleTextStyle: GoogleFonts.notoSansThaiTextTheme(Theme.of(context).textTheme)
                                .headline6!
                                .copyWith(fontSize: 16))
                        .copyWith(),
                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.blue, primary: Colors.blue))
                .copyWith(
              textTheme: textTheme(),

              snackBarTheme: SnackBarThemeData(
                contentTextStyle: GoogleFonts.notoSansThai(),
              ),
              //colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.red, background: Colors.white, primary: Colors.green, brightness: Brightness.dark, onBackground: Colors.green),
            ),
            home: CheckScreen()));
  }
}

TextTheme textTheme() {
  return TextTheme(
    headline1: GoogleFonts.notoSansThai(fontSize: 20, color: Colors.black),
    headline2: GoogleFonts.notoSansThai(fontSize: 18, color: Colors.black),
    headline3: GoogleFonts.notoSansThai(fontSize: 16, color: Colors.black),
    headline4: GoogleFonts.notoSansThai(fontSize: 16, color: Colors.black),
    headline5: GoogleFonts.notoSansThai(fontSize: 14, color: Colors.black),
    headline6: GoogleFonts.notoSansThai(fontSize: 12, color: Colors.black),
    bodyText1: GoogleFonts.notoSansThai(fontSize: 10, color: Colors.black),
    bodyText2: GoogleFonts.notoSansThai(fontSize: 13, color: Colors.black),
  );
}
