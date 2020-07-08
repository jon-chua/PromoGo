class LocalState {

  static List<String> localOffers;

  static List<String> getOffers() {
    if (localOffers == null) {
      localOffers = new List<String>();
    }

    return localOffers;
  }

  static void addOffer(String merchantName) {
    if (localOffers == null) {
      localOffers = new List<String>();
    }
    localOffers.add(merchantName);
  }
}