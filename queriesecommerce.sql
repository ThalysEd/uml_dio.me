use ecommerce;
select 
  c.idcliente,
  concat(c.Fname, ' ', c.Lname) as nome_cliente,
  count(*) 
from orders o, cliente c
where c.idcliente = o.idorderclient
group by c.idcliente, concat(c.Fname, ' ', c.Lname);

select 
  s.socialname, 
  s.cnpj as cnpj_seller, 
  f.cnpj as cnpj_supplier
from seller s, supplier f
where s.cnpj = f.cnpj;

select 
  p.Pname as produto,
  s.socialname as vendedor,
  f.socialname as fornecedor,
  ps.prodquantity as quantidade_em_estoque
from product p, productseller ps, seller s, supplier f
where p.idproduct = ps.idpproduct
  and ps.idpseller = s.idseller
  and s.cnpj = f.cnpj;


select 
  f.socialname as fornecedor,
  p.Pname as produto
from supplier f, seller s, productseller ps, product p
where f.cnpj = s.cnpj
  and s.idseller = ps.idpseller
  and ps.idpproduct = p.idproduct
order by f.socialname, p.Pname;


select 
  concat(c.Fname, ' ', c.Lname) as nome_cliente,
  o.idorder,
  sum(po.poquantity * p.avaliacao) as valor_estimado
from cliente c, orders o, productorder po, product p
where c.idcliente = o.idorderclient
  and o.idorder = po.idpoorder
  and po.idpoproduct = p.idproduct
group by o.idorder, concat(c.Fname, ' ', c.Lname)
having valor_estimado > 5
order by valor_estimado desc;
