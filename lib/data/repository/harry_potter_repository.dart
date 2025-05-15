import 'package:dio/dio.dart';
import 'package:harrypotter/data/models/gryffindor_model.dart';
import '../models/student_model.dart';
import '../models/staff_model.dart';

import '../models/spells_model.dart';

class HarryPotterRepository {
  final Dio _dio;
  final String _baseUrl = 'https://hp-api.onrender.com/api';

  HarryPotterRepository() : _dio = Dio();

  Future<List<Student>> getStudents() async {
    try {
      final response = await _dio.get('$_baseUrl/characters/students');
      return (response.data as List)
          .map((json) => Student.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch students: $e');
    }
  }

  Future<List<Staff>> getStaff() async {
    try {
      final response = await _dio.get('$_baseUrl/characters/staff');
      return (response.data as List)
          .map((json) => Staff.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch staff: $e');
    }
  }

  Future<List<Gryffindor>> getGryffindorStudents() async {
    try {
      final response = await _dio.get('$_baseUrl/characters/house/gryffindor');
      return (response.data as List)
          .map((json) => Gryffindor.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch Gryffindor students: $e');
    }
  }

  Future<List<Spells>> getSpells() async {
    try {
      final response = await _dio.get('$_baseUrl/spells');
      return (response.data as List)
          .map((json) => Spells.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch spells: $e');
    }
  }
}
