import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
static Future<List<Map<String, dynamic>>> fetchQuestions({int amount = 10}) async {
final url = Uri.parse('https://opentdb.com/api_config.php');
final res = await http.get(url);
final data = jsonDecode(res.body);
final List results = data['results'] ?? [];
return results.map<Map<String, dynamic>>((q) {
final question = q['question'] as String? ?? '';
final correct = q['correct_answer'] as String? ?? '';
final incorrect = List<String>.from(q['incorrect_answers'] ?? []);
final options = <String>[]..addAll(incorrect)..add(correct);
options.shuffle();
return {'question': htmlUnescape(question), 'options': options.map(htmlUnescape).toList(), 'correct': htmlUnescape(correct)};
}).toList();
}


static String htmlUnescape(String input) {
return input.replaceAll('&quot;', '"').replaceAll('&#039;', "'").replaceAll('&amp;', '&').replaceAll('&rsquo;', "'").replaceAll('&ldquo;', '"').replaceAll('&rdquo;', '"').replaceAll('&eacute;', 'e');
}
}