import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samawat_health/dashbord/create_party/create_party.dart';
import 'package:samawat_health/dashbord/home/home_page_bloc/home_page_bloc.dart';
import 'package:samawat_health/models/party_model/party_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homePageBloc = HomePageBloc();

  @override
  void initState() {
    super.initState();
    _homePageBloc.getPartyListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text('All Party')),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateParty()),
                  ).then((value) {
                    if (value != null) {
                      _homePageBloc.createParty(data: value);
                    }
                  });
                },
                child: const Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: StreamBuilder(
              stream: _homePageBloc.partyListData.stream,
              builder: (context, AsyncSnapshot<List<PartyListData>> snapshot) {
                if (snapshot.hasData) {
                  return _partyList(snapshot.data!);
                }
                return Container();
              },
            )),
      ),
    );
  }

  Widget _partyList(List<PartyListData> data) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height / 1.4),
      scrollDirection: Axis.vertical,
      children: List.generate(data.length, (index) {
        return Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: ScreenUtil().setHeight(100),
                  child: Image.network(
                    data[index].imageCover,
                    fit: BoxFit.fill,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Text(data[index].title),
                const Divider(
                  color: Colors.black,
                ),
                const Spacer(),
                Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Text(
                        '${data[index].countMember} / ${data[index].totalMember}'),
                    const Spacer(),
                    _joinButton(data, index),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                  ],
                ),
              ],
            ));
      }),
    );
  }

  Widget _joinButton(
    List<PartyListData> data,
    int index,
  ) {
    return ElevatedButton(
        onPressed: () {
          _homePageBloc.addPartyMember(data, data[index]);
        },
        child: const Text('Join'));
  }
}
