class Stocks {
  int _id;
  String _image;
  String _name;
  String _category;
  int _xxLargeQty;
  int _xLargeQty;
  int _largeQty;
  int _mediumQty;
  int _smallQty;
  int _xSmallQty;

  Stocks(
      this._image,
      this._name,
      this._category,
      this._xxLargeQty,
      this._xLargeQty,
      this._largeQty,
      this._mediumQty,
      this._smallQty,
      this._xSmallQty);
  Stocks.withId(
      this._id,
      this._image,
      this._name,
      this._category,
      this._xxLargeQty,
      this._xLargeQty,
      this._largeQty,
      this._mediumQty,
      this._smallQty,
      this._xSmallQty);

  int get id => _id;
  String get image => _image;
  String get name => _name;
  String get category => _category;
  int get xxLargeQty => _xxLargeQty;
  int get xLargeQty => _xLargeQty;
  int get largeQty => _largeQty;
  int get mediumQty => _mediumQty;
  int get smallQty => _smallQty;
  int get xSmallQty => _xSmallQty;
  int get overAllQty =>
      _xSmallQty +
      _xxLargeQty +
      _xLargeQty +
      _largeQty +
      _mediumQty +
      _smallQty +
      _xSmallQty;

  set image(String newImage) {
    if (newImage.length <= 255) {
      _image = newImage;
    }
  }

  set name(String newName) {
    if (newName.length <= 50) {
      _name = newName;
    }
  }

  set category(String newCategory) {
    if (newCategory.length <= 255) {
      _category = newCategory;
    }
  }

  set xxLargeQty(int newXXLargeQty) {
    if (newXXLargeQty >= 0 && newXXLargeQty <= 1000) {
      _xxLargeQty = newXXLargeQty;
    }
  }

  set xLargeQty(int newXLargeQty) {
    if (newXLargeQty >= 0 && newXLargeQty <= 1000) {
      _xLargeQty = newXLargeQty;
    }
  }

  set largeQty(int newLargeQty) {
    if (newLargeQty >= 0 && newLargeQty <= 1000) {
      _largeQty = newLargeQty;
    }
  }

  set mediumQty(int newMediumQty) {
    if (newMediumQty >= 0 && newMediumQty <= 1000) {
      _mediumQty = newMediumQty;
    }
  }

  set smallQty(int newSmallQty) {
    if (newSmallQty >= 0 && newSmallQty <= 1000) {
      _smallQty = newSmallQty;
    }
  }

  set xSmallQty(int newXSmallQty) {
    if (newXSmallQty >= 0 && newXSmallQty <= 1000) {
      _xSmallQty = newXSmallQty;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['image'] = _image;
    map['name'] = _name;
    map['category'] = _category;
    map['xxLargeQty'] = _xxLargeQty;
    map['xLargeQty'] = _xLargeQty;
    map['largeQty'] = _largeQty;
    map['mediumQty'] = _mediumQty;
    map['smallQty'] = _smallQty;
    map['xSmallQty'] = _xSmallQty;

    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  Stocks.fromObject(dynamic o) {
    this._id = o['id'];
    this._image = o['image'];
    this._name = o['name'];
    this._category = o['category'];
    this._xxLargeQty = o['xxLargeQty'];
    this._xLargeQty = o['xLargeQty'];
    this._largeQty = o['largeQty'];
    this._mediumQty = o['mediumQty'];
    this._smallQty = o['smallQty'];
    this._xSmallQty = o['xSmallQty'];
  }
}
