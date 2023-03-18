enum FuelType { gasoline, diesel, electric, hybrid }

enum RouteType { driving, walking, bicycling, transit, flight }

class BasicFunc {
//  Enum

  int calculateEmissionsSaved(FuelType fuelType, int savedConsumption) {
    switch (fuelType) {
      case FuelType.gasoline:
        return (savedConsumption * 2.31).toInt();
      case FuelType.diesel:
        return (savedConsumption * 2.64).toInt();
      case FuelType.electric:
        return (savedConsumption * 0.0).toInt();
      case FuelType.hybrid:
        return (savedConsumption * 1.0).toInt();
    }
  }
}
