class CDX {
  var target_currency_name;
  var coindcx_name;
  var base_currency_short_name;
  var logo;
  var last_price;
  var change_24_hour;
  var high;
  var low;
  CDX(
      {this.target_currency_name,
      this.coindcx_name,
      this.base_currency_short_name,
      this.logo,
      this.last_price,
      this.change_24_hour,
      this.high,
      this.low});
  factory CDX.fromREST(item) {
    return CDX(
      target_currency_name: item['target_currency_name'],
      logo: 'https://coindcx.com/assets/coins/' +
          item['target_currency_name'] +
          '.svg',
      last_price: item['last_price'],
      change_24_hour: item['change_24_hour'],
      high: item['high'],
      low: item['low'],
    );
  }
}
