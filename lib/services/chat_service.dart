import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  static const String _apiKey = 'sk-3f2fe0be504e4731aca6a89fd345713f';
  static const String _baseUrl = 'https://api.deepseek.com/v1/chat/completions';

  static String _cleanupResponse(String text) {
    // Remove all non-ASCII characters except basic punctuation and newlines
    text = text.replaceAll(RegExp(r'[^\x20-\x7E\n]'), '');
    
    // Remove markdown and special formatting
    text = text.replaceAll(RegExp(r'\*+'), '');  // Remove asterisks
    text = text.replaceAll(RegExp(r'#+'), '');   // Remove hash symbols
    text = text.replaceAll('```', '');           // Remove code blocks
    text = text.replaceAll('`', '');             // Remove inline code
    text = text.replaceAll('¥', '');             // Remove yen symbol
    text = text.replaceAll('§', '');             // Remove section symbol
    
    // Fix common ASCII art issues
    List<String> lines = text.split('\n');
    List<String> cleanedLines = [];
    bool isAsciiArt = false;
    
    for (String line in lines) {
      // Detect ASCII art sections
      if (line.contains(RegExp(r'[\[\]\(\)\/\\\|\-\+\=\_\*]'))) {
        isAsciiArt = true;
      } else if (line.trim().isEmpty) {
        isAsciiArt = false;
      }
      
      String cleanedLine = line;
      
      if (isAsciiArt) {
        // For ASCII art, only allow specific characters
        cleanedLine = line.replaceAll(RegExp(r'[^A-Za-z0-9\[\]\(\)\/\\\|\-\+\=\_\*\s]'), '');
      } else {
        // For regular text, trim spaces but keep punctuation
        cleanedLine = line.trim();
      }
      
      // Remove any remaining control characters
      cleanedLine = cleanedLine.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), '');
      
      if (cleanedLine.isNotEmpty) {
        cleanedLines.add(cleanedLine);
      }
    }
    
    return cleanedLines.join('\n');
  }

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {
              'role': 'system',
              'content': '''You are an AI assistant specializing in habit formation and maintenance.
              Your task is to help users create and maintain beneficial habits.
              
              STRICT RULES FOR RESPONSES:
              1. Use only ASCII characters (a-z, A-Z, 0-9, and basic punctuation)
              2. For ASCII art, use ONLY these characters: [ ] ( ) / \\ | - + = _ *
              3. NO emojis, NO Unicode, NO special characters
              4. NO markdown formatting
              5. Keep ASCII art minimal and simple
              
              Examples of allowed ASCII art:
              
              Simple progress bar:
              [====----] 50%
              
              Simple checkbox:
              [x] Done
              [ ] Pending
              
              Simple calendar:
              [M][T][W][T][F]
              [x][x][ ][ ][ ]
              
              Simple divider:
              ---------------
              
              Remember: Keep all responses clean and simple, using only basic ASCII characters.'''
            },
            {
              'role': 'user',
              'content': message
            }
          ],
          'temperature': 0.7,
          'max_tokens': 2000,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String responseText = data['choices'][0]['message']['content'];
        return _cleanupResponse(responseText);
      } else {
        throw Exception('Failed to get response: ${response.statusCode}');
      }
    } catch (e) {
      return 'Sorry, there was an error processing your request. Please try again.';
    }
  }
} 