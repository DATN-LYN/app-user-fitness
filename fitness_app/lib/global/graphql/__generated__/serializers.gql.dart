// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart'
    show
        GFILTER_OPERATOR,
        GFilterDto,
        GLoginInputDto,
        GQueryFilterDto,
        GRegisterInputDto,
        GUpsertCategoryInputDto,
        GUpsertInboxInputDto,
        GUpsertProgramInputDto;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.data.gql.dart'
    show GLogoutData, GLogoutData_logout;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.req.gql.dart'
    show GLogoutReq;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_logout.var.gql.dart'
    show GLogoutVars;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_register.data.gql.dart'
    show GRegisterData, GRegisterData_register;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_register.req.gql.dart'
    show GRegisterReq;
import 'package:fitness_app/global/graphql/auth/__generated__/mutation_register.var.gql.dart'
    show GRegisterVars;
import 'package:fitness_app/global/graphql/auth/__generated__/query_login.data.gql.dart'
    show GLoginData, GLoginData_login, GLoginData_login_user;
import 'package:fitness_app/global/graphql/auth/__generated__/query_login.req.gql.dart'
    show GLoginReq;
import 'package:fitness_app/global/graphql/auth/__generated__/query_login.var.gql.dart'
    show GLoginVars;
import 'package:fitness_app/global/graphql/auth/__generated__/query_refresh_token.data.gql.dart'
    show GRefreshTokenData, GRefreshTokenData_refreshToken;
import 'package:fitness_app/global/graphql/auth/__generated__/query_refresh_token.req.gql.dart'
    show GRefreshTokenReq;
import 'package:fitness_app/global/graphql/auth/__generated__/query_refresh_token.var.gql.dart'
    show GRefreshTokenVars;
import 'package:fitness_app/global/graphql/fragment/__generated__/inbox_fragment.data.gql.dart'
    show GInboxData, GInboxData_user;
import 'package:fitness_app/global/graphql/fragment/__generated__/inbox_fragment.req.gql.dart'
    show GInboxReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/inbox_fragment.var.gql.dart'
    show GInboxVars;
import 'package:fitness_app/global/graphql/fragment/__generated__/meta_fragment.data.gql.dart'
    show GMetaData;
import 'package:fitness_app/global/graphql/fragment/__generated__/meta_fragment.req.gql.dart'
    show GMetaReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/meta_fragment.var.gql.dart'
    show GMetaVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.data.gql.dart'
    show GUpsertInboxData, GUpsertInboxData_upsertInbox;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.req.gql.dart'
    show GUpsertInboxReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.var.gql.dart'
    show GUpsertInboxVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_inbox.data.gql.dart'
    show GGetInboxData, GGetInboxData_getInbox, GGetInboxData_getInbox_user;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_inbox.req.gql.dart'
    show GGetInboxReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_inbox.var.gql.dart'
    show GGetInboxVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_inboxes.data.gql.dart'
    show
        GGetInboxesData,
        GGetInboxesData_getInboxes,
        GGetInboxesData_getInboxes_items,
        GGetInboxesData_getInboxes_items_user,
        GGetInboxesData_getInboxes_meta;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_inboxes.req.gql.dart'
    show GGetInboxesReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_inboxes.var.gql.dart'
    show GGetInboxesVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.data.gql.dart'
    show
        GGetMyInboxesData,
        GGetMyInboxesData_getMyInboxes,
        GGetMyInboxesData_getMyInboxes_items,
        GGetMyInboxesData_getMyInboxes_items_user,
        GGetMyInboxesData_getMyInboxes_meta;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.req.gql.dart'
    show GGetMyInboxesReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.var.gql.dart'
    show GGetMyInboxesVars;
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GFILTER_OPERATOR,
  GFilterDto,
  GGetInboxData,
  GGetInboxData_getInbox,
  GGetInboxData_getInbox_user,
  GGetInboxReq,
  GGetInboxVars,
  GGetInboxesData,
  GGetInboxesData_getInboxes,
  GGetInboxesData_getInboxes_items,
  GGetInboxesData_getInboxes_items_user,
  GGetInboxesData_getInboxes_meta,
  GGetInboxesReq,
  GGetInboxesVars,
  GGetMyInboxesData,
  GGetMyInboxesData_getMyInboxes,
  GGetMyInboxesData_getMyInboxes_items,
  GGetMyInboxesData_getMyInboxes_items_user,
  GGetMyInboxesData_getMyInboxes_meta,
  GGetMyInboxesReq,
  GGetMyInboxesVars,
  GInboxData,
  GInboxData_user,
  GInboxReq,
  GInboxVars,
  GLoginData,
  GLoginData_login,
  GLoginData_login_user,
  GLoginInputDto,
  GLoginReq,
  GLoginVars,
  GLogoutData,
  GLogoutData_logout,
  GLogoutReq,
  GLogoutVars,
  GMetaData,
  GMetaReq,
  GMetaVars,
  GQueryFilterDto,
  GRefreshTokenData,
  GRefreshTokenData_refreshToken,
  GRefreshTokenReq,
  GRefreshTokenVars,
  GRegisterData,
  GRegisterData_register,
  GRegisterInputDto,
  GRegisterReq,
  GRegisterVars,
  GUpsertCategoryInputDto,
  GUpsertInboxData,
  GUpsertInboxData_upsertInbox,
  GUpsertInboxInputDto,
  GUpsertInboxReq,
  GUpsertInboxVars,
  GUpsertProgramInputDto,
])
final Serializers serializers = _serializersBuilder.build();
