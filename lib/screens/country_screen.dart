import 'package:flutter/material.dart';
import 'package:my_sports_app/screens/competitions_screen.dart';
import 'package:my_sports_app/widgets/country_card.dart';
import '../models/sport.dart';
import '../services/api_service.dart';

class CountrySelectionScreen extends StatefulWidget {
  final Sport sport;

  const CountrySelectionScreen({super.key, required this.sport});

  @override
  _CountrySelectionScreenState createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCountriesMock();
    _searchController.addListener(_filterCountries);
  }

  /*Future<void> _loadCountries() async {
    try {
      final countries = await ApiService.fetchCountries(widget.sport.name);
      setState(() {
        _countries = countries;
        _filteredCountries = countries;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Laden der Länder: $e')),
      );
    }
  }*/

  Future<void> _loadCountriesMock() async {
    // Mock-Daten für Länder
    await Future.delayed(const Duration(seconds: 1)); // Simuliere Netzwerkverzögerung
    setState(() {
      _countries = [
        Country(apiName: 'Germany', name: 'Germany', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/Germany.png'),
        Country(apiName: 'Austria', name: 'Austria', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/Austria.png'),
        Country(apiName: 'Switzerland', name: 'Switzerland', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/Switzerland.png'),
        Country(apiName: 'France', name: 'France', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/France.png'),
        Country(apiName: 'Spain', name: 'Spain', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/Spain.png'),
        Country(apiName: 'Italy', name: 'Italy', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/Italy.png'),
        Country(apiName: 'USA', name: 'USA', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/USA.png'),
        Country(apiName: 'Canada', name: 'Canada', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/Canada.png'),
        Country(apiName: 'England', name: 'England', flagUrl: 'https://www.thesportsdb.com/images/icons/flags/shiny/32/England.png')
      ];
      _filteredCountries = _countries;
      _isLoading = false;
    });
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = _countries.where((country) =>
          country.name.toLowerCase().contains(query)).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country - ${widget.sport.name}'),
        backgroundColor: const Color.fromRGBO(255, 135, 83, 1),
      ),
      body: Column(
        children: [
          // Suchfeld
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Country...',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.grey[900] 
                  : Colors.grey[200],
              ),
            ),
          ),
          // Länder-Liste
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCountries.isEmpty
                    ? const Center(
                        child: Text(
                          'No countries found',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = _filteredCountries[index];
                          return CountryCard(
                            country: country,
                            onTap: () async {
                              // Ligen für Sport und Land laden
                              try {

                                final competitions = await ApiService.fetchCompetitions(
                                  widget.sport.apiName!,
                                  country.apiName,
                                );

                                Navigator.pop(context); // Loading dialog schließen

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompetitionsScreen(
                                      sport: widget.sport,
                                      country: country,
                                      competitions: competitions,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                Navigator.pop(context); // Loading dialog schließen
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to load Leagues: $e')),
                                );
                              }
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}