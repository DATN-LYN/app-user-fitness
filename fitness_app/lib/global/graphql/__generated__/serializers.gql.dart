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
        GUpsertExerciseInputDto,
        GUpsertInboxInputDto,
        GUpsertProgramInputDto,
        GUpsertSupportInputDto,
        GUpsertUserExerciseInputDto,
        GUpsertUserInputDto,
        GUpsertUserProgramInputDto,
        GUpsertUserStatisticsInputDto;
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
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.data.gql.dart'
    show GCategoryData;
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.req.gql.dart'
    show GCategoryReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/category_fragment.var.gql.dart'
    show GCategoryVars;
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.data.gql.dart'
    show GExerciseData, GExerciseData_program;
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.req.gql.dart'
    show GExerciseReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/exercise_fragment.var.gql.dart'
    show GExerciseVars;
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
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.data.gql.dart'
    show GProgramData;
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.req.gql.dart'
    show GProgramReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/program_fragment.var.gql.dart'
    show GProgramVars;
import 'package:fitness_app/global/graphql/fragment/__generated__/user_fragment.data.gql.dart'
    show GUserData;
import 'package:fitness_app/global/graphql/fragment/__generated__/user_fragment.req.gql.dart'
    show GUserReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/user_fragment.var.gql.dart'
    show GUserVars;
import 'package:fitness_app/global/graphql/fragment/__generated__/user_statistics_fragment.data.gql.dart'
    show GUserStatisticsData;
import 'package:fitness_app/global/graphql/fragment/__generated__/user_statistics_fragment.req.gql.dart'
    show GUserStatisticsReq;
import 'package:fitness_app/global/graphql/fragment/__generated__/user_statistics_fragment.var.gql.dart'
    show GUserStatisticsVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.data.gql.dart'
    show GUpsertInboxData, GUpsertInboxData_upsertInbox;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.req.gql.dart'
    show GUpsertInboxReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.var.gql.dart'
    show GUpsertInboxVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_program.data.gql.dart'
    show GUpsertProgramData, GUpsertProgramData_upsertProgram;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_program.req.gql.dart'
    show GUpsertProgramReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_program.var.gql.dart'
    show GUpsertProgramVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_stats.data.gql.dart'
    show GUpsertStatsData, GUpsertStatsData_upsertStats;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_stats.req.gql.dart'
    show GUpsertStatsReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_stats.var.gql.dart'
    show GUpsertStatsVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user.data.gql.dart'
    show GUpsertUserData, GUpsertUserData_upsertUser;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user.req.gql.dart'
    show GUpsertUserReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user.var.gql.dart'
    show GUpsertUserVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_exercise.data.gql.dart'
    show GUpsertUserExerciseData, GUpsertUserExerciseData_upsertUserExercise;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_exercise.req.gql.dart'
    show GUpsertUserExerciseReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_exercise.var.gql.dart'
    show GUpsertUserExerciseVars;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_program.data.gql.dart'
    show GUpsertUserProgramData, GUpsertUserProgramData_upsertUserProgram;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_program.req.gql.dart'
    show GUpsertUserProgramReq;
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user_program.var.gql.dart'
    show GUpsertUserProgramVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.data.gql.dart'
    show
        GGetCategoriesData,
        GGetCategoriesData_getCategories,
        GGetCategoriesData_getCategories_items,
        GGetCategoriesData_getCategories_meta;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.req.gql.dart'
    show GGetCategoriesReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_categories.var.gql.dart'
    show GGetCategoriesVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_category.data.gql.dart'
    show GGetCategoryData, GGetCategoryData_getCategory;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_category.req.gql.dart'
    show GGetCategoryReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_category.var.gql.dart'
    show GGetCategoryVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_current_user.data.gql.dart'
    show
        GGetCurrentUserData,
        GGetCurrentUserData_getCurrentUser,
        GGetCurrentUserData_getCurrentUser_userExercises,
        GGetCurrentUserData_getCurrentUser_userExercises_exercise,
        GGetCurrentUserData_getCurrentUser_userExercises_exercise_program,
        GGetCurrentUserData_getCurrentUser_userPrograms,
        GGetCurrentUserData_getCurrentUser_userPrograms_program;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_current_user.req.gql.dart'
    show GGetCurrentUserReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_current_user.var.gql.dart'
    show GGetCurrentUserVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercise.data.gql.dart'
    show GGetExerciseData, GGetExerciseData_getExercise;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercise.req.gql.dart'
    show GGetExerciseReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercise.var.gql.dart'
    show GGetExerciseVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercises.data.gql.dart'
    show
        GGetExercisesData,
        GGetExercisesData_getExercises,
        GGetExercisesData_getExercises_items,
        GGetExercisesData_getExercises_items_program,
        GGetExercisesData_getExercises_meta;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercises.req.gql.dart'
    show GGetExercisesReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_exercises.var.gql.dart'
    show GGetExercisesVars;
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
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.data.gql.dart'
    show
        GGetMyStatsData,
        GGetMyStatsData_getMyStats,
        GGetMyStatsData_getMyStats_items,
        GGetMyStatsData_getMyStats_meta;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.req.gql.dart'
    show GGetMyStatsReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_stats.var.gql.dart'
    show GGetMyStatsVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_program.data.gql.dart'
    show GGetProgramData, GGetProgramData_getProgram;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_program.req.gql.dart'
    show GGetProgramReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_program.var.gql.dart'
    show GGetProgramVars;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.data.gql.dart'
    show
        GGetProgramsData,
        GGetProgramsData_getPrograms,
        GGetProgramsData_getPrograms_items,
        GGetProgramsData_getPrograms_meta;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.req.gql.dart'
    show GGetProgramsReq;
import 'package:fitness_app/global/graphql/query/__generated__/query_get_programs.var.gql.dart'
    show GGetProgramsVars;
import 'package:fitness_app/global/utils/date_serializer.dart'
    show DateSerializer;
import 'package:gql_code_builder/src/serializers/operation_serializer.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..add(DateSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GCategoryData,
  GCategoryReq,
  GCategoryVars,
  GExerciseData,
  GExerciseData_program,
  GExerciseReq,
  GExerciseVars,
  GFILTER_OPERATOR,
  GFilterDto,
  GGetCategoriesData,
  GGetCategoriesData_getCategories,
  GGetCategoriesData_getCategories_items,
  GGetCategoriesData_getCategories_meta,
  GGetCategoriesReq,
  GGetCategoriesVars,
  GGetCategoryData,
  GGetCategoryData_getCategory,
  GGetCategoryReq,
  GGetCategoryVars,
  GGetCurrentUserData,
  GGetCurrentUserData_getCurrentUser,
  GGetCurrentUserData_getCurrentUser_userExercises,
  GGetCurrentUserData_getCurrentUser_userExercises_exercise,
  GGetCurrentUserData_getCurrentUser_userExercises_exercise_program,
  GGetCurrentUserData_getCurrentUser_userPrograms,
  GGetCurrentUserData_getCurrentUser_userPrograms_program,
  GGetCurrentUserReq,
  GGetCurrentUserVars,
  GGetExerciseData,
  GGetExerciseData_getExercise,
  GGetExerciseReq,
  GGetExerciseVars,
  GGetExercisesData,
  GGetExercisesData_getExercises,
  GGetExercisesData_getExercises_items,
  GGetExercisesData_getExercises_items_program,
  GGetExercisesData_getExercises_meta,
  GGetExercisesReq,
  GGetExercisesVars,
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
  GGetMyStatsData,
  GGetMyStatsData_getMyStats,
  GGetMyStatsData_getMyStats_items,
  GGetMyStatsData_getMyStats_meta,
  GGetMyStatsReq,
  GGetMyStatsVars,
  GGetProgramData,
  GGetProgramData_getProgram,
  GGetProgramReq,
  GGetProgramVars,
  GGetProgramsData,
  GGetProgramsData_getPrograms,
  GGetProgramsData_getPrograms_items,
  GGetProgramsData_getPrograms_meta,
  GGetProgramsReq,
  GGetProgramsVars,
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
  GProgramData,
  GProgramReq,
  GProgramVars,
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
  GUpsertExerciseInputDto,
  GUpsertInboxData,
  GUpsertInboxData_upsertInbox,
  GUpsertInboxInputDto,
  GUpsertInboxReq,
  GUpsertInboxVars,
  GUpsertProgramData,
  GUpsertProgramData_upsertProgram,
  GUpsertProgramInputDto,
  GUpsertProgramReq,
  GUpsertProgramVars,
  GUpsertStatsData,
  GUpsertStatsData_upsertStats,
  GUpsertStatsReq,
  GUpsertStatsVars,
  GUpsertSupportInputDto,
  GUpsertUserData,
  GUpsertUserData_upsertUser,
  GUpsertUserExerciseData,
  GUpsertUserExerciseData_upsertUserExercise,
  GUpsertUserExerciseInputDto,
  GUpsertUserExerciseReq,
  GUpsertUserExerciseVars,
  GUpsertUserInputDto,
  GUpsertUserProgramData,
  GUpsertUserProgramData_upsertUserProgram,
  GUpsertUserProgramInputDto,
  GUpsertUserProgramReq,
  GUpsertUserProgramVars,
  GUpsertUserReq,
  GUpsertUserStatisticsInputDto,
  GUpsertUserVars,
  GUserData,
  GUserReq,
  GUserStatisticsData,
  GUserStatisticsReq,
  GUserStatisticsVars,
  GUserVars,
])
final Serializers serializers = _serializersBuilder.build();
