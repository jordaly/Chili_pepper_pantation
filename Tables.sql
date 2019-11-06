create table Tercero(
	idTercero int Primary key not null identity(1,1),
	Nombre nvarchar(100),
	Fecha_insersion date,
	Estado bit
)
--Aqui comienza la relación de la dirección
create table País(
	idPaís int primary key not null identity(1,1),
	País nvarchar(100)
)
Create table Región(
	idRegión int primary key not null identity(1,1),
	idPaís int constraint FK_País foreign key (idPaís)references País(idPaís),
	Región nvarchar(100)
)
Create table Provincia(
	idProvincia int primary key not null identity(1,1),
	idRegión int constraint FK_Región foreign key (idRegión)references Región(idRegión),
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
