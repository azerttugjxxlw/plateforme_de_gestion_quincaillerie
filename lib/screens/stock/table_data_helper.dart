class TableDataHelper {
  static List<TableColumns> kTableColumnsList = [
    TableColumns(title: 'F-Apple', width: 80.0),
    TableColumns(title: 'M-Apple', width: 80.0),
    TableColumns(title: 'M-Banana', width: 90.0),
    TableColumns(title: 'M-Cat', width: 60.0),
    TableColumns(title: 'M-Delhi', width: 80.0),
    TableColumns(title: 'M-Example', width: 120.0),
    TableColumns(title: 'M-Fish', width: 80.0),

  ];
}
class TableColumns {
  String? title;
  double? width;

  TableColumns({this.width, this.title});
}