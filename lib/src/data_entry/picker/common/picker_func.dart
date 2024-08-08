String convertListToString(List? list) {
  if (list == null || list.isEmpty) {
    return "";
  }
  String text = "";
  for (var data in list) {
    text.isEmpty ? text += "$data" : text += ",$data";
  }
  return text;
}
