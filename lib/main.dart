import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/screens/home_screen.dart';

import 'bloc/asset/asset_bloc.dart';
import 'bloc/company/company_bloc.dart';
import 'bloc/location/location_bloc.dart';
import 'bloc/node/node_bloc.dart';
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

    final companyRepository = CompanyRepository(apiService);
    final locationRepository = LocationRepository(apiService);
    final assetRepository = AssetRepository(apiService);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CompanyBloc(companyRepository),
        ),
        BlocProvider(
          create: (context) => LocationBloc(locationRepository),
        ),
        BlocProvider(
          create: (context) => AssetBloc(assetRepository),
        ),
        BlocProvider(
          create: (context) => NodeBloc(
            assetRepository: assetRepository,
            locationRepository: locationRepository,
          ),
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
