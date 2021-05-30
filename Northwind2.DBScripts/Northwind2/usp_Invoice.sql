IF OBJECT_ID('Sales.usp_Invoice_Insert',
             'P') IS NOT NULL
  DROP PROC Sales.usp_Invoice_Insert

GO

-- =============================================
--      Author:	KSafford
-- Create date:	08/15/2014
-- Description:	
--   Revisions:	
-- =============================================
CREATE PROCEDURE Sales.usp_Invoice_Insert @CustomerID       INT,
                                          @EmployeeID       INT,
                                          @InvoiceDate      DATETIME,
                                          @RequiredDate     DATETIME,
                                          @ShipperID        INT,
                                          @Freight          MONEY,
                                          @ShipName         VARCHAR(50),
                                          @ShipAddressLine1 VARCHAR(50),
                                          @ShipAddressLine2 VARCHAR(50),
                                          @ShipCity         VARCHAR(50),
                                          @ShipRegion       VARCHAR(50),
                                          @ShipPostalCode   VARCHAR(20),
                                          @CountryID        INT,
                                          @AddedBy          VARCHAR(20),
                                          @ModifiedBy       VARCHAR(20),
                                          @newInvoiceID     INT OUTPUT,
                                          @newModified      TIMESTAMP OUTPUT
AS
  BEGIN
      SET NOCOUNT ON

      INSERT INTO Sales.Invoice
                  (CustomerID,
                   EmployeeID,
                   InvoiceDate,
                   RequiredDate,
                   ShipperID,
                   Freight,
                   ShipName,
                   ShipAddressLine1,
                   ShipAddressLine2,
                   ShipCity,
                   ShipRegion,
                   ShipPostalCode,
                   CountryID,
                   AddedBy,
                   AddedDate,
                   ModifiedBy,
                   ModifiedDate)
      VALUES      ( @CustomerID,
                    @EmployeeID,
                    @InvoiceDate,
                    @RequiredDate,
                    @ShipperID,
                    @Freight,
                    @ShipName,
                    @ShipAddressLine1,
                    @ShipAddressLine2,
                    @ShipCity,
                    @ShipRegion,
                    @ShipPostalCode,
                    @CountryID,
                    @AddedBy,
                    CURRENT_TIMESTAMP,
                    @ModifiedBy,
                    CURRENT_TIMESTAMP)

      SELECT @newInvoiceID = InvoiceID,
             @newModified = Modified
      FROM   Sales.Invoice
      WHERE  InvoiceID = IDENT_CURRENT('Sales.Invoice')
  END

GO 
