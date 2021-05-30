USE Northwind2
GO

PRINT '****************'
PRINT 'Security Inserts'
PRINT '****************'
GO
PRINT '***********************'
PRINT 'ApplicationRole Inserts'
PRINT '***********************'
GO
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('Administrator', 1)
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('Customers', 1)
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('Guest', 1)
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('HumanResources', 1)
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('Products', 1)
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('Sales', 1)
INSERT INTO Security.ApplicationRole (ApplicationRoleName, IsActive) VALUES ('Security', 1)
GO

PRINT '***********************'
PRINT 'ApplicationUser Inserts'
PRINT '***********************'
GO
DECLARE @ApplicationUserID TINYINT
DECLARE @Modified TIMESTAMP
DECLARE @Now DATETIME2
SET @Now = CURRENT_TIMESTAMP
EXEC Security.usp_ApplicationUser_Add @ApplicationUserLastName='Safford', @ApplicationUserFirstName='Keith', @UserName='ksafford', @Password='c33a803c91c3afd19e6f4a9c5e120c8a', @Email='ksafford@northwind2.com', @LastPasswordChangeDate=@Now, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserID=@ApplicationUserID, @newModified=@Modified
EXEC Security.usp_ApplicationUser_Add @ApplicationUserLastName='Customer', @ApplicationUserFirstName='Joe', @UserName='jcustomer', @Password='c33a803c91c3afd19e6f4a9c5e120c8a', @Email='jcustomer@northwind2.com', @LastPasswordChangeDate=@Now, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserID=@ApplicationUserID, @newModified=@Modified
EXEC Security.usp_ApplicationUser_Add @ApplicationUserLastName='Hure', @ApplicationUserFirstName='Jenny', @UserName='jhure', @Password='c33a803c91c3afd19e6f4a9c5e120c8a', @Email='jhure@northwind2.com', @LastPasswordChangeDate=@Now, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserID=@ApplicationUserID, @newModified=@Modified
EXEC Security.usp_ApplicationUser_Add @ApplicationUserLastName='Product', @ApplicationUserFirstName='Tommy', @UserName='tproduct', @Password='c33a803c91c3afd19e6f4a9c5e120c8a', @Email='tproduct@northwind2.com', @LastPasswordChangeDate=@Now, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserID=@ApplicationUserID, @newModified=@Modified
EXEC Security.usp_ApplicationUser_Add @ApplicationUserLastName='Sales', @ApplicationUserFirstName='Sue', @UserName='ssales', @Password='c33a803c91c3afd19e6f4a9c5e120c8a', @Email='ssales@northwind2.com', @LastPasswordChangeDate=@Now, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserID=@ApplicationUserID, @newModified=@Modified
GO

PRINT '****************************************'
PRINT 'ApplicationUserToApplicationRole Inserts'
PRINT '****************************************'
GO
DECLARE @ApplicationUserToApplicationRoleID INT
DECLARE @Modified TIMESTAMP
EXEC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID=1, @ApplicationUserID=1, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserToApplicationRoleID=@ApplicationUserToApplicationRoleID OUT, @newModified=@Modified OUT
EXEC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID=6, @ApplicationUserID=1, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserToApplicationRoleID=@ApplicationUserToApplicationRoleID OUT, @newModified=@Modified OUT
EXEC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID=2, @ApplicationUserID=2, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserToApplicationRoleID=@ApplicationUserToApplicationRoleID OUT, @newModified=@Modified OUT
EXEC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID=3, @ApplicationUserID=3, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserToApplicationRoleID=@ApplicationUserToApplicationRoleID OUT, @newModified=@Modified OUT
EXEC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID=4, @ApplicationUserID=4, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserToApplicationRoleID=@ApplicationUserToApplicationRoleID OUT, @newModified=@Modified OUT
EXEC Security.usp_ApplicationUserToApplicationRole_Add @ApplicationRoleID=5, @ApplicationUserID=5, @AddedBy='ksafford', @ModifiedBy='ksafford', @newApplicationUserToApplicationRoleID=@ApplicationUserToApplicationRoleID OUT, @newModified=@Modified OUT
GO