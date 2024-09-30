import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/bloc/asset/asset_bloc.dart';
import 'package:tractian_challenge/bloc/asset/asset_event.dart';
import 'package:tractian_challenge/bloc/asset/asset_state.dart';
import 'package:tractian_challenge/models/asset.dart';
import 'package:tractian_challenge/repositories/asset_repository.dart';

class MockAssetRepository extends Mock implements AssetRepository {}


