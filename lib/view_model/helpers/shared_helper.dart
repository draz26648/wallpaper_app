import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/model/models/base_models/photos.dart';

//this abstract class is used to initial enum with T unknown type i will be known after the initialization
abstract class Enum<T> {
  final T _value;

  const Enum(this._value);

  T get value => _value;
}

// caching key class for shared preferences keys it extends enum with string type to initialize key with string
class CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);
  static const CachingKey download = const CachingKey('download');
  static const CachingKey favorite = const CachingKey('favorite');
}

class SharedHelper {
  late SharedPreferences _shared;

// this method will be used to save favorite photos to shared preferences in list of strings
  writeFavorites(CachingKey key, value) async {
    _shared = await SharedPreferences.getInstance();
    List<String> values = _shared.getStringList(key.value) ?? [];
    if (!values.contains(value)) {
      values.add(value);
      print("Saving >>> $value local >>> with key ${key.value}");
      Fluttertoast.showToast(msg: 'Added to favorites');
    } else {
      print('already exists');
      values.remove(value);
      Fluttertoast.showToast(msg: 'Removed from favorites');
    }

    _shared.setStringList(key.value, values);
  }

  // this method will be used to get favorite photos from shared preferences in list of strings
  readFavorites(CachingKey key) async {
    _shared = await SharedPreferences.getInstance();
    List<String> values = _shared.getStringList(key.value) ?? [];
    print("Reading >>> ${values} local >>> with key ${key.value}");
    return values;
  }
}
