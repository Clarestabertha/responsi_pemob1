import 'package:flutter/material.dart';
import 'package:responsi1/bloc/hutang_bloc.dart';
import 'package:responsi1/model/Hutang.dart';
import 'package:responsi1/ui/hutang_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

// ignore: must_be_immutable
class HutangForm extends StatefulWidget {
  Hutang? hutang;
  HutangForm({Key? key, this.hutang}) : super(key: key);
  
  @override
  _HutangFormState createState() => _HutangFormState();
}

class _HutangFormState extends State<HutangForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH HUTANG";
  String tombolSubmit = "SIMPAN";
  final _personTextboxController = TextEditingController();
  final _amountTextboxController = TextEditingController();
  final _statusTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.hutang != null) {
      setState(() {
        judul = "UBAH DATA HUTANG";
        tombolSubmit = "UBAH";
        _personTextboxController.text = widget.hutang!.person!;
        _amountTextboxController.text = widget.hutang!.amount.toString();
        _statusTextboxController.text = widget.hutang!.status!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[800]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[300]!),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(judul)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _personTextField(),
                  _amountTextField(),
                  _statusTextField(),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _personTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama"),
      keyboardType: TextInputType.text,
      controller: _personTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama harus diisi";
        }
        return null;
      },
    );
  }

  Widget _statusTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Status"),
      keyboardType: TextInputType.text,
      controller: _statusTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Status harus diisi";
        }
        return null;
      },
    );
  }

  Widget _amountTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah Hutang"),
      keyboardType: TextInputType.number,
      controller: _amountTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah hutang harus diisi";
        }
        return null;
      },
    );
  }

  // Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.hutang != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Hutang createHutang = Hutang(id: null);
    createHutang.person = _personTextboxController.text;
    createHutang.amount = int.parse(_amountTextboxController.text);
    createHutang.status = _statusTextboxController.text;
    HutangBloc.addHutang(hutang: createHutang).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const HutangPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Hutang updateHutang = Hutang(id: widget.hutang!.id!);
    updateHutang.person = _personTextboxController.text;
    updateHutang.amount = int.parse(_amountTextboxController.text);
    updateHutang.status = _statusTextboxController.text;
    HutangBloc.updateHutang(hutang: updateHutang).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const HutangPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
