--Creación de la base de datos
Create database Plantación de ajíes
use  [Plantación de ajíes]



--Esta es la trabla Tercero, con ella se relacionan todas las entidades.
create table Tercero(
	idTercero int Primary key not null identity(1,1),
	Nombre nvarchar(100),
	Fecha_insersion date,
	Estado bit
)



--Aqui comienza la relación de la dirección.
create table País(
	idPaís int primary key not null identity(1,1),
	País nvarchar(100)
)
Create table Región(
	idRegión int primary key not null identity(1,1),
	idPaís int constraint FK_País_Región foreign key (idPaís)references País(idPaís),
	Región nvarchar(100)
)
Create table Provincia(
	idProvincia int primary key not null identity(1,1),
	idRegión int constraint FK_Región_Provincia foreign key (idRegión)references Región(idRegión),
	Provincia nvarchar(100)
)
Create table Municipio(
	idMunicipio int primary key not null identity(1,1),
	idProvincia int constraint FK_Provincia_Municipio foreign key (idProvincia)references Provincia(idProvincia),
	Municipio nvarchar(100)
)

Create table Sector(
	idSector int primary key not null identity(1,1),
	idMunicipio int constraint FK_Municipio_Sector foreign key (idMunicipio)references Municipio(idMunicipio),
	Setor nvarchar(100)
)

Create table Barrio(
	idBarrio int primary key not null identity(1,1),
	idSector int constraint FK_Sector_Barrio foreign key (idSector)references Sector(idSector),
	Barrio nvarchar(100)
)
Create table Calle(
	idCalle int primary key not null identity(1,1),
	idBarrio int constraint FK_Barrio_Calle foreign key (idBarrio)references Barrio(idBarrio),
	Calle nvarchar(100)
)
Create table Residencia(
	idResidencia int primary key not null identity(1,1),
	idCalle int constraint FK_Calle_Residencia foreign key (idCalle)references Calle(idCalle),
	Residencia nvarchar(100),
	Descripción nvarchar(250),
	NumeroRecidencia int
)



--Tabla de Tablas de Direccion_vs_Tercero 
Create table Dirección_vs_Tercero(
	idTercero int constraint FK_Tercero_DirecciónVsTercero foreign key (idTercero)references Tercero(idTercero),
	idDirección int constraint FK_Recidencia_DirecciónVsTercero foreign key (idDirección)references Residencia(idResidencia)
)



--Tabla de sucursal y almacen vs sucursal
create table Sucursal(
	idTercero int constraint FK_Tercero_Sucursal foreign key (idTercero)references Tercero(idTercero),
	idDirección int constraint FK_Residencia_Sucursal foreign key (idDirección)references Residencia(idResidencia),
	Estado bit
)
create table AlmacenVsSucursal(
	idAlmacen int constraint FK_Almacen_AlmacenVsSucursal foreign key (idAlmacen)references Tercero(idTercero),
	idSucursal int constraint FK_Sucursal_AlmacenVsSucursal foreign key (idSucursal)references Tercero(idTercero)
)



--La Relación de la tabla telefono con los terceros se hara por medio de una 
--tabla intermedia Tercero_vs_Telefono
Create table TipoTelefono(
	idTipoTelefono int primary key not null identity(1,1),
	Tipo nvarchar(100)
)
Create table Telefono(
	idTelefono int primary key not null identity(1,1),
	idTipoTelefono int constraint FK_TipoTelefono_Telefono foreign key (idTipoTelefono)references TipoTelefono(idTipoTelefono),
	Numero nvarchar(100)
)
Create table Telefono_vs_Tercero(
	idTelefono int constraint FK_Telefono_TelefonoVsTercero foreign key (idTelefono)references Telefono(idTelefono),
	idTercero int constraint FK_Tercero_TelefonoVsTercero foreign key (idTercero)references Tercero(idTercero),
	Estado nvarchar(100)
)




--La Tabla de la empresa del sistema y empresa
Create table EmpresaDelSistema(
	idTercero int constraint FK_Tercero_EmpresaDelSistema foreign key (idTercero)references Tercero(idTercero)
)
Create table Empresa(
	idTercero int constraint FK_Tercero_Empresa foreign key (idTercero)references Tercero(idTercero)
)



--Tabla de persona relacionada con tercero
Create Table Persona(
	idTercero int constraint FK_Tercero_Persona foreign key (idTercero)references Tercero(idTercero),
	Apellido varchar(50),
	FechaNacimiento date,
	Sexo nvarchar(1),
	Estado bit
)



--Tabla cliente con tercero
create table Cliente(
	idTercero int constraint FK_Tercero_Cliente foreign key (idTercero)references Tercero(idTercero),
	EStado bit
)



--Tablas relacionadas con empleado (puesto, Horario)
Create table Puesto(
	idPuesto int primary key not null identity(1,1),
	Descripción nvarchar(250),
	Salario float
)
Create table Horario(
	idHorario int primary key not null identity(1,1),
	HoraEntrada nvarchar(20),
	HoraSalida nvarchar(20)
)



--Tabla de empleado Relacionada con Puesto y Horario
Create table Empleado(
	idTercero int constraint FK_Tercero_Empleado foreign key (idTercero)references Tercero(idTercero),
	idPuesto int constraint FK_Puesto_Empleado foreign key (idPuesto)references Puesto(idPuesto),
	idHorario int constraint FK_Horario_Empleado foreign key (idHorario)references Horario(idHorario)
)



--Tabla para Suplidores 
create table Suplidor(
	idTercero int constraint FK_Tercero_Suplidor foreign key (idTercero)references Tercero(idTercero)
)



--Tablas Para producto, tipo producto y Suplidor vs producto
Create table DetalleProducto(
	idDetalleProducto int primary key not null identity(1,1),
	Cantidad int,
	Precio float,
	Medida nvarchar(50)
)
create table Producto(
	idProducto int primary key not null identity(1,1),
	FechaCreacion date,
	nombre nvarchar(100),
	Descripción varchar(300),
	CantidadExistente int,
	CantidadMinima int,
	idDetalleProducto int constraint FK_DetalleProducto_Producto foreign key (idDetalleProducto)references DetalleProducto(idDetalleProducto)
)
create table Suplidor_vs_Producto(
	idSuplidor int constraint FK_Tercero_SuplidorVsProducto foreign key (idSuplidor)references Tercero(idTercero),
	idProducto int constraint FK_Producto_SuplidorVsProducto foreign key (idProducto)references Producto(idProducto),
	Estado bit
)



--Creación de la tabla Almacen y TipoAlmacen
Create table TipoAlmacen(
	idTipoAlmacen int primary key not null identity(1,1),
	Descripción nvarchar(300)
)
Create table Almacen(
	idTercero int constraint FK_Tercero_Almacen foreign key (idTercero)references Tercero(idTercero),
	idTipoAlmacen int constraint FK_TipoAlmacen_Almacen foreign key (idTipoAlmacen)references TipoAlmacen(idTipoAlmacen),
	Estatus bit
)



--Tabla de Producto Vs Almacen
Create table ProductoVsAlmacen(
	idAlmacen int constraint FK_Tercero_ProductoVsAlmacen foreign key (idAlmacen)references Tercero(idTercero),
	idProducto int constraint FK_Producto_ProductoVsAlmacen foreign key (idProducto)references Producto(idProducto)
)




--Tablas de tipo divisa, tipo pago y NFC
create table TipoDivisa(
	idTipoDivisa int primary key not null identity(1,1),
	Descripción nvarchar(100)
)
create table TipoPago(
	idTipoPago int primary key not null identity(1,1),
	Descripción nvarchar(100)
)
create table NFC(
	idNFC int primary key not null identity(1,1),
	NFC varchar(60)
)



--Tabla de Compra y DetalleCompra
create table Compra(
	idCompra int primary key not null identity(1,1),
	FechaCompra date,
	TotalPagar money,
	idTipoDivisa int constraint FK_TipoDivisa_Compra foreign key (idTipoDivisa)references TipoDivisa(idTipoDivisa),
	idTipoPago int constraint FK_TipoPago_Compra foreign key (idTipoPago)references TipoPago(idTipoPago)
)

Create table DetalleCompra(
	idProducto int constraint FK_Producto_DetalleCompra foreign key (idProducto)references Producto(idProducto),
	idCompra int constraint FK_Compra_DetalleCompra foreign key (idCompra)references Compra(idCompra),
	CantidadComprada int
)



--Tabla de factura, detalle factura y Tipo factura
create table TipoFactura(
	idTipoFactura int primary key not null identity(1,1),
	Descripción nvarchar(300)
)
Create table Factura(
	idFactura int primary key not null identity(1,1),
	idTipoFactura int constraint FK_TipoFactura_Factura foreign key (idTipoFactura)references TipoFactura(idTipoFactura),
	Fecha date,
	idCliente int constraint FK_Tercero_Factura foreign key (idCliente)references Tercero(idTercero),
	idNFC int constraint FK_NFC_Factura foreign key (idNFC)references NFC(idNFC),
	idSucursal int constraint FK_Sucursal_Factura foreign key (idSucursal)references Tercero(idTercero),
	idTipoDivisa int constraint FK_TipoDivisa_Factura foreign key (idTipoDivisa)references TipoDivisa(idTipoDivisa),
	idTipoPago int constraint FK_TipoPago_Factura foreign key (idTipoPago)references TipoPago(idTipoPago)
)
create table DetalleFactura(
	idProducto int constraint FK_Producto_DetalleFacutra foreign key (idProducto)references Producto(idProducto),
	idFactura int constraint FK_Factura_DetalleFactura foreign key (idFactura)references Factura(idFactura),
	CantidadVendida int
)



--Tabla de	ITEBIS
create table ITEBIS(
	idITEBIS int primary key not null identity(1,1),
	Porcentaje float
)



--Tabla de ITEBIS Vs Factura
create table ITEBISVsFactura(
	idFactura int constraint FK_Factura_ITEBISVsFactura foreign key (idFactura)references Factura(idFactura),
	idITEBIS int constraint FK_ITEBIS_ITEBISVsFactura foreign key (idITEBIS)references ITEBIS(idITEBIS),
	idProducto int constraint FK_Producto_ITEBISVsFactura foreign key (idProducto)references Producto(idProducto)
)




--Tabla de documentos Documento y TipoDocumento
create table TipoDocumento(
	idTipoDocumento int primary key identity(1,1),
	Descripción nvarchar(300)
)
create table Documento(
	idDocumento int primary key not null identity(1,1),
	idTipoDocumento int constraint FK_TipoDocumento_Documento foreign key (idTipoDocumento)references TipoDocumento(idTipoDocumento)
)

create table Descuento(
	idDescuento int primary key identity(1,1),
	Descripción nvarchar(100),
	Porcentaje float
)



--Tabla de Terreno, Cultivo, plantas, cuadrante, cuadre
create table Terreno(
	idTerreno int primary key not null identity(1,1),
	DistanciaTerreno float,
	Medida nvarchar(10)
)
create table Cuadre(
	idCuadre int primary key not null identity(1,1),
	FechaInicial date,
	FechaFinal date,
	ValorProducción int
)
create table Cuadrante(
	idCuadrante int primary key not null identity(1,1),
	Fila int,
	Columna int
)
create table Cultivo(
	idCultivo int primary key not null identity(1,1),
	idSucursal int constraint FK_Sucursal_Cultivo foreign key (idSucursal)references Tercero(idTercero),
	idTerreno int constraint FK_Terreno_Cultivo foreign key (idTerreno)references Terreno(idTerreno),
	idCuadre int constraint FK_Cuadre_Cultivo foreign key (idCuadre)references Cuadre(idCuadre)
)

create table Plantas(
	idPlanta int primary key not null identity(1,1),
	idTerreno int constraint FK_Terreno_Plantas foreign key (idTerreno)references Terreno(idTerreno),
	idCuadrante int constraint FK_Cuadrante_Plantas foreign key (idCuadrante)references Cuadrante(idCuadrante)
)



--Tabla de documentos vs tercero
create table DocumentoVsTerceros(
	idTercero int constraint FK_Tercero_DocumentoVsTercero foreign key (idTercero)references Tercero(idTercero),
	idDocumento int constraint FK_Documento_DocumentoVsTercero foreign key (idDocumento)references Documento(idDocumento)
)
create table CuadranteVsTerreno(
	idCuadrante int constraint FK_Cuadrante_CuadranteVsTerreno foreign key (idCuadrante)references Cuadrante(idCuadrante),
	idTerreno int constraint FK_Terreno_CuadranteVsTerreno foreign key (idTerreno)references Terreno(idTerreno)
)