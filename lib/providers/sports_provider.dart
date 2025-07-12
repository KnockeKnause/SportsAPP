import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/sport.dart';

class SportsProvider extends ChangeNotifier {
  List<Sport> _sports = [];
  bool _isLoading = false;
  String? _error;

  List<Sport> get sports => _sports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  SportsProvider() {
    _loadSports();
  }

  // Mock data for demonstration - replace with real API calls
  void _loadSports() {
    _sports = [
      Sport(id: '1', apiName: 'Soccer', name: 'Football', competitions:[], format: 'Team'),
      Sport(id: '2', apiName: 'Tennis', name: 'Tennis', competitions:[], format: 'Player'),
      Sport(id: '4', apiName: 'Basketball',name: 'Basketball', competitions:[],format: 'Team'),
      Sport(id: '5', apiName: 'Spikeball',name: 'Spikeball', competitions:[],format: 'Player'),
      Sport(id: '6', apiName: 'Rugby',name: 'Rugby', competitions:[], format: 'Team'),
      Sport(id: '7', apiName: 'Baseball',name: 'Baseball', competitions:[], format: 'Team'),
      Sport(id: '8', apiName: 'Formel 1',name: 'Formel 1', competitions:[], format: 'Player'),
      Sport(id: '9', apiName: 'Handball',name: 'Handball', competitions:[], format: 'Team'),
      Sport(id: '10', apiName: 'American Football',name: 'American Football', competitions:[], format: 'Team'),
      Sport(id: '11', apiName: 'Volleyball',name: 'Volleyball', competitions:[], format: 'Team'),
    ];
    notifyListeners();
  }
}