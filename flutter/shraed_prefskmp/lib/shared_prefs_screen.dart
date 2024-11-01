import 'package:flutter/material.dart';
import 'shared_prefs.dart';

class SharedPrefsTestScreen extends StatefulWidget {
  @override
  _SharedPrefsTestScreenState createState() => _SharedPrefsTestScreenState();
}

class _SharedPrefsTestScreenState extends State<SharedPrefsTestScreen> {
  final SharedPrefs _sharedPrefs = SharedPrefs();

  final TextEditingController _stringKeyController = TextEditingController();
  final TextEditingController _stringValueController = TextEditingController();
  final TextEditingController _intKeyController = TextEditingController();
  final TextEditingController _intValueController = TextEditingController();
  final TextEditingController _boolKeyController = TextEditingController();
  final TextEditingController _boolValueController = TextEditingController();
  final TextEditingController _listKeyController = TextEditingController();
  final TextEditingController _listValueController = TextEditingController();

  String? _outputString;
  int? _outputInt;
  bool? _outputBool;
  List<String>? _outputList;

  void _setString() async {
    await _sharedPrefs.setString(
        _stringKeyController.text, _stringValueController.text);
  }

  void _getString() async {
    final value = await _sharedPrefs.getString(_stringKeyController.text);
    setState(() {
      _outputString = value;
    });
  }

  void _setInt() async {
    await _sharedPrefs.setInt(
        _intKeyController.text, int.parse(_intValueController.text));
  }

  void _getInt() async {
    final value = await _sharedPrefs.getInt(_intKeyController.text);
    setState(() {
      _outputInt = value;
    });
  }

  void _setBoolean() async {
    await _sharedPrefs.setBoolean(_boolKeyController.text,
        _boolValueController.text.toLowerCase() == 'true');
  }

  void _getBoolean() async {
    final value = await _sharedPrefs.getBoolean(_boolKeyController.text);
    setState(() {
      _outputBool = value;
    });
  }

  void _setStringList() async {
    final values =
        _listValueController.text.split(',').map((e) => e.trim()).toList();
    await _sharedPrefs.setStringList(_listKeyController.text, values);
  }

  void _getStringList() async {
    final value = await _sharedPrefs.getStringList(_listKeyController.text);
    setState(() {
      _outputList = value;
    });
  }

  void _remove(String key) async {
    await _sharedPrefs.remove(key);
  }

  void _clear() async {
    await _sharedPrefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _stringKeyController,
                decoration: const InputDecoration(labelText: 'String Key'),
              ),
              TextField(
                controller: _stringValueController,
                decoration: const InputDecoration(labelText: 'String Value'),
              ),
              ButtonsRow(
                onRemove: () => _remove(_stringKeyController.text),
                onset: _setString,
                output: _outputString,
                onGet: _getString,
              ),
              TextField(
                controller: _intKeyController,
                decoration: const InputDecoration(labelText: 'Integer Key'),
              ),
              TextField(
                controller: _intValueController,
                decoration: const InputDecoration(labelText: 'Integer Value'),
                keyboardType: TextInputType.number,
              ),
              ButtonsRow(
                onRemove: () => _remove(_boolKeyController.text),
                onset: _setInt,
                output: _outputInt?.toString(),
                onGet: _getInt,
              ),
              TextField(
                controller: _boolKeyController,
                decoration: const InputDecoration(labelText: 'Boolean Key'),
              ),
              TextField(
                controller: _boolValueController,
                decoration: const InputDecoration(
                    labelText: 'Boolean Value (true/false)'),
              ),
              ButtonsRow(
                onRemove: () => _remove(_boolKeyController.text),
                onset: _setBoolean,
                output: _outputBool?.toString(),
                onGet: _getBoolean,
              ),
              TextField(
                controller: _listKeyController,
                decoration: const InputDecoration(labelText: 'List Key'),
              ),
              TextField(
                controller: _listValueController,
                decoration: const InputDecoration(
                    labelText: 'List Values (comma separated)'),
              ),
              ButtonsRow(
                onRemove: () => _remove(_listKeyController.text),
                onset: _setStringList,
                output: _outputList?.join(", "),
                onGet: _getStringList,
              ),
              ElevatedButton(
                onPressed: _clear,
                child: const Text('Clear All'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonsRow extends StatelessWidget {
  final void Function() onset;
  final void Function() onRemove;
  final void Function() onGet;
  final String? output;

  const ButtonsRow({
    super.key,
    required this.onRemove,
    required this.onset,
    required this.output,
    required this.onGet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onset,
          child: const Text('Set'),
        ),
        ElevatedButton(
          onPressed: onGet,
          child: const Text('Get'),
        ),
        ElevatedButton(
          onPressed: onRemove,
          child: const Text('Remove'),
        ),
        if (output != null) Text("output : $output"),
      ],
    );
  }
}
