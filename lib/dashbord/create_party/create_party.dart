import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samawat_health/models/party_model/party_model.dart';

class CreateParty extends StatefulWidget {
  const CreateParty({Key? key}) : super(key: key);

  @override
  State<CreateParty> createState() => _CreatePartyState();
}

class _CreatePartyState extends State<CreateParty> {
  final _partyTitle = TextEditingController();
  final _amountPeople = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create Party')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _widgetTextFiled(
                  controller: _partyTitle,
                  label: 'Party Name',
                  validatorText: 'Party name cannot be blank'),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              _widgetTextFiled(
                  controller: _amountPeople,
                  label: 'Amount of People',
                  validatorText: 'Party member cannot be blank',
                  textInput: TextInputType.number),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              _createPartyButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _widgetTextFiled(
      {TextEditingController? controller,
      required String label,
      required String validatorText,
      TextInputType? textInput}) {
    return TextFormField(
      controller: controller,
      keyboardType: textInput,
      validator: (value) => value!.isEmpty ? validatorText : null,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _createPartyButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40)),
        onPressed: () {
          _checkValidate();
        },
        child: const Text('Create Party'));
  }

  _checkValidate() {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      print('ddddddd ${_amountPeople.text}');
      Navigator.of(context).pop(
        PartyListData(
            partyID: Random().nextInt(20),
            countMember: int.parse(_amountPeople.text),
            imageCover:
                'https://img.freepik.com/free-vector/fireworks-background-template_1308-38178.jpg?w=1060&t=st=1666493103~exp=1666493703~hmac=1f62e56d9c865a4e70607e04d036bd0531424bfeba1993febd27aec8e908746c',
            title: _partyTitle.text,
            totalMember: 5),
      );
    }
  }
}
