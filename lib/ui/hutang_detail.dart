import 'package:flutter/material.dart';
import 'package:responsi1/bloc/hutang_bloc.dart';
import 'package:responsi1/widget/warning_dialog.dart';
import 'package:responsi1/model/Hutang.dart';
import 'package:responsi1/ui/hutang_form.dart';
import 'package:responsi1/ui/hutang_page.dart';

class HutangDetail extends StatefulWidget {
  Hutang? hutang;
  
  HutangDetail({Key? key, this.hutang}) : super(key: key);

  @override
  _HutangDetailState createState() => _HutangDetailState();
}

class _HutangDetailState extends State<HutangDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Colors.black,
         // Apply color to body and display text
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue, // Background color for buttons
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          labelStyle: TextStyle(color: Colors.white),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Detail Hutang'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nama : ${widget.hutang!.person}",
                style: const TextStyle(fontSize: 20.0),
              ),
              Text(
                "Jumlah Hutang : Rp. ${widget.hutang!.amount}",
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                "Status : ${widget.hutang!.status}",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20), // Spacer
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HutangForm(hutang: widget.hutang!),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Spacer
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            HutangBloc.deleteHutang(id: widget.hutang!.id!).then(
              (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HutangPage(),
                  ),
                );
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }
}
