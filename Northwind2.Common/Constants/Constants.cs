/*****************************************************************************
 *        Class Name: Constants
 *  Class Decription: Contains all constants for the Northwind2 service
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Common.Constants
{
    public class Constants
    {
        public const string NAMESPACE = "http://www.northwind.com/services/Northwind2Data";
        public static int DEFAULT_USERID = -1;
        public static int DEFAULT_ROLEID = -1;
        public static int DEFAULT_HOLIDAY_DESCRIPTIONID = 1;
        public static int DEFAULT_STATEID = 39;
        public static int PAGE_SIZE = 10;
        public static string CANCEL_AND_RETURN_TO_LIST = "Cancel and return to List";
        public static string RETURN_TO_LIST = "Return to List";
        public static string UNKNOWN_USER = "??????";
        public static string TODO_NAME = "ToDo";
        public static string TD_SHORTNAME = "TD";

        #region SPROC Constants    

        #region Administration SPROCs

        public const string HOLIDAY_ADD = "Administration.usp_Holiday_Add";
        public const string HOLIDAY_GETALL = "Administration.usp_Holiday_GetAll";
        public const string HOLIDAY_GETALLLIST = "Administration.usp_Holiday_GetAllList";
        public const string HOLIDAY_GETBYID = "Administration.usp_Holiday_GetByID";
        public const string HOLIDAY_UPDATE = "Administration.usp_Holiday_Update";
        public const string HOLIDAY_DELETE = "Administration.usp_Holiday_Delete";

        #endregion Administration SPROCs

        #region Customers SPROCs

        #region Customer SPROCs

        public const string CUSTOMER_ADD = "Customers.usp_Customer_Add";
        public const string CUSTOMER_GETALL = "Customers.usp_Customer_GetAll";
        public const string CUSTOMER_GETALLLIST = "Customers.usp_Customer_GetAllList";
        public const string CUSTOMER_GETBYID = "Customers.usp_Customer_GetByID";
        public const string CUSTOMER_UPDATE = "Customers.usp_Customer_Update";
        public const string CUSTOMER_DELETE = "Customers.usp_Customer_Delete";

        #endregion Customer SPROCs

        #endregion Customers SPROCs

        #region Employee SPROCs

        public const string EMPLOYEE_ADD = "HumanResources.usp_Employee_Add";
        public const string EMPLOYEE_GETALL = "HumanResources.usp_Employee_GetAll";
        public const string EMPLOYEE_GETALLLIST = "HumanResources.usp_Employee_GetAllList";
        public const string EMPLOYEE_GETBYID = "HumanResources.usp_Employee_GetByID";
        public const string EMPLOYEE_UPDATE = "HumanResources.usp_Employee_Update";
        public const string EMPLOYEE_DELETE = "HumanResources.usp_Employee_Delete";

        #endregion Employee SPROCs

        #region Products SPROCs

        #region Category SPROCs

        public const string CATEGORY_GET_ALL_LIST = "Products_usp_Category_GetAllList";

        #endregion Category SPROCs

        #region Product SPROCs

        public const string PRODUCT_ADD = "Products.usp_Product_Add";
        public const string PRODUCT_GETALL = "Products.usp_Product_GetAll";
        public const string PRODUCT_GETALLLIST = "Products.usp_Product_GetAllList";
        public const string PRODUCT_GETBYID = "Products.usp_Product_GetByID";
        public const string PRODUCT_UPDATE = "Products.usp_Product_Update";
        public const string PRODUCT_DELETE = "Products.usp_Product_Delete";

        # endregion Product SPROCs

        #region Supplier SPROCs

        public const string SUPPLIER_GET_ALL_LIST = "Products.usp_Supplier_GetAllList";

        #endregion Supplier SPROCs

        #endregion Products SPROCs

        #region Security SPROCs

        public const string SECURITY_APPLICATIONUSER_ISVALID = "Security.usp_ApplicationUser_IsValid";
        public const string SECURITY_APPLICATIONUSERINAPPLICATIONROLE = "Security.usp_ApplicationUserToApplicationRole_IsIn";
        public const string SECURITY_APPLICATIONUSERTOAPPLICATIONROLES = "Security.usp_ApplicationUserToApplicationRole_UsernameRoleNamesGetAll";
        public const string SECURITY_APPLICATIONUSER_GETBYUSERNAME = "dbo.usp_ApplicationUser_GetByUserName";

        //public const string SECURITY_GETAPPLICATIONUSERBYUSERNAMEANDPASSWORD = "dbo.usp_ApplicationUser_GetByUserNameAndPassword";
        //public const string SECURITY_GETAPPLICATIONROLEBYROLENAME = "dbo.usp_ApplicationRole_GetByApplicationRoleName";
        //public const string SECURITY_GETAPPLICATIONROLEBYROLEID = "dbo.usp_ApplicationRole_GetByApplicationRoleID";
        //public const string SECURITY_GETAPPLICATIONUSERTOAPPLICATIONROLEBYIDs = "dbo.usp_ApplicationUserToApplicationRole_GetByIDs";
        //public const string SECURITY_GETAPPLICATIONUSERTOAPPLICATIONROLEBYAPPLICATIONUSERID = "dbo.usp_ApplicationUserToApplicationRole_GetByApplicationUserID";
        //public const string SYSTEMROLE_INSERT_SPROC = "Security.usp_SystemRole_Create";
        //public const string SYSTEMROLE_READALL_SPROC = "Security.usp_SystemRole_ReadAll";
        //public const string SYSTEMROLE_READBYID_SPROC = "Security.usp_SystemRole_ReadByID";
        //public const string SYSTEMROLE_READBYROLENAME_SPROC = "Security.usp_SystemRole_ReadByRoleName";
        //public const string SYSTEMROLE_UPDATE_SPROC = "Security.usp_SystemRole_Update";
        //public const string SYSTEMROLE_DELETE_SPROC = "Security.usp_SystemRole_Delete";
        //public const string SYSTEMUSER_INSERT_SPROC = "Security.usp_SystemUser_Insert";
        //public const string SYSTEMUSER_READALL_SPROC = "Security.usp_SystemUser_ReadAll";
        //public const string SYSTEMUSER_READALLLIST_SPROC = "Security.usp_SystemUser_ReadAllList";
        //public const string SYSTEMUSER_READBYID_SPROC = "Security.usp_SystemUser_ReadById";
        //public const string SYSTEMUSER_READBYUSERNAME_SPROC = "Security.usp_SystemUser_ReadByUsername";
        //public const string SYSTEMUSER_READBYUSERNAMEPASSWORD_SPROC = "Security.usp_SystemUser_ReadByUsernamePassword";
        //public const string SYSTEMUSER_UPDATE_SPROC = "Security.usp_SystemUser_Update";
        //public const string SYSTEMUSER_UPDATELASTACTIVITYDATE_SPROC = "Security.usp_SystemUser_UpdateLastActivityDate";
        //public const string SYSTEMUSER_UPDATEPASSWORD_SPROC = "Security.usp_SystemUser_UpdatePassword";
        //public const string SYSTEMUSER_DELETE_SPROC = "Security.usp_SystemUser_Delete";
        //public const string SYSTEMUSERTOSYSTEMROLE_INSERT_SPROC = "Security.usp_SystemUserToSystemRole_Insert";
        //public const string SYSTEMUSERTOSYSTEMROLE_READALL_SPROC = "Security.usp_SystemUserToSystemRole_ReadAll";
        //public const string SYSTEMUSERTOSYSTEMROLE_READBYID_SPROC = "Security.usp_SystemUserToSystemRole_ReadById";
        //public const string SYSTEMUSERTOSYSTEMROLE_READBYIDS_SPROC = "Security.usp_SystemUserToSystemRole_ReadByIds";
        //public const string SYSTEMUSERTOSYSTEMROLE_READBYSYSTEMUSERNAME_SPROC = "Security.usp_SystemUserToSystemRole_ReadBySystemUsername";
        //public const string SYSTEMUSERTOSYSTEMROLE_UPDATE_SPROC = "Security.usp_SystemUserToSystemRole_Update";
        //public const string SYSTEMUSERTOSYSTEMROLE_DELETE_SPROC = "Security.usp_SystemUserToSystemRole_Delete";

        #endregion Security SPROCs

        #endregion SPROC Constants

    }
}
