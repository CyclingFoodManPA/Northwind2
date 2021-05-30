/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases v5.2.3                     */
/* Target DBMS:           MS SQL Server 2008                              */
/* Project file:          Northwind.dez                                   */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database drop script                            */
/* Created on:            2014-10-15 14:10                                */
/* Model version:         Version 2014-10-15                              */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Drop foreign key constraints                                           */
/* ---------------------------------------------------------------------- */

ALTER TABLE [Product] DROP CONSTRAINT [Category_Product]
GO

ALTER TABLE [Product] DROP CONSTRAINT [Supplier_Product]
GO

ALTER TABLE [Supplier] DROP CONSTRAINT [ContactTitle_Supplier]
GO

ALTER TABLE [Employee] DROP CONSTRAINT [Title_Employee]
GO

ALTER TABLE [Employee] DROP CONSTRAINT [TitleOfCourtesy_Employee]
GO

ALTER TABLE [Territory] DROP CONSTRAINT [Region_Territory]
GO

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [Employee_EmployeeToTerritory]
GO

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [Territory_EmployeeToTerritory]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [Employee_Invoice]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [Customer_Invoice]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [Shipper_Invoice]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [Country_Invoice]
GO

ALTER TABLE [Customer] DROP CONSTRAINT [ContactTitle_Customer]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [Invoice_InvoiceItem]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [Product_InvoiceItem]
GO

ALTER TABLE [Holiday] DROP CONSTRAINT [HolidayDescription_Holiday]
GO

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [SystemUser_SystemUserToSystemRole]
GO

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [SystemRole_SystemUserToSystemRole]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [Customer_CustomerAddress]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [AddressType_CustomerAddress]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [Country_CustomerAddress]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [Supplier_SupplierCommunication]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [CommunicationType_SupplierCommunication]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [CommunicationOrder_SupplierCommunication]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [Customer_CustomerCommunication]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [CommunicationType_CustomerCommunication]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [CommunicationOrder_CustomerCommunication]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [Employee_EmployeeCommunication]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [CommunicationType_EmployeeCommunication]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [CommunicationOrder_EmployeeCommunication]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [Shipper_ShipperCommunication]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [CommunicationType_ShipperCommunication]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [CommunicationOrder_ShipperCommunication]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [Country_EmployeeAddress]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [Employee_EmployeeAddress]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [AddressType_EmployeeAddress]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [Country_SupplierAddress]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [Supplier_SupplierAddress]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [AddressType_SupplierAddress]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Category"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Category] DROP CONSTRAINT [DEF_Category_AddedBy]
GO

ALTER TABLE [Category] DROP CONSTRAINT [DEF_Category_AddedDate]
GO

ALTER TABLE [Category] DROP CONSTRAINT [DEF_Category_ModifiedBy]
GO

ALTER TABLE [Category] DROP CONSTRAINT [DEF_Category_ModifiedDate]
GO

ALTER TABLE [Category] DROP CONSTRAINT [PK_Category]
GO

/* Drop table */

DROP TABLE [Category]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Product"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_UnitPrice]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_UnitsInStock]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_UnitsOnOrder]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_ReorderLevel]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_IsDiscontinued]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_AddedBy]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_AddedDate]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_ModifiedBy]
GO

ALTER TABLE [Product] DROP CONSTRAINT [DEF_Product_ModifiedDate]
GO

ALTER TABLE [Product] DROP CONSTRAINT [PK_Product]
GO

/* Drop table */

DROP TABLE [Product]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Supplier"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Supplier] DROP CONSTRAINT [DEF_Supplier_AddedBy]
GO

ALTER TABLE [Supplier] DROP CONSTRAINT [DEF_Supplier_AddedDate]
GO

ALTER TABLE [Supplier] DROP CONSTRAINT [DEF_Supplier_ModifiedBy]
GO

ALTER TABLE [Supplier] DROP CONSTRAINT [DEF_Supplier_ModifiedDate]
GO

ALTER TABLE [Supplier] DROP CONSTRAINT [PK_Supplier]
GO

/* Drop table */

DROP TABLE [Supplier]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Employee"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Employee] DROP CONSTRAINT [DEF_Employee_AddedBy]
GO

ALTER TABLE [Employee] DROP CONSTRAINT [DEF_Employee_AddedDate]
GO

ALTER TABLE [Employee] DROP CONSTRAINT [DEF_Employee_ModifiedBy]
GO

ALTER TABLE [Employee] DROP CONSTRAINT [DEF_Employee_ModifiedDate]
GO

ALTER TABLE [Employee] DROP CONSTRAINT [PK_Employee]
GO

/* Drop table */

DROP TABLE [Employee]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Country"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Country] DROP CONSTRAINT [DEF_Country_AddedBy]
GO

ALTER TABLE [Country] DROP CONSTRAINT [DEF_Country_AddedDate]
GO

ALTER TABLE [Country] DROP CONSTRAINT [DEF_Country_ModifiedBy]
GO

ALTER TABLE [Country] DROP CONSTRAINT [DEF_Country_ModifiedDate]
GO

ALTER TABLE [Country] DROP CONSTRAINT [PK_Country]
GO

/* Drop table */

DROP TABLE [Country]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Region"                                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Region] DROP CONSTRAINT [DEF_Region_AddedBy]
GO

ALTER TABLE [Region] DROP CONSTRAINT [DEF_Region_AddedDate]
GO

ALTER TABLE [Region] DROP CONSTRAINT [DEF_Region_ModifiedBy]
GO

ALTER TABLE [Region] DROP CONSTRAINT [DEF_Region_ModifiedDate]
GO

ALTER TABLE [Region] DROP CONSTRAINT [PK_Region]
GO

/* Drop table */

DROP TABLE [Region]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Territory"                                                 */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Territory] DROP CONSTRAINT [DEF_Territory_AddedBy]
GO

ALTER TABLE [Territory] DROP CONSTRAINT [DEF_Territory_AddedDate]
GO

ALTER TABLE [Territory] DROP CONSTRAINT [DEF_Territory_ModifiedBy]
GO

ALTER TABLE [Territory] DROP CONSTRAINT [DEF_Territory_ModifiedDate]
GO

ALTER TABLE [Territory] DROP CONSTRAINT [PK_Territory]
GO

/* Drop table */

DROP TABLE [Territory]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "EmployeeToTerritory"                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_AddedBy]
GO

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_AddedDate]
GO

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_ModifiedBy]
GO

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [DEF_EmployeeToTerritory_ModifiedDate]
GO

ALTER TABLE [EmployeeToTerritory] DROP CONSTRAINT [PK_EmployeeToTerritory]
GO

/* Drop table */

DROP TABLE [EmployeeToTerritory]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Invoice"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Invoice] DROP CONSTRAINT [DEF_Invoice_AddedBy]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [DEF_Invoice_AddedDate]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [DEF_Invoice_ModifiedBy]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [DEF_Invoice_ModifiedDate]
GO

ALTER TABLE [Invoice] DROP CONSTRAINT [PK_Invoice]
GO

/* Drop table */

DROP TABLE [Invoice]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Customer"                                                  */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Customer] DROP CONSTRAINT [DEF_Customer_AddedBy]
GO

ALTER TABLE [Customer] DROP CONSTRAINT [DEF_Customer_AddedDate]
GO

ALTER TABLE [Customer] DROP CONSTRAINT [DEF_Customer_ModifiedBy]
GO

ALTER TABLE [Customer] DROP CONSTRAINT [DEF_Customer_ModifiedDate]
GO

ALTER TABLE [Customer] DROP CONSTRAINT [PK_Customer]
GO

/* Drop table */

DROP TABLE [Customer]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "InvoiceItem"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_UnitPrice]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_Quantity]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_Discount]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_AddedBy]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_AddedDate]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_ModifiedBy]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [DEF_InvoiceItem_ModifiedDate]
GO

ALTER TABLE [InvoiceItem] DROP CONSTRAINT [PK_InvoiceItem]
GO

/* Drop table */

DROP TABLE [InvoiceItem]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Shipper"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Shipper] DROP CONSTRAINT [DEF_Shipper_AddedBy]
GO

ALTER TABLE [Shipper] DROP CONSTRAINT [DEF_Shipper_AddedDate]
GO

ALTER TABLE [Shipper] DROP CONSTRAINT [DEF_Shipper_ModifiedBy]
GO

ALTER TABLE [Shipper] DROP CONSTRAINT [DEF_Shipper_ModifiedDate]
GO

ALTER TABLE [Shipper] DROP CONSTRAINT [PK_Shipper]
GO

/* Drop table */

DROP TABLE [Shipper]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ContactTitle"                                              */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_AddedBy]
GO

ALTER TABLE [ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_AddedDate]
GO

ALTER TABLE [ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_ModifiedBy]
GO

ALTER TABLE [ContactTitle] DROP CONSTRAINT [DEF_ContactTitle_ModifiedDate]
GO

ALTER TABLE [ContactTitle] DROP CONSTRAINT [PK_ContactTitle]
GO

/* Drop table */

DROP TABLE [ContactTitle]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Title"                                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Title] DROP CONSTRAINT [DEF_Title_AddedBy]
GO

ALTER TABLE [Title] DROP CONSTRAINT [DEF_Title_AddedDate]
GO

ALTER TABLE [Title] DROP CONSTRAINT [DEF_Title_ModifiedBy]
GO

ALTER TABLE [Title] DROP CONSTRAINT [DEF_Title_ModifiedDate]
GO

ALTER TABLE [Title] DROP CONSTRAINT [PK_Title]
GO

/* Drop table */

DROP TABLE [Title]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "TitleOfCourtesy"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_AddedBy]
GO

ALTER TABLE [TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_AddedDate]
GO

ALTER TABLE [TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_ModifiedBy]
GO

ALTER TABLE [TitleOfCourtesy] DROP CONSTRAINT [DEF_TitleOfCourtesy_ModifiedDate]
GO

ALTER TABLE [TitleOfCourtesy] DROP CONSTRAINT [PK_TitleOfCourtesy]
GO

/* Drop table */

DROP TABLE [TitleOfCourtesy]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "HolidayDescription"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_AddedBy]
GO

ALTER TABLE [HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_AddedDate]
GO

ALTER TABLE [HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_ModifiedBy]
GO

ALTER TABLE [HolidayDescription] DROP CONSTRAINT [DEF_HolidayDescription_ModifiedDate]
GO

ALTER TABLE [HolidayDescription] DROP CONSTRAINT [PK_HolidayDescription]
GO

/* Drop table */

DROP TABLE [HolidayDescription]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Holiday"                                                   */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Holiday] DROP CONSTRAINT [DEF_Holiday_AddedBy]
GO

ALTER TABLE [Holiday] DROP CONSTRAINT [DEF_Holiday_AddedDate]
GO

ALTER TABLE [Holiday] DROP CONSTRAINT [DEF_Holiday_ModifiedBy]
GO

ALTER TABLE [Holiday] DROP CONSTRAINT [DEF_Holiday_ModifiedDate]
GO

ALTER TABLE [Holiday] DROP CONSTRAINT [PK_Holiday]
GO

/* Drop table */

DROP TABLE [Holiday]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "Log"                                                       */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [Log] DROP CONSTRAINT [DEF_Log_LogDate]
GO

ALTER TABLE [Log] DROP CONSTRAINT [PK_Log]
GO

/* Drop table */

DROP TABLE [Log]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SystemRole"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [SystemRole] DROP CONSTRAINT [DEF_SystemRole_AddedBy]
GO

ALTER TABLE [SystemRole] DROP CONSTRAINT [DEF_SystemRole_AddedDate]
GO

ALTER TABLE [SystemRole] DROP CONSTRAINT [DEF_SystemRole_ModifiedBy]
GO

ALTER TABLE [SystemRole] DROP CONSTRAINT [DEF_SystemRole_ModifiedDate]
GO

ALTER TABLE [SystemRole] DROP CONSTRAINT [PK_SystemRole]
GO

/* Drop table */

DROP TABLE [SystemRole]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SystemUser"                                                */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [SystemUser] DROP CONSTRAINT [DEF_SystemUser_AddedBy]
GO

ALTER TABLE [SystemUser] DROP CONSTRAINT [DEF_SystemUser_AddedDate]
GO

ALTER TABLE [SystemUser] DROP CONSTRAINT [DEF_SystemUser_ModifiedBy]
GO

ALTER TABLE [SystemUser] DROP CONSTRAINT [DEF_SystemUser_ModifiedDate]
GO

ALTER TABLE [SystemUser] DROP CONSTRAINT [PK_SystemUser]
GO

/* Drop table */

DROP TABLE [SystemUser]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SystemUserToSystemRole"                                    */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_AddedBy]
GO

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_AddedDate]
GO

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_ModifiedBy]
GO

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [DEF_SystemUserToSystemRole_ModifiedDate]
GO

ALTER TABLE [SystemUserToSystemRole] DROP CONSTRAINT [PK_SystemUserToSystemRole]
GO

/* Drop table */

DROP TABLE [SystemUserToSystemRole]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "CommunicationType"                                         */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [CommunicationType] DROP CONSTRAINT [DEF_CommunicationType_AddedBy]
GO

ALTER TABLE [CommunicationType] DROP CONSTRAINT [DEF_CommunicationType_AddedDate]
GO

ALTER TABLE [CommunicationType] DROP CONSTRAINT [DEF_CommunicationType_ModifiedBy]
GO

ALTER TABLE [CommunicationType] DROP CONSTRAINT [DEF_CommunicationType_ModifiedDate]
GO

ALTER TABLE [CommunicationType] DROP CONSTRAINT [PK_CommunicationType]
GO

/* Drop table */

DROP TABLE [CommunicationType]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "CommunicationOrder"                                        */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [CommunicationOrder] DROP CONSTRAINT [DEF_CommunicationOrder_AddedBy]
GO

ALTER TABLE [CommunicationOrder] DROP CONSTRAINT [DEF_CommunicationOrder_AddedDate]
GO

ALTER TABLE [CommunicationOrder] DROP CONSTRAINT [DEF_CommunicationOrder_ModifiedBy]
GO

ALTER TABLE [CommunicationOrder] DROP CONSTRAINT [DEF_CommunicationOrder_ModifiedDate]
GO

ALTER TABLE [CommunicationOrder] DROP CONSTRAINT [PK_CommunicationOrder]
GO

/* Drop table */

DROP TABLE [CommunicationOrder]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "AddressType"                                               */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [AddressType] DROP CONSTRAINT [DEF_AddressType_AddedBy]
GO

ALTER TABLE [AddressType] DROP CONSTRAINT [DEF_AddressType_AddedDate]
GO

ALTER TABLE [AddressType] DROP CONSTRAINT [DEF_AddressType_ModifiedBy]
GO

ALTER TABLE [AddressType] DROP CONSTRAINT [DEF_AddressType_ModifiedDate]
GO

ALTER TABLE [AddressType] DROP CONSTRAINT [PK_AddressType]
GO

/* Drop table */

DROP TABLE [AddressType]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "CustomerAddress"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [DEF_CustomerAddress_AddedBy]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [DEF_CustomerAddress_AddedDate]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [DEF_CustomerAddress_ModifiedBy]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [DEF_CustomerAddress_ModifiedDate]
GO

ALTER TABLE [CustomerAddress] DROP CONSTRAINT [PK_CustomerAddress]
GO

/* Drop table */

DROP TABLE [CustomerAddress]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SupplierCommunication"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [DEF_SupplierCommunication_AddedBy]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [DEF_SupplierCommunication_AddedDate]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [DEF_SupplierCommunication_ModifiedBy]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [DEF_SupplierCommunication_ModifiedDate]
GO

ALTER TABLE [SupplierCommunication] DROP CONSTRAINT [PK_SupplierCommunication]
GO

/* Drop table */

DROP TABLE [SupplierCommunication]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "CustomerCommunication"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [DEF_CustomerCommunication_AddedBy]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [DEF_CustomerCommunication_AddedDate]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [DEF_CustomerCommunication_ModifiedBy]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [DEF_CustomerCommunication_ModifiedDate]
GO

ALTER TABLE [CustomerCommunication] DROP CONSTRAINT [PK_CustomerCommunication]
GO

/* Drop table */

DROP TABLE [CustomerCommunication]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "EmployeeCommunication"                                     */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [DEF_EmployeeCommunication_AddedBy]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [DEF_EmployeeCommunication_AddedDate]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [DEF_EmployeeCommunication_ModifiedBy]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [DEF_EmployeeCommunication_ModifiedDate]
GO

ALTER TABLE [EmployeeCommunication] DROP CONSTRAINT [PK_EmployeeCommunication]
GO

/* Drop table */

DROP TABLE [EmployeeCommunication]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "ShipperCommunication"                                      */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [DEF_ShipperCommunication_AddedBy]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [DEF_ShipperCommunication_AddedDate]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [DEF_ShipperCommunication_ModifiedBy]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [DEF_ShipperCommunication_ModifiedDate]
GO

ALTER TABLE [ShipperCommunication] DROP CONSTRAINT [PK_ShipperCommunication]
GO

/* Drop table */

DROP TABLE [ShipperCommunication]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "EmployeeAddress"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [DEF_EmployeeAddress_AddedBy]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [DEF_EmployeeAddress_AddedDate]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [DEF_EmployeeAddress_ModifiedBy]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [DEF_EmployeeAddress_ModifiedDate]
GO

ALTER TABLE [EmployeeAddress] DROP CONSTRAINT [PK_EmployeeAddress]
GO

/* Drop table */

DROP TABLE [EmployeeAddress]
GO

/* ---------------------------------------------------------------------- */
/* Drop table "SupplierAddress"                                           */
/* ---------------------------------------------------------------------- */

/* Drop constraints */

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [DEF_SupplierAddress_AddedBy]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [DEF_SupplierAddress_AddedDate]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [DEF_SupplierAddress_ModifiedBy]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [DEF_SupplierAddress_ModifiedDate]
GO

ALTER TABLE [SupplierAddress] DROP CONSTRAINT [PK_SupplierAddress]
GO

/* Drop table */

DROP TABLE [SupplierAddress]
GO
