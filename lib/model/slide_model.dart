class SlideModel {
  String _url;
  String _location;
  String _title, _subTitle;
  String _info;

  set url(String url) {
    this._url = url;
  }

  set location(String location) {
    this._location = location;
  }

  set title(String title) {
    this._title = title;
  }

  set subTitle(String subTitle) {
    this._subTitle = subTitle;
  }

  set info(String info) {
    this._info = info;
  }

  String get info {
    return _info;
  }

  String get url {
    return _url;
  }

  String get location {
    return _location;
  }

  String get title {
    return _title;
  }

  String get subTitle {
    return _subTitle;
  }
}
