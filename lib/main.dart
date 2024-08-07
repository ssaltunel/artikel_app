import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almanca Artikel Testi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _words = [
    {'word': 'Abbildung', 'article': 'die', 'meaning': 'illüstrasyon'},
    {'word': 'Abend', 'article': 'der', 'meaning': 'akşam'},
    {'word': 'Abendessen', 'article': 'das', 'meaning': 'akşam yemeği'},
  ];
  Map<String, String>? _currentWord;
  String? _selectedArticle;
  String? _feedbackMessage;
  bool _showMeaning = false;

  void _generateRandomWord() {
    setState(() {
      _currentWord = _words[
          (DateTime.now().millisecondsSinceEpoch % _words.length).toInt()];
      _selectedArticle = null;
      _feedbackMessage = null;
      _showMeaning = false;
    });
  }

  void _checkArticle(String article) {
    setState(() {
      _selectedArticle = article;
      if (_currentWord != null && _currentWord!['article'] == article) {
        _feedbackMessage = 'Doğru!';
      } else {
        _feedbackMessage = 'Yanlış! Doğru cevap: ${_currentWord?['article']}';
      }
      _showMeaning = true; // Show meaning after answering
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almanca Artikel Testi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentWord != null) ...[
              Text(
                'Kelime: ${_currentWord!['word']}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (!_showMeaning) ...[
                const Text('Artikel seçiniz:'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildArticleButton('der'),
                    const SizedBox(width: 10),
                    _buildArticleButton('die'),
                    const SizedBox(width: 10),
                    _buildArticleButton('das'),
                  ],
                ),
                const SizedBox(height: 20),
              ],
              if (_showMeaning) ...[
                Text(
                  'Anlamı: ${_currentWord!['meaning']}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Text(
                  _feedbackMessage ?? '',
                  style: TextStyle(
                      fontSize: 18,
                      color: _feedbackMessage == 'Doğru!'
                          ? Colors.green
                          : Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _generateRandomWord,
                  child: const Text('Yeni Kelime'),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildArticleButton(String article) {
    return ElevatedButton(
      onPressed: () => _checkArticle(article),
      child: Text(article),
    );
  }
}
