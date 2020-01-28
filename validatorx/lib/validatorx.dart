library validatorx;

import 'package:validators/validators.dart' as validator;
import 'dart:convert';

extension ValidatorStringX<T extends String> on T {
  //bool equals(comparison) {
  //  return validator.equals(this);
  //}
  //bool contains(seed) {
  //  return validator.contains(this);
  //}
  //bool matches(pattern) {
  //  return validator.matches(this);
  //}

  bool isEmail() {
    return validator.isEmail(this);
  }

  bool isURL({
     List<String> protocols = const ['http', 'https', 'ftp'],
     bool requireTld = true,
     bool requireProtocol = false,
     bool allowUnderscore = false,
     List<String> hostWhitelist = const [],
     List<String> hostBlacklist = const []}) {
    return validator.isURL(this,
      protocols: protocols,
      requireTld: requireTld,
      requireProtocol: requireProtocol,
      allowUnderscore: allowUnderscore,
      hostWhitelist: hostWhitelist,
      hostBlacklist: hostBlacklist
    );
  }

  bool isIP(String str, [String version]) {
    return validator.isIP(this, version);
  }

  //bool isIpByInt(int version) {
  //  return isIP(this, version.toString());
  //}

  bool isFQDN({bool requireTld = true, bool allowUnderscores = false}) {
    return validator.isFQDN(this,
      requireTld: requireTld,
      allowUnderscores: allowUnderscores
    );
  }

  bool isAlpha() {
    return validator.isAlpha(this);
  }

  bool isNumeric() {
    return validator.isNumeric(this);
  }

  bool isAlphanumeric() {
    return validator.isAlphanumeric(this);
  }

  bool isBase64() {
    return validator.isBase64(this);
  }

  bool isInt() {
    return validator.isInt(this);
  }

  bool isFloat() {
    return validator.isFloat(this);
  }

  bool isHexadecimal() {
    return validator.isHexadecimal(this);
  }

  bool isHexColor() {
    return validator.isHexColor(this);
  }

  bool isLowercase() {
    return validator.isLowercase(this);
  }

  bool isUppercase() {
    return validator.isUppercase(this);
  }

  bool isDivisibleBy(num n) {
    return validator.isDivisibleBy(this, n);
  }

  bool isNull() {
    return validator.isNull(this);
  }

  bool isLength(int min, [int max]) {
    return validator.isLength(this, min, max);
  }

  bool isByteLength(int min, [int max]) {
    return validator.isByteLength(this, min, max);
  }

  bool isUUID([version]) {
    return validator.isUUID(this);
  }

  bool isDate() {
    return validator.isDate(this);
  }

  bool isAfter([date]) {
    return validator.isAfter(this);
  }

  bool isBefore([date]) {
    return validator.isBefore(this);
  }

  bool isIn(values) {
    return validator.isIn(this, values);
  }

  bool isCreditCard() {
    return validator.isCreditCard(this);
  }

  bool isISBN([version]) {
    return validator.isISBN(this, version);
  }

  bool isJson() {
    return jsonDecode(this);
  }

  bool isJsonOrNull() {
    try {
      return isJson();
    } on FormatException {
      return null;
    } 
  }

  bool isMultibyte() {
    return validator.isMultibyte(this);
  }

  bool isAscii() {
    return validator.isAscii(this);
  }

  bool isFullWidth() {
    return validator.isFullWidth(this);
  }

  bool isHalfWidth() {
    return validator.isHalfWidth(this);
  }

  bool isVariableWidth() {
    return validator.isVariableWidth(this);
  }

  bool isSurrogatePair() {
    return validator.isSurrogatePair(this);
  }

  bool isMongoId() {
    return validator.isMongoId(this);
  }

  bool isVIN() {
    return validator.isVIN(this);
  }

  bool isPostalCode(String locale) => validator.isPostalCode(this, locale);

  bool isPostalCodeOrNull(String locale) {
    try {
      return isPostalCode(locale);
    } on FormatException {
      return null;
    }
  }

}