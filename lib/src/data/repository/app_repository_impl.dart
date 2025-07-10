import "dart:convert";
import "dart:developer";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:ibrat_debate_scanner_app/src/data/entity/user_model/user_model.dart";
import "../../common/server/api/api.dart";
import "../../common/server/api/api_constants.dart";

import "../entity/debate_models/debate_event_response_model.dart";
import "../entity/login_models/login_response_model.dart";
import "../entity/login_models/user_login_model.dart";
import "../entity/ticket_model/ticket_model.dart";
import "app_repository.dart";

@immutable
final class AppRepositoryImpl implements AppRepository {
  factory AppRepositoryImpl() => _impl;

  const AppRepositoryImpl._internal();

  static const AppRepositoryImpl _impl = AppRepositoryImpl._internal();

  @override
  Future<LoginResponseModel?> loginUser({required UserLoginModel user}) async {
    final String? str = await ApiService.post(ApiConst.loginApi, user.toJson());
    if (str != null) {
      log(str);
      return LoginResponseModel.fromJson(jsonDecode(str));
    } else {
      return null;
    }
  }

  @override
  Future<DebateEventResponse?> getDebateEvents({
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async {
    try {
      // TODO: Implement pagination later

      // final Map<String, dynamic> queryParams = <String, dynamic>{};
      //
      // // Pagination parameters (commented out for now)
      // // queryParams['page'] = page.toString();
      // // queryParams['page_size'] = pageSize.toString();
      //
      // if (searchQuery != null && searchQuery.isNotEmpty) {
      //   queryParams['search'] = searchQuery;
      // }

      String url = ApiConst.debatesApi;

      // if (queryParams.isNotEmpty) {
      //   final String queryString = queryParams.entries
      //       .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
      //       .join('&');
      //   url = '$url?$queryString';
      // }

      final String? response = await ApiService.get(
        url,
        ApiParams.emptyParams(),
      );

      if (response != null) {
        log('Debate events response: $response');
        final Map<String, dynamic> jsonResponse = jsonDecode(response);
        return DebateEventResponse.fromJson(jsonResponse);
      } else {
        log('Failed to get debate events: response is null');
        return null;
      }
    } catch (e, stackTrace) {
      log('Error getting debate events: $e', stackTrace: stackTrace);
      return null;
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      debugPrint('🔍 Fetching current user info...');

      final response = await ApiService.get(
        ApiConst.meApi,
        <String, dynamic>{}, // empty params
      );

      if (response == null) {
        debugPrint('❌ No response received from user API');
        return null;
      }

      debugPrint('✅ User API response received');
      debugPrint('📄 Response data: $response');

      final Map<String, dynamic> jsonData = jsonDecode(response);

      final user = UserModel.fromJson(jsonData);
      debugPrint('👤 User parsed successfully: $user');

      return user;
    } catch (e, stackTrace) {
      debugPrint('❌ Error fetching current user: $e');
      debugPrint('📍 Stack trace: $stackTrace');
      return null;
    }
  }

  // 🆕 NEW: Update user information
  @override
  Future<UserModel?> updateUserInfo(UserModel updatedUser) async {
    try {
      debugPrint('🔄 Updating user info...');
      debugPrint('📝 Updated user data: $updatedUser');

      // Convert UserModel to JSON map for API call
      final Map<String, dynamic> updateData = {
        if (updatedUser.name != null) 'name': updatedUser.name,
        if (updatedUser.phone != null) 'phone': updatedUser.phone,
        if (updatedUser.age != null) 'age': updatedUser.age,
        if (updatedUser.englishLevel != null)
          'english_level': updatedUser.englishLevel,
      };

      debugPrint('📤 Sending PATCH request with data: $updateData');

      final response = await ApiService.patch(
        ApiConst
            .meApi, // assuming we patch to the same endpoint as getCurrentUser
        updateData,
      );

      if (response != null && response.isNotEmpty) {
        debugPrint('✅ User update response received');
        debugPrint('📄 Response data: $response');

        final Map<String, dynamic> jsonData = jsonDecode(response);
        final updatedUserModel = UserModel.fromJson(jsonData);

        debugPrint('👤 User updated successfully: $updatedUserModel');
        return updatedUserModel;
      } else {
        debugPrint('❌ Failed to update user: empty response');
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error updating user info: $e');
      debugPrint('📍 Stack trace: $stackTrace');
      return null;
    }
  }

  // Get ticket by ID
  @override
  Future<TicketModel?> getTicketById(String ticketId) async {
    try {
      log('🎫 Getting ticket by ID: $ticketId');

      final response = await ApiService.get(
        "${ApiConst.ticketsApi}/$ticketId/",
        ApiParams.emptyParams(),
      );

      if (response != null && response.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(response);
        log('✅ Ticket data received: $data');

        return TicketModel.fromJson(data);
      } else {
        log('❌ Failed to get ticket: $response');
        throw Exception('Failed to get ticket: $response');
      }
    } catch (e) {
      log('❌ Error getting ticket: $e');
      throw Exception('Error getting ticket: $e');
    }
  }

  // Get user details by user ID
  @override
  Future<UserModel?> getUserById(String userId) async {
    try {
      log('👤 Getting user by ID: $userId');

      final response = await ApiService.get(
        "${ApiConst.users}/$userId/",
        ApiParams.emptyParams(),
      );

      if (response != null && response.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(response);
        log('✅ User data received: $data');

        return UserModel.fromJson(data);
      } else {
        log('❌ Failed to get user: $response ');
        throw Exception('Failed to get user: $response');
      }
    } catch (e) {
      log('❌ Error getting user: $e');
      throw Exception('Error getting user: $e');
    }
  }

  // Mark ticket as checked
  @override
  Future<TicketModel?> markTicketAsChecked(String ticketId) async {
    try {
      log('✅ Marking ticket as checked: $ticketId');

      final response = await ApiService.patch(
        "${ApiConst.ticketsApi}/$ticketId/",
        {'is_checked': true},
      );

      if (response != null && response.isNotEmpty) {
        final Map<String, dynamic> data = jsonDecode(response);
        log('✅ Ticket marked as checked: $data');

        return TicketModel.fromJson(data);
      } else {
        log('❌ Failed to mark ticket as checked: $response');
        throw Exception('Failed to mark ticket as checked: $response');
      }
    } catch (e) {
      log('❌ Error marking ticket as checked: $e');
      throw Exception('Error marking ticket as checked: $e');
    }
  }
}
