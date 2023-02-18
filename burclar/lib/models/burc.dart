class Burc {
  final String _burcAdi;
  final String _burcTarihi;
  final String _burcDetay;
  final String _imgKucuk;
  final String _imgBuyuk;

  Burc(this._burcAdi, this._burcTarihi, this._burcDetay, this._imgKucuk,
      this._imgBuyuk);

  get getBurcAdi {
    return this._burcAdi;
  }

  get getBurcTarihi {
    return this._burcTarihi;
  }

  get getBurcDetay {
    return this._burcDetay;
  }

  get getBurcImgKucuk {
    return this._imgKucuk;
  }

  get getBurcImgBuyuk {
    return this._imgBuyuk;
  }

  @override
  String toString() {
    return "$_burcAdi tarihleri arasında $_burcTarihi";
  }
}
