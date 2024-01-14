const String OPEN_AI_KEY =
    "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";

const String baseURL = "https://api.openai.com/v1";

String endPoint(String endPoint) => "$baseURL/$endPoint";

Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
