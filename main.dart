import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(HesapMakinesiUygulamasi());
}

class HesapMakinesiUygulamasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesap Makinesi',
      theme: ThemeData.dark(),
      home: HesapMakinesi(),
    );
  }
}

class HesapMakinesi extends StatefulWidget {
  @override
  _HesapMakinesiState createState() => _HesapMakinesiState();
}

class _HesapMakinesiState extends State<HesapMakinesi> {
  String _islem = "";
  String _sonuc = "0";
  String _girilenSayi = "";
  double sayi1 = 0.0;
  double sayi2 = 0.0;
  String islem = "";

  void _butonaBasildi(String butonText) {
    setState(() {
      if (butonText == "C") {
        _islem = "";
        _sonuc = "0";
        _girilenSayi = "";
        sayi1 = 0.0;
        sayi2 = 0.0;
        islem = "";
      } else if (butonText == "%" || butonText == "√") {
        if (_girilenSayi.isNotEmpty) {
          sayi1 = double.parse(_girilenSayi);
          if (butonText == "%") {
            _sonuc = (sayi1 / 100).toString();
          } else if (butonText == "√") {
            _sonuc = (math.sqrt(sayi1)).toString();
          }
          _islem = butonText == "%" ? "$sayi1%" : "√$sayi1";
          _girilenSayi = _sonuc;
        }
      } else if (butonText == "+" || butonText == "-" || butonText == "X" || butonText == "÷") {
        if (_girilenSayi.isNotEmpty) {
          sayi1 = double.parse(_girilenSayi);
          islem = butonText;
          _islem += _girilenSayi + butonText;
          _girilenSayi = "";
        }
      } else if (butonText == "=") {
        if (_girilenSayi.isNotEmpty && islem.isNotEmpty) {
          sayi2 = double.parse(_girilenSayi);
          if (islem == "+") {
            _sonuc = (sayi1 + sayi2).toString();
          } else if (islem == "-") {
            _sonuc = (sayi1 - sayi2).toString();
          } else if (islem == "X") {
            _sonuc = (sayi1 * sayi2).toString();
          } else if (islem == "÷") {
            _sonuc = sayi2 != 0 ? (sayi1 / sayi2).toString() : "Tanımsız";
          }
          _islem += _girilenSayi + "=";
          _girilenSayi = _sonuc;
          sayi1 = 0.0;
          sayi2 = 0.0;
          islem = "";
        }
      } else {
        _girilenSayi += butonText;
        _sonuc = _girilenSayi;
      }
    });
  }

  Widget _butonOlustur(String butonText, {Color textColor = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: _butonRengiSec(butonText),
            side: BorderSide(color: Colors.blue, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(24.0),
          ),
          onPressed: () => _butonaBasildi(butonText),
          child: Text(
            butonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Color _butonRengiSec(String butonText) {
    if (double.tryParse(butonText) != null) {
      return Colors.grey.shade200;
    } else {
      switch (butonText) {
        case '+':
        case '-':
        case 'X':
        case '÷':
        case '%':
        case '√':
          return Colors.blueAccent;
        case '=':
          return Colors.greenAccent;
        case 'C':
          return Colors.redAccent;
        default:
          return Colors.grey.shade200;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Hesap Makinesi'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _islem,
                style: const TextStyle(fontSize: 20.0, color: Colors.white70),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _sonuc,
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _butonOlustur("%"),
                    _butonOlustur("√"),
                    _butonOlustur("X"),
                    _butonOlustur("÷"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _butonOlustur("7"),
                    _butonOlustur("8"),
                    _butonOlustur("9"),
                    _butonOlustur("-"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _butonOlustur("4"),
                    _butonOlustur("5"),
                    _butonOlustur("6"),
                    _butonOlustur("+"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _butonOlustur("1"),
                    _butonOlustur("2"),
                    _butonOlustur("3"),
                    _butonOlustur("="),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _butonOlustur("0"),
                    _butonOlustur("."),
                    _butonOlustur("C"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
