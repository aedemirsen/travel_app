class User {
  String _name, _lastName, _fullName, _phoneNum, _id, _email;

  //SETTERS
  set name(name) {
    this._name = name;
  }

  set lastname(lastName) {
    this._lastName = lastName;
  }

  set fullName(fullName) {
    this._fullName = fullName;
  }

  set phoneNum(phoneNum) {
    this._phoneNum = phoneNum;
  }

  set id(id) {
    this.id = id;
  }

  set email(email) {
    this._email = email;
  }

  //GETTERS
  String get name {
    return this._name;
  }

  String get lastName {
    return this._lastName;
  }

  String get fullName {
    return this._fullName;
  }

  String get phoneNum {
    return this._phoneNum;
  }

  String get id {
    return this._id;
  }

  String get email {
    return this._email;
  }
}
