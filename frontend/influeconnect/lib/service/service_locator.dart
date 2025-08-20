import 'package:get_it/get_it.dart';
import 'auth_service.dart';
import 'organization_service.dart';
import 'brand_service.dart';
import 'influencer_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Register services as singletons
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<OrganizationService>(() => OrganizationService());
  getIt.registerLazySingleton<BrandService>(() => BrandService());
  getIt.registerLazySingleton<InfluencerService>(() => InfluencerService());
}