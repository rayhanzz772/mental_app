const String OPEN_AI_KEY =
    "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";

const String baseURL = "https://api.openai.com/v1";

String endPoint(String endPoint) => "$baseURL/$endPoint";

Map<String, String> headerBearerOption(String token) => {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

enum ApiState { loading, success, error, notFound }
