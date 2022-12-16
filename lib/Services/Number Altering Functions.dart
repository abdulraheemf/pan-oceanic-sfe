class NumberFunctions {
  //add commas after 3 numbers
  String addCommas(double numberToBeConverted){
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';

    return numberToBeConverted.toString().replaceAllMapped(reg, mathFunc);
  }
}