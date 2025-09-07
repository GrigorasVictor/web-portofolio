import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/education.dart';
import '../models/experience.dart';
import '../models/project.dart';
import '../config/app_config.dart';

class ApiService {
  // Generic fetcher: tries all base URLs, returns [] on any failure.
  Future<List<T>> _fetchList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    for (final baseUrl in AppConfig.apiBaseUrls) {
      final uri = Uri.parse('$baseUrl$endpoint');
      final sw = Stopwatch()..start();
      try {
        final resp = await http.get(uri);
        sw.stop();
        if (resp.statusCode == 200) {
          final body = utf8.decode(resp.bodyBytes);
          final decoded = json.decode(body);
          if (decoded is List) {
            return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
          } else {
            debugPrint('GET $uri -> 200 but payload not a List (elapsed ${sw.elapsedMilliseconds}ms)');
          }
        } else {
          debugPrint('GET $uri -> ${resp.statusCode} (elapsed ${sw.elapsedMilliseconds}ms)');
        }
      } catch (e) {
        sw.stop();
        debugPrint('GET $uri -> error: $e (elapsed ${sw.elapsedMilliseconds}ms)');
      }
    }
    return [];
  }

  Future<List<Education>> fetchEducation() {
    return _fetchList<Education>(
      AppConfig.educationEndpoint,
      (j) => Education.fromJson(j),
    );
  }

  Future<List<Experience>> fetchExperience() {
    return _fetchList<Experience>(
      AppConfig.experienceEndpoint,
      (j) => Experience.fromJson(j),
    );
  }

  Future<List<Project>> fetchProjects() {
    return _fetchList<Project>(
      AppConfig.projectEndpoint,
      (j) => Project.fromJson(j),
    );
  }
}