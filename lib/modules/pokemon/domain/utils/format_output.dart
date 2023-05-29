class FormatOutput {

  late final String value;
  
  String capitalizeFirstLetter(String value) {
  if (value.isEmpty) {
    return value;
  }
  return value[0].toUpperCase() + value.substring(1).toLowerCase();
}
}