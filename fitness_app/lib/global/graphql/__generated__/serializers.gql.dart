// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart'
    show GLoginInput, GRegisterInput;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_login.data.gql.dart'
    show GLoginData, GLoginData_login, GLoginData_login_user;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_login.req.gql.dart'
    show GLoginReq;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_login.var.gql.dart'
    show GLoginVars;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.data.gql.dart'
    show GLogoutData, GLogoutData_logout, GLogoutData_logout_user;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.req.gql.dart'
    show GLogoutReq;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.var.gql.dart'
    show GLogoutVars;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_register.data.gql.dart'
    show GRegisterData, GRegisterData_logout, GRegisterData_logout_user;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_register.req.gql.dart'
    show GRegisterReq;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_register.var.gql.dart'
    show GRegisterVars;
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GLoginData,
  GLoginData_login,
  GLoginData_login_user,
  GLoginInput,
  GLoginReq,
  GLoginVars,
  GLogoutData,
  GLogoutData_logout,
  GLogoutData_logout_user,
  GLogoutReq,
  GLogoutVars,
  GRegisterData,
  GRegisterData_logout,
  GRegisterData_logout_user,
  GRegisterInput,
  GRegisterReq,
  GRegisterVars,
])
final Serializers serializers = _serializersBuilder.build();
