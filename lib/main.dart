import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/screens/home_screen.dart';

import 'bloc/asset/asset_bloc.dart';
import 'bloc/company/company_bloc.dart';
import 'bloc/location/location_bloc.dart';
import 'repositories/company_repository.dart';
import 'repositories/location_repository.dart';
import 'repositories/asset_repository.dart';
import 'services/api_service.dart';
import 'utils/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService(baseUrl: Config.baseUrl);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CompanyBloc(CompanyRepository(apiService)),
        ),
        BlocProvider(
          create: (context) => LocationBloc(LocationRepository(apiService)),
        ),
        BlocProvider(
          create: (context) => AssetBloc(AssetRepository(apiService)),
        ),
      ],
      child: MaterialApp(
        title: 'Asset Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
