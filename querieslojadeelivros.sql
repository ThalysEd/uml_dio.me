use lojadelivros;

select nome,nacionalidade from autores;
select titulo from livros where estoque < 5;
select titulo,preco,(preco*2) as dobro_do_preco from livros;
select nome from autores order by nome desc;
select a.nome, v.quantidade from autores a , vendas v , livros l where a.id=l.autor_id and l.id=v.livro_id having v.quantidade=2;
select a.nome,v.quantidade, l.titulo from autores a , vendas v , livros l where a.id=l.autor_id and l.id=v.livro_id;