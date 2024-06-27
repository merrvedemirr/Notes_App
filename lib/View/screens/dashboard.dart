import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/View/widgets/custom_appbar.dart';
import 'package:notes_app/View/widgets/floating_button.dart';
import 'package:notes_app/View/widgets/notes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Box? noteBox;

  void boxOpen() async {
    noteBox = await Hive.openBox("notes");
    setState(() {});
  }

  @override
  void initState() {
    boxOpen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: noteBox != null
          ? StreamBuilder(
              stream: noteBox?.watch(),
              builder: (context, streamSnap) {
                return FutureBuilder(
                    future: Hive.openBox("notes"), //izlenecek future
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      // if (snapshot.hasData) {
                      //   return const Center(
                      //     child: Text("girmedi"),
                      //   );
                      // }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Icon(Icons.error),
                        );
                      }
                      final values = snapshot.data?.values.toList(); //tüm notları listeye atıyoruz.
                      values?.sort(
                          (b, a) => a["date"].compareTo(b["date"])); //tarihe göre en yeniden en eskiye sıralıyoruz
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
                          child: Column(
                            children: [
                              //*ÜST KISIM
                              CustomAppBar(values: values),

                              //*Grid kısmı paket kullandım
                              values!.isNotEmpty
                                  ? notes(values)
                                  : const Center(
                                      child: Text(
                                      "Hiç Not Yok",
                                    )),
                            ],
                          ),
                        ),
                      );
                    });
              })
          : const Center(
              child: CircularProgressIndicator(),
            ),
      //*ekle butonu
      floatingActionButton: const floatingButton(),
    );
  }
}
