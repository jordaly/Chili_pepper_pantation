--Esta es la trabla Tercero, con ella se relacionan todas las entidades.
create table Tercero(
	idTercero int Primary key not null identity(1,1),
	Nombre nvarchar(100),
	Fecha_insersion date,
	Estado bit
)



--Aqui comienza la relaci�n de la direcci�n.
create table Pa�s(
	idPa�s int primary key not null identity(1,1),
	Pa�s nvarchar(100)
)
Create table Regi�n(
	idRegi�n int primary key not null identity(1,1),
	idPa�s int constraint FK_Pa�s foreign key (idPa�s)references Pa�s(idPa�s),
	Regi�n nvarchar(100)
)
Create table Provincia(
	idProvincia int primary key not null identity(1,1),
	idRegi�n int constraint FK_Regi�n foreign key (idRegi�n)references Regi�n(idRegi�n),
	Provincia nvarchar(100)
)
Create table Municipio(
	idMunicipio int primary key not null identity(1,1),
	idProvincia int constraint FK_Provincia foreign key (idProvincia)references Provincia(idProvincia),
	Municipio nvarchar(100)
)

Create table Sector(
	idSector int primary key not null identity(1,1),
	idMunicipio int constraint FK_Municipio foreign key (idMunicipio)references Municipio(idMunicipio),
	Setor nvarchar(100)
)

Create table Barrio(
	idBarrio int primary key not null identity(1,1),
	idSector int constraint FK_Sector foreign key (idSector)references Sector(idSector),
	Barrio nvarchar(100)
)
Create table Calle(
	idCalle int primary key not null identity(1,1),
	idBarrio int constraint FK_Barrio foreign key (idBarrio)references Barrio(idBarrio),
	Calle nvarchar(100)
)
Create table Casa(
	idCasa int primary key not null identity(1,1),
	idCalle int constraint FK_Calle foreign key (idCalle)references Calle(idCalle),
	Casa nvarchar(100),
	Descripci�n nvarchar(250),
	NumeroCasa int
)




--La Relaci�n de la tabla telefono con los terceros se hara por medio de una 
--tabla intermedia Tercero_vs_Telefono
Create table Telefono(
	idTelefono int primary key not null identity(1,1),
	idTipoTelefono int constraint FK_TipoTelefono foreign key (idTipoTelefono)references TipoTelefono(idTipoTelefono),
	Numero nvarchar(100)
)
Create table TipoTelefono(
	idTipoTelefono int primary key not null identity(1,1),
	Tipo nvarchar(100)
)
Create table Telefono_vs_Tercero(
	idTelefono int constraint FK_Telefono foreign key (idTelefono)references Telefono(idTelefono),
	idTercero int constraint FK_Tercero foreign key (idTercero)references Tercero(idTercero),
	Estado nvarchar(100)
)




--La Tabla de la empresa del sistema
Create table EmpresaDelSistema(
	idTercero int constraint FK_Tercero foreign key (idTercero)references Tercero(idTercero)
)



--Tabla de persona relacionada con tercero
Create Table persona(
	idTercero int constraint FK_Tercero foreign key (idTercero)references Tercero(idTercero),
	Apellido varchar(50),
	FechaNacimiento date,
	Sexo nvarchar(1),
	Estado bit
)



--Tabla cliente con tercero
create table Cliente(
	idTercero int constraint FK_Tercero foreign key (idTercero)references Tercero(idTercero),
	EStado bit
)



--Tablas relacionadas con empleado (puesto, Horario),
Create table Puesto(
	idPuesto int primary key not null identity(1,1),
	Descripci�n nvarchar(250),
	Salario double 
)
Create table Horario(
	idHorario int primary key not null identity(1,1),
	HoraEntrada nvarchar(20),
	HoraSalida nvarchar(20)
)



--Tabla de empleado Relacionada con Puesto y Horario
Create table Empleado(
	idTercero int constraint FK_Tercero foreign key (idTercero)references Tercero(idTercero),
	idPuesto int constraint FK_Puesto foreign key (idPuesto)references Puesto(idPuesto),
	idHorario int constraint FK_Horario foreign key (idHorario)references Horario(idHorario)
)