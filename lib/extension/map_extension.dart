extension StandartValue on Map {
  String stringValue(String key) {
    if ((this[key] != null) && (this[key] is String)) {
      return this[key];
    }
    return "";
  }

  int intValue(String key) {
    if ((this[key] != null) && (this[key] is int)) {
      return this[key];
    }
    return 0;
  }

  double doubleValue(String key) {
    if (this[key] != null) {
      return this[key].toDouble();
    }
    return 0.0;
  }

  bool boolValue(String key) {
    if (this[key] != null) {

      var value = this["value"];
      if(value == "TRUE") {
        return true;
      }
    }
    return false;
  }

}
