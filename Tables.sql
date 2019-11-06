create table Tercero(
	idTercero int Primary key not null identity(1,1),
	Nombre nvarchar(100),
	Fecha_insersion date,
	Estado bit
)
--Aqui comienza la relaci�n de la direcci�n
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
