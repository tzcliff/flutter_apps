import 'package:bitcoin_ticker/coin_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'coin_data.dart';

import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String rate = '?';
  String selectedCurrency = 'AUD';
  Map coinValues = {};

  bool isWaiting = false;
  List<Widget> getCardsList(String currency) {
    List<Widget> results = [];
    for (String str in cryptoList) {
      results.add(CryptoCard(
          cryptoCoin: str,
          selectedCurrency: currency,
          rate: isWaiting ? '?' : coinValues[str]));
    }
    return results;
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String str in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(str),
        value: str,
      ));
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData(selectedCurrency);
          });
          print(value);
        });
  }

  void getData(String currencyName) async {
    isWaiting = true;
    CoinService coinService = CoinService();
    for (String str in cryptoList) {
      var coinData = await coinService.getCoinRate(str, currencyName);
      if (coinData != null) {
        var data = jsonDecode(coinData);
        double price = data['rate'];
        setState(() {
          coinValues[str] = price.toStringAsFixed(0);
        });
      }
    }
    isWaiting = false;
  }

  @override
  void initState() {
    getData(selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCardsList(selectedCurrency),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.rate,
    @required this.selectedCurrency,
    this.cryptoCoin,
  });

  final String rate;
  final String selectedCurrency;
  final String cryptoCoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCoin = $rate $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
