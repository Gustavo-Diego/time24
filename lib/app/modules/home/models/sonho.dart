class Sonho {
  String nome;
  String imagem;
  int valorAcumulo;
  int valorEstipulado;

  Sonho({this.nome, this.imagem, this.valorAcumulo, this.valorEstipulado});

  Sonho.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    imagem = json['imagem'];
    valorAcumulo = json['valorAcumulo'];
    valorEstipulado = json['valorEstipulado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['valorAcumulo'] = this.valorAcumulo;
    data['valorEstipulado'] = this.valorEstipulado;
    return data;
  }
}