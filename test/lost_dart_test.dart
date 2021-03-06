//Copyright (C) 2012 Sergey Akopkokhyants. All Rights Reserved.
//Author: akserg

library lost_dart_test;

import 'dart:mirrors' as mirrors;

import 'package:unittest/unittest.dart' as ut;

import 'package:lost_dart/lost_dart.dart';

part 'test_group.dart';
part 'src/share_classes.dart';
part 'src/scope_test_group.dart';
part 'src/binder_test_group.dart';
part 'src/object_factory_test_group.dart';
part 'src/container_test_group.dart';

void main() {

  final _tList = new List<TestGroup>();
  // Event
  _tList.add(new ScopeTestGroup());
  _tList.add(new BinderTestGroup());
  _tList.add(new ObjectFactoryTestGroup());
  _tList.add(new ContainerTestGroup());

  _tList.forEach((TestGroup t){

    ut.group(t.testGroupName, (){

      t.testList.forEach((String name, Function testFunc){
        ut.test(name, testFunc);

      });
    });
  });
}