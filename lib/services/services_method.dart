import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:icooker/config/Config.dart';

import '../http/http_manager.dart';

/// 根据url和data获取服务器数据
Future getDataFromServer(var url, {var data}) async {
  Response response;
  response = await HttpManager.getInstance().post(url, data: data);
  if (response.statusCode == 200) {
    var ret = json.decode(response.data)['data'];
    print('ret--->$ret');
    return ret;
  } else {
    throw Exception('服务器接口有问题!');
  }
}

/// 获取首页推荐数据

Future getHomeRecommend() async {
  Response response;
  response =
      await HttpManager.getInstance().post(Config.INDEX_HOME_RECOMMEND_URL);
  if (response.statusCode == 200) {
    print(json.decode(response.data));
    return json.decode(response.data)['data'] as List;
  } else {
    throw Exception('服务器接口有问题!');
  }
}

/// 获取首页展示数据

Future getFoodSetData(data) async {
  Response response;
  List _dataList = [];
  var type = data['type'];
  var url = type.isEmpty
      ? Config.INDEX_HOME_FEEDS_URL
      : Config.INDEX_HOME_FEEDS_CLASSIFY;

  response = await HttpManager.getInstance().post(url, data: data);
  if (response.statusCode == 200) {
    List tempList = json.decode(response.data)['data']['items'] as List;
    // print('tempList--->$tempList');
    tempList.forEach((val) {
      if (val.containsKey('recipe') ||
          // val.containsKey('works') ||
          val.containsKey('video_recipe') ||
          val.containsKey('video_article')) {
        _dataList.add(val);
      }
    });
    // print('dataList--->$_dataList');
    return _dataList;
  } else {
    throw Exception('服务器接口有问题!');
  }
}

//获取食秀界面的Tab
Future getFoodShowTab(var type) async {
  Response response;
  response = await HttpManager.getInstance()
      .post(Config.FOOD_SHOW_TAB_URL, data: {'type': type});
  List _dataList = json.decode(response.data)['data']['item'] as List;
  return _dataList;
}

/// 获取健康饮食数据
Future getHealthEatData() async {
  Response response;
  var url = Config.HEATH_EAT_URL;
  response = await HttpManager.getInstance().post(url);
  if (response.statusCode == 200) {
    var ret = json.decode(response.data)['data'];
    print('ret--->$ret');
    return ret;
  } else {
    throw Exception('服务器接口有问题!');
  }
}



