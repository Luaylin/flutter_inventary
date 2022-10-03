import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';

class DetailFragment extends StatefulWidget {
  
  Function? navigateTo;

  int? movementId;

  DetailFragment({this.navigateTo,this.movementId});

  @override
  _DetailFragmentState createState() => new _DetailFragmentState();
}

Map o = {'p72': '2023-12-12'};
Map ctrl = {};
//o['p27']='2023-12-12';

Function setO = (Function setState, Object? value, String? name) {
  setState(() {
    o[name] = value;
  });
};

Function setterC = (Function setState, name) {
  return (Object? value) {
    setState(() {
      ctrl[name] = value;
    });
  };
};

Function setter = (Function setState, name) {
  return (Object? value) {
    setState(() {
      o[name] = value;
    });
  };
};

Function _TextField = (Object? value, Function(Object?) onChanged,
    {TextAlign textAlign = TextAlign.left,
    bool readOnly = false,
    Function()? onTap}) {
  TextEditingController dateinput = TextEditingController();
  return TextFormField(
    textAlign: textAlign,
    controller: dateinput..text = value != null ? value.toString() : '',
    onChanged: onChanged,
    decoration: InputDecoration(
        hintText: "Enter your text here...", border: OutlineInputBorder()),
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    readOnly: readOnly,
    onTap: onTap,
  );
};

Function _NumberField = (Object? value, Function(Object?) onChanged) {
  TextEditingController dateinput = TextEditingController();
  return TextFormField(
    controller: dateinput..text = value != null ? value.toString() : '',
    onChanged: onChanged,
    decoration: InputDecoration(
        hintText: "Enter your number here...", border: OutlineInputBorder()),
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
  );
};

Function _DateField = (
  BuildContext context,
  Object? value,
  Function(Object?) onChanged, {
  TextAlign textAlign = TextAlign.center,
  String? type,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  TextEditingController dateinput = TextEditingController();
  return TextFormField(
    controller: dateinput..text = value != null ? value.toString() : '',
    textAlign: textAlign,
    decoration: InputDecoration(
        icon: Icon(Icons.calendar_today), labelText: "Enter Date"),
    readOnly: true,
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(
              2000), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101));
      Object value =
          pickedDate != null ? DateFormat('yyyy-MM-dd').format(pickedDate) : '';
      onChanged(value);
    },
  );
};

class _DetailFragmentState extends State<DetailFragment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold);
  TextStyle bold20Style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
  ButtonStyle buttonStyle = TextButton.styleFrom(
      padding: const EdgeInsets.all(16.0),
      primary: Colors.white,
      backgroundColor: Colors.blue,
      textStyle: const TextStyle(fontSize: 20));

  List<Widget> _RadioGroup(
      List<String> options, Object value, void Function(Object?)? getter,
      {void Function(List<Widget>, Object?, int)? addWidget}) {
    return (options.asMap().entries).expand((entry) {
      int index = entry.key;
      var item = entry.value;
      List<Widget> widgets = [];
      widgets.add(ListTile(
        title: Text(item),
        leading: Radio(
            groupValue: value,
            value: item,
            onChanged: getter,
            /*hoverColor: Colors.yellow,
                    activeColor: Colors.pink,
                    focusColor: Colors.purple,
                    fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                        return Colors.orange;
                        } else if (states.contains(MaterialState.selected)) {
                        return Colors.teal;
                        } if (states.contains(MaterialState.focused)) {
                        return Colors.blue;
                        } else {
                        return Colors.black12;
                        }
                    }),
                    overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                            return Colors.lightGreenAccent;
                        } if (states.contains(MaterialState.focused)) {
                            return Colors.brown;
                        } else {
                            return Colors.white;
                        }
                    }),*/
            splashRadius: 35,
            toggleable: true,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
      ));
      if (addWidget != null) {
        addWidget(widgets, value, index);
      }
      return widgets.toList();
    }).toList();
  }

  List<Widget> _CheckboxGroup(List<String> options, String valueName,
      {required Object? Function(String) getValue,
      void Function(Object?, String?)? onChanged,
      void Function(List<Widget>, Object?, int)? addWidget}) {
    return (options.asMap().entries).expand((entry) {
      int index = entry.key;
      var item = entry.value;
      String valueName2 = valueName + (index + 1).toString();
      List<Widget> widgets = [];
      Object? value = getValue(valueName2);
      widgets.add(CheckboxListTile(
          title: Text(item),
          controlAffinity: ListTileControlAffinity.leading,
          value: value != null && value.toString() == 'true',
          onChanged: (Object? value) {
            onChanged!(value, valueName2);
          }));
      if (addWidget != null) {
        addWidget(widgets, value, index);
      }
      return widgets.toList();
    }).toList();
  }

  List<ExpansionPanel> _ExpansionPanel(List panels) {
    int index = -1;
    return (panels.map<ExpansionPanel>((e) {
      index++;
      return ExpansionPanel(
        headerBuilder: (BuildContext context, bool isExpanded) {
          return ListTile(
            title: Text(e['title'], style: bold20Style),
          );
        },
        isExpanded: o[index] != null && o[index],
        body: Padding(
            padding: EdgeInsets.all(15.0),
            child: e['items'] != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: e['items'].cast<Widget>())
                : Text('Empty!')),
      );
    })).toList();
  }

  Widget _DropdownButton(
      List options, Object value, void Function(Object?)? setter) {
    return DropdownButton(
      value: value,
      items: ['--Seleccionar Opción--', ...options]
          .map((code) =>
              new DropdownMenuItem(value: code, child: new Text(code)))
          .toList(),
      onChanged: setter,
      isExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    List panels = [
      {
        'title': 'Datos Item',
        'items': [
          Text("Codigo", style: boldStyle),
          _TextField(o['code'], setter(setState, 'code')),
          Text("Denominación", style: boldStyle),
          _TextField(o['name'], setter(setState, 'name'))
        ]
      }
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Agregar Item'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: new Form(
          key: _formKey,
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExpansionPanelList(
                            animationDuration: Duration(milliseconds: 300),
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                o[index] = !isExpanded;
                              });
                            },
                            children: [..._ExpansionPanel(panels)])
                      ])),
            )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                        Widget cancelButton = TextButton(
                          child: Text("Cancel"),
                          onPressed: () {},
                        );
                        Widget continueButton = TextButton(
                          child: Text("Continue"),
                          onPressed: () {},
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("AlertDialog"),
                          content: Text(
                              "Would you like to continue learning how to use Flutter alerts?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                        setState(() {
                          //debugPrint(_formKey);
                          print(json.encode(o));

                          //_futureAlbum = createAlbum(_controller.text);
                        });
                      },
                      label: const Text('Grabar'),
                      icon: Icon(Icons.save))
                ]))
          ])),
    );
  }
}
