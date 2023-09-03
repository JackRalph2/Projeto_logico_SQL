-- criação do banco de dados para o cenário do e-commerce

create database ecommerce;

use ecommerce;

-- criar tabela cliente
create table cliente(
		idcliente int auto_increment primary key,
        PNome varchar(10),
        NMeio char(1),
        UNome varchar(10),
        CPF char(11) not null,
		Rua varchar (50),
        numero varchar (4),
        bairro varchar (10),
        cidade varchar (10),
        UF char (2),
        CEP char (8),
        constraint unique_cpf_cliente unique (CPF)
        );
        
        alter table cliente auto_increment = 1;
 
 -- criar tabela produto
create table produto(
		idproduto int auto_increment primary key,
        PNome varchar (10),
        classificação_criança bool,
        categoria enum ("Eletronico", "Eestimenta", "Brinquedos", "Móveis") not null,
        avaliação float default 0,
        dimensões varchar (10)
        );
          alter table produto auto_increment = 1;

-- criar tabela pedido

create table pedido(
		idpedido int auto_increment primary key, 
        idOrderCliente int,
		StatusPedido enum ("Cancelado", "Confirmado", "Em Processamento") default "Em Processamento",
        Descriçãodopedido varchar (200),
        Frete float default 10,
        pagamentoDinheiro bool default false,
        constraint fk_order_client foreign key (idOrderCliente) references cliente(idcliente)
				on update cascade
                on delete set null
        );
        
          alter table pedido auto_increment = 1;
create table pagamento(
		idCliente int,
        idPagamento int,
        Dinhero float,
        limiteDisponivel float,
        TipoPagamento enum ("Boleto", "Cartão", "Dois Cartões"),
        primary key (idCliente, idPagamento)
        );
-- Estoque
create table Estoque (
		idestoque int auto_increment primary key, 
        quantidade int DEFAULT 0,
		Localestoque varchar (155)
       );
       
         alter table Estoque auto_increment = 1;
-- Fornecedor
create table Fornecedor(
        idfornecedor int auto_increment primary key,
        RazaoSocial varchar (200) not null,
        NomeFantasia varchar (200) not null,
        CNPJ char (15) not null,
        Contato char (11),
		constraint unique_fornecedor unique (CNPJ)
        );
        
          alter table Fornecedor auto_increment = 1;
-- Vendedor
create table vendedor(
		idvendedor int auto_increment primary key,
        RazaoSocial varchar (200) not null,
        NomeFantasia varchar (200) not null,
        CNPJ char (15),
        CPF char (9),
        Contato char (11),
        Rua varchar (50),
        numero varchar (4),
        bairro varchar (10),
        cidade varchar (10),
        UF char (2),
        CEP char (8),
		constraint unique_cnpj_vendedor unique (CNPJ),
        constraint unique_cpf_vendedor unique (CPF)
        );
          alter table vendedor auto_increment = 1;
        
create table produtoVendedor(
		idPVendedor int,
        idPProduto int,
        Quantidade int default 1,
        primary key (idPVendedor, idPProduto),
        constraint fk_vendedor_produto foreign key (idPVendedor) references vendedor(idvendedor),
		constraint fk_produto_produto foreign key (idPProduto) references produto (idproduto)
        );
        
create table pedidoProduto(
		idPOproduto int,
        idPPedido int,
        QuantidadePedido int default 1,
        StatusPedido enum("Disponível", "Sem estoque") default "Disponivel",
        primary key (idPPedido, idPOproduto),
        constraint fk_product_seller foreign key (idPOproduto) references produto(idproduto),
        constraint fk_produto_pedido foreign key (idPPedido) references pedido(idpedido)
        );

create table LocalEstoque (
		idLProduto int, 
        idLEstoque int,
        localtion varchar(255) not null,
        primary key (idLProduto, idLestoque),
		constraint fk_estoque_local_produto foreign key (idLProduto) references produto(idproduto),
        constraint fk_local_produto foreign key (idLEstoque) references pedido(idpedido)
       );
       
