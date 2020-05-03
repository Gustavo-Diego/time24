class Investimento {
  double dci;
  String nome;
  String vencimento;
  double valorMinimo;

  Investimento({this.dci, this.nome, this.vencimento, this.valorMinimo});

  Investimento.fromJson(Map<String, dynamic> json) {
    dci = json['dci'];
    nome = json['nome'];
    vencimento = json['vencimento'];
    valorMinimo = json['valorMinimo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dci'] = this.dci;
    data['nome'] = this.nome;
    data['vencimento'] = this.vencimento;
    data['valorMinimo'] = this.valorMinimo;
    return data;
  }
}