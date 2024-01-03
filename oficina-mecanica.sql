-- Criação do banco de dados Oficina Mecânica
create database if not exists oficina;
use oficina;
show tables;

-- Criação tabela cliente
create table cliente(
	idCliente int auto_increment primary key,
    CPF char(11) not null unique,
    contato char(11) not null,
    endereco varchar(150)
);

-- Criação tabela veículo
create table veiculoOS(
	idVeiculoOS int auto_increment primary key,
    marca varchar(50),
    modelo varchar(50),
	anoFabricacao year,
    OSCliente int not null,
    constraint fk_veiculo_OS foreign key (OSCliente) references Cliente(idCliente)
);
-- drop table veiculoOS;
-- Criação tabela serviço
create table servico(
	idServico int auto_increment primary key,
    tipoServico enum ('Recall', 'Vistoria', 'Manutenção') not null default 'Manutenção',
	deadline date,
    valor float not null,
    servCliente int,
    constraint fk_cliente foreign key (servCliente) references Cliente(idCliente)
);

-- Criação tabela equipe de mecânicos
create table equipeMecanicos(
	idequipeMecanicos int auto_increment primary key,
    mecanicoEspecialista varchar(50) not null,
    endereco varchar(45),
    mecServico int not null,
	mecCliente int not null,
    constraint fk_mec_servico foreign key (mecServico) references Servico (idServico),
	constraint fk_mecCliente foreign key (mecCliente) references Cliente (idCliente)
);

-- Criação tabela OS
create table os(
	idOS INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	OSDescricao VARCHAR(100) NOT NULL
);      

-- Criação da tabela pagamento
CREATE TABLE pagamento(
	idPagamento INT AUTO_INCREMENT PRIMARY KEY,
	metodoPagamento ENUM('Cartão de crédito', 'Cartão de débito', 'Boleto','PIX') NOT NULL DEFAULT 'PIX',
	pagamentoOS INT NOT NULL,
	PagamentoServico INT NOT NULL,
	PagamentoCliente INT NOT NULL,
	CONSTRAINT fk_payment_os FOREIGN KEY (pagamentoOS) REFERENCES OS(idOS),
	CONSTRAINT fk_payment_servico FOREIGN KEY (PagamentoServico) REFERENCES servico(idServico),
    CONSTRAINT fk_payment_cliente FOREIGN KEY (PagamentoCliente) REFERENCES cliente(idCliente)
);

-- Alimentando as tabelas de oficina-mecanica
-- Alimentando a tabela cliente
desc cliente;
select * from cliente;
insert into cliente (CPF, contato, endereco) values
		(11112345678, 21999998888, 'Rua José das Rosas, Barra Mansa-RJ'),
		(22212345678, 21982345678, 'Rua Monica do sertão, Volta Redonda-RJ'),
		(33312345678, 21982456023, 'Rua Maciel das cadeiras, Guarulhos-SP'),
		(44412345678, 22982853014, 'Rua joao zamil zarif, Guarulhos-SP');

-- Alimentando a tabela veiculoOS
desc veiculoOS;
select * from veiculoOS;
insert into veiculoOS (marca, modelo, anoFabricacao, OSCliente) values
			('Gol', 'G4', 2015, '1'),
			('Fox', 'Route', 2007, '1'),
			('Gol', 'G2', 2010, '2'),
            ('Fusca', 'Última Série', 1965, '2'),
            ('Kombi', 'Last Edition', 2014, '3'),
            ('Gol', 'G1', 1999, '4');
                    
				
-- Alimentando a tabela equipe mecânica
desc equipeMecanicos;
select * from equipeMecanicos;
insert into equipeMecanicos(mecanicoEspecialista, endereco, mecServico, mecCliente) values
			('Modelo antigo', 'Estrada Mirandela, Nilópolis - RJ', 1, 2),
			('Modelo antigo', 'Estrada Mirandela, Nilópolis - RJ', 2, 2),
			('Modelo novo', 'Avenida Getúlio Vargas, Nilópolis - RJ', 3, 4),
            ('Modelo qualquer', 'Avenida Getúlio de mOura, Nilópolis - RJ', 4, 1);
                                
-- Alimentando tabela OS
select * from os;
desc os;
insert into os (OSDescricao) values 
		('Limpeza do carro'),
		('Barulho motor'),
		('Alinhamento de rodas'),
		('Correia dentada'),
		('Alinhamento de capô');


-- Alimentando a tabela serviço
desc servico;
select * from servico;
insert into servico (tipoServico, deadline, Valor, servCliente) values
				('Manutenção', '2022-10-31', 1500.00, 1),
				('Recall', '2022-10-31', 0, 1),
                ('Manutenção', '2022-12-05', 600.00, 2),
                ('Manutenção','2023-02-02', 250.00, 2),
                ('Manutenção','2023-02-02', 300.00, 3),
                ('Recall', '2023-02-09', 0, 4);

-- Alimentando a table a payment
desc pagamento;
select * from pagamento;
insert into pagamento(metodoPagamento, pagamentoOS, PagamentoServico, PagamentoCliente) values
						('Boleto', 2, 1, 2),
						('Cartão de crédito', 3, 2, 2),
						('PIX', 4, 3, 4),
						('Cartão de débito', 2, 4, 1);

-- Queries
show tables;
select * from cliente;
select * from os;
select * from pagamento;
select * from servico;
select * from veiculoOS;
select * from equipeMecanicos;

-- Metodo de pagamento de Cliente + Nuemro OS
select * from cliente, pagamento  where idCliente = PagamentoCliente;
select CPF, contato, metodoPagamento, pagamentoOS from cliente, pagamento  where idCliente = PagamentoCliente;

-- Serviços atrelados a clientes, ordenados por deadline
select * from cliente, servico where idCliente = servCliente ORDER BY idCliente;
select deadline, CPF, contato, endereco, tipoServico, valor 
				from cliente, servico 
                where idCliente = servCliente
                order by deadline;

-- DEAD LINE PARA ANO QUE VEM
select * from equipeMecanicos, servico where mecServico = idServico having deadline > '2022-12-31';
select deadline, mecanicoEspecialista, tipoServico, valor, servCliente 
						from equipeMecanicos, servico 
                        where mecServico = idServico 
                        having deadline > '2022-12-31';











