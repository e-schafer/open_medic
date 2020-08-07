import 'package:ecg_smith/model/smith.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SmithPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SmithState();
}

class _SmithState extends State<SmithPage> {
  final _formKey = GlobalKey<FormState>();
  Smith _smith = new Smith();
  int _score = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(

      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "$_score",
                style: TextStyle(fontSize: 80.0),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text(
                  "status",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ]),
            DropdownButton(
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              isExpanded: true,
              items: dropdownQuestions,
              onChanged: (value) {},
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "ST elevation in V3, 60ms after J point"),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
              onSaved: (newValue) => {_smith.stElevationInV360msAfterJ = double.parse(newValue)},
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "QRS amplitude in V2"),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
              onSaved: (newValue) => {_smith.qrsAmplitudeInV2 = double.parse(newValue)},
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "R Wave amplitude in V4"),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
              onSaved: (newValue) => {_smith.rAmplitudeInV4 = double.parse(newValue)},
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "RR interval"),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
              onSaved: (newValue) => {_smith.rrInterval = double.parse(newValue)},
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: "QT Uncorrected"),
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
              onSaved: (newValue) => {_smith.qtInterval = double.parse(newValue)},
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.reset();
                    _smith = new Smith();
                    _score = 0;
                    setState(() {});
                  }
                },
                child: Text('Clear'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.grey,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _score = _smith.computeScore();
                    setState(() {});
                  }
                },
                child: Text('Submit'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.lightBlue,
              )
            ])
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem> dropdownQuestions = [
    "Is there a bundle branch block?",
    "Is the T-wave inverted in any of V2-V6, but not due to benign T-wave inversion?",
    "Is the ST-segment elevated >5mm in any lead?",
    "Is terminal QRS distorsion present in V2 and V3?",
    "Do any of leads V2-V6 have a convex ST-segment?",
    "Is there significant ST-depression in II, III, or aVF?",
    "Is there ST depression in V2-V6?",
    "Are there pathologic Q-waves in any of V2-V4?"
  ]
      .map((value) => DropdownMenuItem(
            child: Row(children: [Checkbox(value: true, onChanged: (value) {}), SizedBox(width: 300, child: Text(value))]),
          ))
      .toList();
}
