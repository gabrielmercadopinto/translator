// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String translated = "";
  final Map<String, String> languages = {
    'en': 'Inglés',
    'es': 'Español',
    'fr': 'Francés',
    'de': 'Alemán',
    'it': 'Italiano',
    'pt': 'Portugués',
    'ja': 'Japonés',
    'ko': 'Coreano',
    'ar': 'Árabe',
    'ru': 'Ruso',
    'hi': 'Hindi',
    'bn': 'Bengalí',
    'zh-cn': 'Chino',
    'ca': 'Catalán',
    'hr': 'Croata',
    'gn': 'Guaraní',
    'la': 'Latín'
  };
  String fromSelectedLanguage = 'es';
  String toSelectedLanguage = 'en';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Translator'),
          centerTitle: true,
        ),
        body: Card(
          margin: const EdgeInsets.all(8),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(
                    value: fromSelectedLanguage,
                    items: languages.entries.map<DropdownMenuItem<String>>((MapEntry<String, String> entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                    }).toList(),
                    onChanged: (selected) async {
                      setState(() {
                        fromSelectedLanguage = selected!;
                        print(fromSelectedLanguage);
                      });
                      if(translated.isNotEmpty){
                        final translation = await translated.translate(
                          from: fromSelectedLanguage,
                          to: toSelectedLanguage
                        );
                        setState(() {
                          print("traducir!");
                          translated = translation.text;
                          print(translated);
                        });
                      }else{
                        setState(() {
                          print("no traducir!");
                          translated = '';
                          print(translated);
                        });
                      }
                    }
                  ),
                  const SizedBox(width: 5,),
                  const Text('to'),
                  const SizedBox(width: 5,),
                  DropdownButton(
                    value: toSelectedLanguage,
                    items: languages.entries.map<DropdownMenuItem<String>>((MapEntry<String, String> entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                    }).toList(),
                    onChanged: (selected) async {
                      setState(() {
                        toSelectedLanguage = selected!;
                        print(toSelectedLanguage);
                      });
                      if(translated.isNotEmpty){
                        final translation = await translated.translate(
                          from: fromSelectedLanguage,
                          to: toSelectedLanguage
                        );
                        setState(() {
                          print("traducir!");
                          translated = translation.text;
                          print(translated);
                        });
                      }else{
                        setState(() {
                          print('no traducir!');
                          translated = '';
                        });
                      }
                    }
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 36,
                ),
                decoration: const InputDecoration(
                    hintText: 'Enter text',
                    hintStyle: TextStyle(fontWeight: FontWeight.w300)),
                onChanged: (text) async {
                  if(text.isNotEmpty){
                    final translation = await text.translate(
                      from: fromSelectedLanguage,
                      to: toSelectedLanguage
                    );
                    setState(() {
                      print("traducir!");
                      translated = translation.text;
                      print(translated);
                    });
                  }else{
                    setState(() {
                      print("no traducir!");
                      translated = '';
                      print(translated);
                    });
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                translated,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ));
  }
}
