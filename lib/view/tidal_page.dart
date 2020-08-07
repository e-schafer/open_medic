import 'package:ecg_smith/model/tidal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TidalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TidalState();
}

class _TidalState extends State<TidalPage> {
  final _formKey = GlobalKey<FormState>();

  TidalVolume _tidal = TidalVolume();
  int _result = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "$_result",
            style: TextStyle(fontSize: 80.0),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
              child: Text(
                "mL/Kg",
                style: TextStyle(fontSize: 20.0),
              )),
        ]),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButton(
                value: _tidal.sexRatio,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (double newValue) {
                  setState(() {
                    _tidal.sexRatio = newValue;
                  });
                },
                items: [DropdownMenuItem(value: 45.5, child: Text("Female")), DropdownMenuItem(value: 50.0, child: Text("Male"))],
                isExpanded: true,
              ),
              TextFormField(
                decoration: new InputDecoration(labelText: "Patient height in cm"),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
                onSaved: (newValue) => _tidal.height = double.parse(newValue),
              ),
              TextFormField(
                decoration: new InputDecoration(labelText: "Ideal volume in mL/Kg"),
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                validator: (value) => (value.isEmpty) ? 'Please enter a number' : null,
                onSaved: (newValue) => _tidal.idealVolume = double.parse(newValue),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.reset();
                      _tidal = new TidalVolume();
                      _result = 0;
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
                      _result = _tidal.realVolume();
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
        )
      ]),
    );
  }
}
