Declare @Insertar xml =
(SELECT CONVERT(XML, BulkColumn) AS BulkColumn
FROM OPENROWSET(BULK 'C:\Users\Jorda\Desktop\Folder files\Queries\Chili_pepper_pantation\Data\Factura 2.xml', SINGLE_BLOB) AS x);

INSERT INTO Factura( idTipoFactura, Fecha, idCliente, idNFC, idSucursal, idTipoDivisa, idTipoPago,Total )
SELECT
idTipoFacutra = XCol.value('(idTipoFactura)','int'),
Fecha = XCol.value('(Fecha)','date'),
idCliente = XCol.value('(idCliente)','int'),
idNFC = XCol.value('(idNFC)','int'),
idSucursal = XCol.value('(idSucursal)','int'),
idTipoDivisa= XCol.value('(idTipoDivisa)','int'),
idTipoPago = XCol.value('(idTipoPago)','int'),
idTotal = XCol.value('(id)','int')
FROM
@Insertar.nodes('/root/row') AS XTbl(XCol)

create procedure InsertarFacturaXML
@Cliente int,
@Producto int,
@NFC int,
@Insertar xml 
as
begin
	set @Insertar = (SELECT CONVERT(XML, BulkColumn) AS BulkColumn
FROM OPENROWSET(BULK 'C:\Users\Jorda\Desktop\Folder files\Queries\Chili_pepper_pantation\Data\Factura 2.xml', SINGLE_BLOB) AS x)

	if exists(select idCliente = XCol.value('(idCliente)','int') from @Insertar.nodes('root/row') as XTbl(XCol))
	begin
		if exists(select idProducto = XCol.value('(idProducto)','int') from @Insertar.nodes('root/row/DetalleFactura') as XTbl(XCol) where idProducto=)
		begin
			if exists(select idCliente = XCol.value('(idCliente)','int') from @Insertar.nodes('root/row') as XTbl(XCol))
			begin
		
			end
		end
	end
	set @Cliente = select idCliente = XCol.value('(idCliente)','int') from @Insertar.nodes('root/row') as XTbl(XCol)
end

