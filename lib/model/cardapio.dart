class Cardapio {
  int id;
  String nome;
  String valor;
  String quantidade;
  String unidade;
  String descricao;
  String texto;

  Cardapio(
    this.id,
    this.nome,
    this.valor,
    this.quantidade,
    this.unidade,
    this.descricao,
    this.texto,
  );

  factory Cardapio.fromJson(Map<String, dynamic> j) {
    return Cardapio(
      j['id'],
      j['nome'],
      j['valor'],
      j['quantidade'],
      j['unidade'],
      j['descricao'],
      j['texto'],
    );
  }
}
