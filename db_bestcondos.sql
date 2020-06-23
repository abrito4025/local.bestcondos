create database db_bestcondos;
USE  db_bestcondos;

select*from Usuario;
select*from Rol;
select*from Departamento;
select*from Cargo;
select*from Condominio;
drop table Usuario;
delete from Condominio where Id_condominio=1;

create table Usuario (
Id_usuario int primary key auto_increment,
Nombre varchar(40) not null,
Apellido varchar(50), 
Fecha_ingreso date,
Estado bit default(1),
Correo_electronico varchar(50) unique not null, 
Clave varchar(255) not null,  -- esta será encriptada antes de la inserción
Foto varchar(100),
Id_rol int,
Id_cargo int,
Id_departamento int,
Id_condominio  int,
foreign key (Id_rol) references Rol (Id_rol) ON DELETE CASCADE ON UPDATE CASCADE, 
foreign key (Id_cargo) references Cargo (Id_cargo) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key  (Id_departamento) references Departamento (Id_departamento) ON DELETE CASCADE ON UPDATE CASCADE,
foreign key (Id_condominio) references Condominio (Id_condominio) ON DELETE CASCADE ON UPDATE CASCADE
 );
 
 alter table Usuario add unique (Correo_electronico);
 
create table Rol (
Id_rol int primary key auto_increment,
Nombre varchar(40) unique not null, 
Descripcion varchar(100), 
Estado bit default(1)
);

insert into Rol values (1, 'Administrador', 'Administra el Sistema', 1);
insert into Rol values (2, 'Empleado', 'Gestion administrativa y de servicios', 1),
                       (3, 'Propietario', 'Gestiona los inmueble adquirido', 1),
                       (4, 'Residente', 'Alquila y realiza pago de cuota  de inmueble en el sistema', 1);
                       
create table Cargo (
Id_cargo int primary key auto_increment, 
Nombre varchar(40) not null, 
Descripcion varchar(100) not null, 
Id_departamento int, 
foreign key (Id_departamento) references Departamento (Id_departamento)
);

create table Departamento (
Id_departamento int primary key auto_increment,
Nombre varchar(40) not null,
Descripcion varchar(100),
Estado bit default(1)
);

create table Administrador ( 
Id_administrador  int primary key auto_increment,
Nombre varchar(40),
Apellido varchar(50), 
Tipo_documento varchar(20), 
Num_documento varchar(20), 
sexo char (1), -- M/F
Telefono varchar (20),
Direccion varchar (100),
Estado bit default(1),
Id_usuario int,
Id_cargo int,
Id_condominio int,
foreign key	(Id_usuario) references Usuario (Id_usuario ) on update cascade on delete cascade, 
foreign key	(Id_cargo) references Cargo (Id_cargo) on update cascade on delete cascade,
foreign key	(Id_condominio) references Condominio (Id_condominio) on update cascade on delete cascade
);

create table Empleado (
Id_empleado  int primary key auto_increment,
Nombre varchar(40),
Apellido varchar(50), 
Tipo_documento varchar(20), 
Num_documento varchar(20), 
sexo char (1), -- M/F
Fecha_nac date,
Telefono varchar (20),
Direccion varchar (100),
Salario float (7,2),
Estado bit default(1),
Id_usuario int,
Id_cargo int,
Id_condominio  int,
foreign key	(Id_usuario) references Usuario (Id_usuario ) on update cascade on delete cascade, 
foreign key	(Id_cargo) references Cargo (Id_cargo) on update cascade on delete cascade,
foreign key	(Id_condominio) references Condominio (Id_condominio) on update cascade on delete cascade
);

create table Propietario ( 
Id_propietario  int primary key auto_increment,
Nombre varchar(40),
Apellido varchar(50), 
Tipo_documento varchar(20), 
Num_documento varchar(20), 
sexo char (1), -- M/F
Telefono varchar (20),
Direccion varchar (100),
Id_usuario int,
Id_apartamento int,
Id_condominio  int,
foreign key	(Id_usuario) references Usuario (Id_usuario ) on update cascade on delete cascade, 
foreign key	(Id_apartamento) references Apartamento (Id_apartamento ) on update cascade on delete cascade,
foreign key	(Id_condominio) references Condominio (Id_condominio ) on update cascade on delete cascade
);

create table Residente (
Id_residente  int primary key auto_increment,
Nombre varchar(40),
Apellido varchar(50), 
Tipo_documento varchar(20), 
Num_documento varchar(20), 
sexo char (1), -- M/F
Telefono varchar (20),
Direccion varchar (100),
Id_usuario int, 
Id_apartamento int,
Id_condominio  int,
foreign key	(Id_usuario) references Usuario (Id_usuario ) on update cascade on delete cascade, 
foreign key	(Id_apartamento) references Apartamento (Id_apartamento) on update cascade on delete cascade,
foreign key	(Id_condominio) references Condominio (Id_condominio) on update cascade on delete cascade
);

create table Condominio ( 
Id_condominio  int primary key auto_increment,
Nombre varchar(40) unique not null,
Descripcion varchar(100),
Telefono varchar (20),
Direccion varchar (100),
Ciudad varchar(50),
Estado varchar(20)
);

create table Edificio (
Id_edificio  int primary key auto_increment,
Tipo varchar(20) not null,
Descripcion varchar(100),
Precio float (7,2),
Estado varchar(20),
Id_propietario int,
Id_condominio  int,
foreign key	(Id_propietario) references Propietario (Id_propietario) on update cascade on delete cascade,
foreign key	(Id_condominio) references Condominio (Id_condominio) on update cascade on delete cascade
);

create table Apartamento (
Id_apartamento  int primary key auto_increment,
Num_apartamento int, 
Num_piso  int, 
Precio float (7,2) not null,
Descripcion varchar(100),
Estado varchar(20),
Id_edificio int,
foreign key	(Id_edificio) references Edificio (Id_edificio) on update cascade on delete cascade
);


create table Servicio (
Id_servicio  int primary key auto_increment,
Tipo varchar(20) not null,
Descripcion varchar(100),
Precio float (7,2) not null,
Estado varchar(20),
Id_edificio int,
Id_condominio int,
Id_empleado  int,
Id_residente int,
Id_propietario int,
foreign key	(Id_empleado) references Empleado (Id_empleado) on update cascade on delete cascade,
foreign key	(Id_edificio) references Edificio (Id_edificio) on update cascade on delete cascade,
foreign key	(Id_condominio) references Condominio (Id_condominio) on update cascade on delete cascade,
foreign key	(Id_residente)  references Residente (Id_residente) on update cascade on delete cascade,
foreign key	(Id_propietario)  references Propietario (Id_propietario  ) on update cascade on delete cascade
);
	
create table Cuota (
Id_cuota  int primary key auto_increment,
Monto float (7,2) not null,
Fecha_inicio date not null, 
Fecha_fin date not null,
Id_servicio  int,
foreign key	(Id_servicio) references Servicio (Id_servicio) on update cascade on delete cascade
);

create table Pago (
Id_pago  int primary key auto_increment,
Tipo varchar(20) not null, -- efectivo | crédito
Fecha date not null, 
Id_cuota  int,
Id_residente int,
Id_propietario int,
foreign key	(Id_cuota)  references Cuota (Id_cuota ) on update cascade on delete cascade, 
foreign key	(Id_residente)  references Residente (Id_residente) on update cascade on delete cascade,
foreign key	(Id_propietario)  references Propietario (Id_propietario  ) on update cascade on delete cascade
);

create table Detalle_pago (
Id_detalle_pago  int primary key auto_increment,
Cantidad int, 
Precio float(7,2),
Descuento float(7,2),
Total float(7,2),
Id_pago int,
Id_apartamento int,
foreign key	(Id_pago) references Pago (Id_pago) on update cascade on delete cascade,
foreign key	(Id_apartamento) references Apartamento (Id_apartamento ) on update cascade on delete cascade
);









                       


 