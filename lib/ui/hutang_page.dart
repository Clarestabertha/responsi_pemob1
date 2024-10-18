import 'package:flutter/material.dart';
import 'package:responsi1/bloc/logout_bloc.dart';
import 'package:responsi1/bloc/hutang_bloc.dart';
import 'package:responsi1/model/Hutang.dart';
import 'package:responsi1/ui/login_page.dart';
import 'package:responsi1/ui/hutang_detail.dart';
import 'package:responsi1/ui/hutang_form.dart';

class HutangPage extends StatefulWidget {
  const HutangPage({Key? key}) : super(key: key);

  @override
  _HutangPageState createState() => _HutangPageState();
}

class _HutangPageState extends State<HutangPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
        ),
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
        appBar: AppBar(
          title: const Text('List Hutang'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HutangForm()));
                },
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },
              )
            ],
          ),
        ),
        body: FutureBuilder<List>(
          future: HutangBloc.getHutangs(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListHutang(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListHutang extends StatelessWidget {
  final List? list;

  const ListHutang({Key? key, this.list}) : super(key: key);

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemHutang(
            hutang: list![i],
          );
        });
  }
}

class ItemHutang extends StatelessWidget {
  final Hutang hutang;

  const ItemHutang({Key? key, required this.hutang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HutangDetail(hutang: hutang)),
        );
      },
      child: Card(
        color: Colors.grey[800], // Menyesuaikan warna card
        child: ListTile(
          title: Text(
            hutang.person!,
            style: const TextStyle(color: Colors.white), // Gaya teks
          ),
          subtitle: Text(
            hutang.status.toString(),
            style: const TextStyle(color: Colors.grey), // Gaya subtitle
          ),
        ),
      ),
    );
  }
}
