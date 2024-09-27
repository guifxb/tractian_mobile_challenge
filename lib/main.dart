import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/company_bloc.dart';
// import 'bloc/location_bloc.dart';
// import 'bloc/asset_bloc.dart';
//
// import 'repositories/company_repository.dart';
// import 'repositories/location_repository.dart';
// import 'repositories/asset_repository.dart';
//
// import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => CompanyBloc(CompanyRepository()),
        // ),
        // BlocProvider(
        //   create: (context) => LocationBloc(LocationRepository()),
        // ),
        // BlocProvider(
        //   create: (context) => AssetBloc(AssetRepository()),
        // ),
      ],
      child: MaterialApp(
        title: 'Asset Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: HomeScreen(), // Default starting screen
      ),
    );
  }
}
