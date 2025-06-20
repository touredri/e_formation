import 'package:flutter/material.dart';
import '../../../data/models/models.dart';
import '../../../data/services/api.dart';
import 'dart:convert';

class QuizView extends StatefulWidget {
  final String formationId;
  const QuizView({Key? key, required this.formationId}) : super(key: key);

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  List<Quiz> questions = [];
  int current = 0;
  int score = 0;
  bool loading = true;
  bool finished = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  Future<void> fetchQuiz() async {
    setState(() {
      loading = true;
      error = null;
    });
    try {
      final response = await ApiService.getFormationDetails(widget.formationId);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['quiz'] != null) {
          questions = List<Map<String, dynamic>>.from(
            data['quiz'],
          ).map((e) => Quiz.fromJson(e)).toList();
        }
      } else {
        error = 'Erreur lors du chargement du quiz';
      }
    } catch (e) {
      error = 'Erreur de connexion';
    }
    setState(() {
      loading = false;
    });
  }

  void submitAnswer(String answer) {
    if (questions[current].bonneReponse == answer) {
      score++;
    }
    if (current < questions.length - 1) {
      setState(() {
        current++;
      });
    } else {
      setState(() {
        finished = true;
      });
      // TODO: Envoyer le score à l'API pour obtenir le certificat si score >= 70%
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text(error!));
    if (questions.isEmpty)
      return const Center(child: Text('Aucun quiz disponible.'));
    if (finished) {
      final percent = (score / questions.length) * 100;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score : $score / ${questions.length}'),
            Text('Pourcentage : ${percent.toStringAsFixed(1)}%'),
            if (percent >= 70)
              const Text(
                'Félicitations, vous avez obtenu le certificat !',
                style: TextStyle(color: Colors.green),
              ),
            if (percent < 70)
              const Text(
                'Vous n\'avez pas obtenu le certificat.',
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Retour'),
            ),
          ],
        ),
      );
    }
    final q = questions[current];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question ${current + 1} / ${questions.length}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Text(q.question, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 24),
          ...['A', 'B', 'C', 'D'].map(
            (opt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                onPressed: () => submitAnswer(opt),
                child: Text('Réponse $opt'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
