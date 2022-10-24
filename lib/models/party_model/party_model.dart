class PartyListData {
  late int _partyID;
  late String _imageCover;
  late String _title;
  late int _countMember;
  late int _totalMember;

  PartyListData(
      {required int partyID,
      required String imageCover,
      required String title,
      required int countMember,
      required int totalMember}) {
    _partyID = partyID;
    _imageCover = imageCover;
    _title = title;
    _countMember = countMember;
    _totalMember = totalMember;
  }

  int get partyID => _partyID;
  
  int get totalMember => _totalMember;

  int get countMember => _countMember;

  String get title => _title = _title;

  String get imageCover => _imageCover;
}
