class Merchant {
  final String name;
  final String latitude;
  final String longitude;
  final String address;
  final String postalCode;
  final String city;
  final String visaStoreId;
  final String visaMerchantId;
  final String url;

  Merchant({
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.name,
    this.postalCode,
    this.url,
    this.visaMerchantId,
    this.visaStoreId,
  });

  void printAll() {
    print(address);
    print(city);
    print(latitude);
    print(longitude);
    print(name);
    print(postalCode);
    print(url);
    print(visaMerchantId);
    print(visaStoreId);
  }

}
