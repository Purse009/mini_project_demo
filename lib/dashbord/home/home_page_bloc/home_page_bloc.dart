import 'dart:async';

import 'package:samawat_health/models/party_model/party_model.dart';

class HomePageBloc {
  final StreamController<List<PartyListData>> _partyListData =
      StreamController<List<PartyListData>>();
  StreamController<List<PartyListData>> get partyListData => _partyListData;

  final List<PartyListData> _appPartyList = [
    PartyListData(
        partyID: 01,
        countMember: 4,
        imageCover:
            'https://img.freepik.com/free-vector/fireworks-background-template_1308-38178.jpg?w=1060&t=st=1666493103~exp=1666493703~hmac=1f62e56d9c865a4e70607e04d036bd0531424bfeba1993febd27aec8e908746c',
        title: 'Party Name 1',
        totalMember: 5),
    PartyListData(
        partyID: 02,
        countMember: 3,
        imageCover:
            'https://img.freepik.com/free-vector/fireworks-background-template_1308-38178.jpg?w=1060&t=st=1666493103~exp=1666493703~hmac=1f62e56d9c865a4e70607e04d036bd0531424bfeba1993febd27aec8e908746c',
        title: 'Party Name 2',
        totalMember: 5),
    PartyListData(
        partyID: 03,
        countMember: 2,
        imageCover:
            'https://img.freepik.com/free-vector/fireworks-background-template_1308-38178.jpg?w=1060&t=st=1666493103~exp=1666493703~hmac=1f62e56d9c865a4e70607e04d036bd0531424bfeba1993febd27aec8e908746c',
        title: 'Party Name 3',
        totalMember: 5),
    PartyListData(
        partyID: 04,
        countMember: 1,
        imageCover: '',
        title: 'Party Name 4',
        totalMember: 5),
  ];

  addPartyMember(List<PartyListData> partyData, PartyListData data) {
    int count = data.countMember;
    partyData[
        partyData.indexWhere(
            (element) => element.partyID == data.partyID)] = PartyListData(
        partyID: data.partyID,
        countMember: count < data.totalMember ? count += 1 : data.countMember,
        imageCover: data.imageCover,
        title: data.title,
        totalMember: data.totalMember);
    _partyListData.sink.add(partyData);
  }

  createParty({required PartyListData data}) {
    _appPartyList.add(data);
    getPartyListData();
  }

  getPartyListData() {
    _partyListData.sink.add(_appPartyList);
  }
}
