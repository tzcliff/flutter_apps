import 'package:bitcoin_ticker/network_service.dart';

import 'constants.dart';

class CoinService {
  String url;
  Future<String> getCoinRate(String coinName, String currencyName) async {
    url = coinURL + '/$coinName/$currencyName?apikey=$apiKey';
    NetworkService networkService = NetworkService();
    var coinData = await networkService.getData(url);
    print(url);
    return coinData;
  }
}
