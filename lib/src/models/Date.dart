class Date {

  ///String representation of the relase date, as 
  ///shown in the response.
  String date;

  ///The date the album was first released, for example `1981`.
  ///Depending on the precision, it might be shown as `1981-12`
  ///or `1981-12-15`. 
  ///
  ///_Information not included in [precision] is defualted to `01`.
  ///To avoid using wrong or inaccurate information check [precision] first._  
  DateTime releaseDate;

  ///The precision with which release_date value is known: 
  ///`year`, `month`, or `day`.
  String precision;

  Date(String date, String precision) {
    this.precision = precision;
    this.date = date;

    if (precision == 'day') {
      releaseDate = DateTime.parse(date);
    }
    if (precision == 'month') {
      releaseDate = DateTime.parse('${date}01');
    }
    if (precision == 'year') {
      releaseDate = DateTime.parse('${date}0101');
    }
  }

  String toString() {
    var text = '${releaseDate.year}';
    if (precision == 'year') {
      return text;
    }
    var prefix = releaseDate.month < 10  ? '-0' : '-';
    text += '$prefix${releaseDate.month}';
    if (precision == 'month') {
      return text;
    }
    prefix = releaseDate.day < 10 ? '-0' : '-';
    text += '$prefix${releaseDate.day}';
    return text;
  }
}