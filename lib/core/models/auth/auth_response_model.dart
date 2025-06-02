class AuthResponseModel {
  final String email;
  final String nome;
  final List<AlunoTurma> alunoTurma;

  AuthResponseModel({
    required this.email,
    required this.nome,
    required this.alunoTurma,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      email: json['email'],
      nome: json['nome'],
      alunoTurma: (json['alunoTurma'] as List)
          .map((e) => AlunoTurma.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nome': nome,
      'alunoTurma': alunoTurma.map((e) => e.toJson()).toList(),
    };
  }
}

class AlunoTurma {
  final String curso;
  final DateTime dataMatricula;
  final String ra;
  final String turma;

  AlunoTurma({
    required this.curso,
    required this.dataMatricula,
    required this.ra,
    required this.turma,
  });

  factory AlunoTurma.fromJson(Map<String, dynamic> json) {
    return AlunoTurma(
      curso: json['curso'],
      dataMatricula: DateTime.parse(json['dataMatricula']),
      ra: json['ra'],
      turma: json['turma'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'curso': curso,
      'dataMatricula': dataMatricula.toIso8601String(),
      'ra': ra,
      'turma': turma,
    };
  }
}