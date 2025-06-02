import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/sport.dart';

class DetailScreen extends StatefulWidget {
  final Team team;

  const DetailScreen({super.key, required this.team});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Details? lastMatch;
  Details? nextMatch;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTeamResults();
  }

  Future<void> _loadTeamResults() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Beide API-Aufrufe parallel ausführen
      final results = await Future.wait([
        _fetchLastMatch(),
        _fetchNextMatch(),
      ]);

      setState(() {
        lastMatch = results[0];
        nextMatch = results[1];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
        isLoading = false;
      });
    }
  }

  Future<Details?> _fetchLastMatch() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.thesportsdb.com/api/v1/json/123/eventslast.php?id=${widget.team.id}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final events = data['results'] as List?;
        
        if (events != null && events.isNotEmpty) {
          return Details.fromJson(events.first);
        }
      }
    } catch (e) {
      print('Error fetching last match: $e');
    }
    return null;
  }

  Future<Details?> _fetchNextMatch() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.thesportsdb.com/api/v1/json/123/eventsnext.php?id=${widget.team.id}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final events = data['events'] as List?;
        
        if (events != null && events.isNotEmpty) {
          return Details.fromJson(events.first);
        }
      }
    } catch (e) {
      print('Error fetching next match: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? _buildErrorWidget()
              : _buildResultsContent(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadTeamResults,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsContent() {
    return RefreshIndicator(
      onRefresh: _loadTeamResults,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team Header
            _buildTeamHeader(),
            const SizedBox(height: 24),
            
            // Last Match Section
            _buildMatchSection(
              title: 'Last Game',
              icon: Icons.history,
              match: lastMatch,
              showScore: true,
            ),
            const SizedBox(height: 24),
            
            // Next Match Section
            _buildMatchSection(
              title: 'Next Game',
              icon: Icons.schedule,
              match: nextMatch,
              showScore: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              child: widget.team.logoUrl != null && widget.team.logoUrl!.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        widget.team.logoUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Text(widget.team.name.substring(0, 1).toUpperCase()),
                      ),
                    )
                  : Text(
                      widget.team.name.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.team.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchSection({
    required String title,
    required IconData icon,
    required Details? match,
    required bool showScore,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: match != null
              ? _buildMatchCard(match, showScore)
              : _buildNoMatchCard(),
        ),
      ],
    );
  }

  Widget _buildMatchCard(Details match, bool showScore) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // League and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  match.strLeague ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${match.dateEvent} ${match.strTimeLocal}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Teams and Score
          Row(
            children: [
              // Home Team
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.strHomeTeam?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('(Home)', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              
              // Score or VS
              if (showScore && match.intHomeScore != null && match.intAwayScore != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${match.intHomeScore} : ${match.intAwayScore}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'VS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              
              // Away Team
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      match.strAwayTeam?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const Text('(Away)', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoMatchCard() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No matches available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}