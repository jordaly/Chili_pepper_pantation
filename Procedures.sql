SELECT CONVERT(XML, BulkColumn) AS BulkColumn
FROM OPENROWSET(BULK 'C:\Users\Jorda\Desktop\Folder files\Queries\Chili_pepper_pantation\Data\Factura.xml', SINGLE_BLOB) AS x;