class Investimento {
  double cdi;
  String nome;
  String vencimento;
  double valorMinimo;

  Investimento({this.cdi, this.nome, this.vencimento, this.valorMinimo});

  Investimento.fromJson(Map<String, dynamic> json) {
    cdi = json['cdi'];
    nome = json['nome'];
    vencimento = json['vencimento'];
    valorMinimo = json['valorMinimo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cdi'] = this.cdi;
    data['nome'] = this.nome;
    data['vencimento'] = this.vencimento;
    data['valorMinimo'] = this.valorMinimo;
    return data;
  }
}