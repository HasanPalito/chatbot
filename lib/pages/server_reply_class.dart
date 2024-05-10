import 'dart:convert';

class ServerReply {
  String id;
  String object;
  int created;
  String model;
  String provider;
  List<Choice> choices;
  Usage usage;

  ServerReply({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.provider,
    required this.choices,
    required this.usage,
  });

  factory ServerReply.fromRawJson(String str) => ServerReply.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServerReply.fromJson(Map<String, dynamic> json) => ServerReply(
    id: json["id"],
    object: json["object"],
    created: json["created"],
    model: json["model"],
    provider: json["provider"],
    choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    usage: Usage.fromJson(json["usage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "object": object,
    "created": created,
    "model": model,
    "provider": provider,
    "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    "usage": usage.toJson(),
  };
}

class Choice {
  int index;
  Message message;
  String finishReason;

  Choice({
    required this.index,
    required this.message,
    required this.finishReason,
  });

  factory Choice.fromRawJson(String str) => Choice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
    index: json["index"],
    message: Message.fromJson(json["message"]),
    finishReason: json["finish_reason"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "message": message.toJson(),
    "finish_reason": finishReason,
  };
}

class Message {
  String role;
  String content;

  Message({
    required this.role,
    required this.content,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    role: json["role"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "content": content,
  };
}

class Usage {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromRawJson(String str) => Usage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    promptTokens: json["prompt_tokens"],
    completionTokens: json["completion_tokens"],
    totalTokens: json["total_tokens"],
  );

  Map<String, dynamic> toJson() => {
    "prompt_tokens": promptTokens,
    "completion_tokens": completionTokens,
    "total_tokens": totalTokens,
  };
}
