import 'package:app/data/database/entities/entities.dart';

abstract class TastingDB {
  Future<void> insertBrewery(BreweryEntity entity);
  Future<void> insertSake(SakeEntity entity);
  Future<void> close();
}
