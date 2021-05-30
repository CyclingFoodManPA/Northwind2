/*****************************************************************************
 *       Interface Name: INorthwind2Service
 * Interface Decription: Contains Interface for the Northwind2Service
 *                 Date: Tuesday, July 5, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.ServiceModel;
using Northwind2.Common.Constants;
using Northwind2.ServiceWcf.DataContracts.Requests;
using Northwind2.ServiceWcf.DataContracts.Responses;
using Northwind2.ServiceWcf.Other.DataContracts.Responses;

namespace Northwind2.ServiceWcf.Contracts
{
    [ServiceContract(Namespace = Constants.NAMESPACE)]
    public interface INorthwind2Service
    {
        #region Administration Contracts...

        #region ContactTitle Contracts...

        [OperationContract()]
        ReturnNumber ContactTitleAdd(ContactTitleSaveRequest input);

        [OperationContract()]
        ContactTitleResponse ContactTitleGetByID(QueryByIdRequest request);

        [OperationContract()]
        ContactTitleSelectListResponse ContactTitleGetAllList();

        [OperationContract]
        ContactTitleListResponse ContactTitleGetAll(ContactTitlesGetBySearchRequest request);

        [OperationContract()]
        ReturnNumber ContactTitleUpdate(ContactTitleSaveRequest input);

        [OperationContract()]
        ReturnNumber ContactTitleDelete(QueryByIdRequest input);

        #endregion ContactTitle Contracts...

        #region Country Contracts...

        [OperationContract()]
        ReturnNumber CountryAdd(CountrySaveRequest input);

        [OperationContract()]
        CountryResponse CountryGetByID(QueryByIdRequest request);

        [OperationContract()]
        CountrySelectListResponse CountryGetAllList();

        [OperationContract]
        CountryListResponse CountryGetAll(CountriesGetBySearchRequest request);

        [OperationContract()]
        ReturnNumber CountryUpdate(CountrySaveRequest input);

        [OperationContract()]
        ReturnNumber CountryDelete(QueryByIdRequest input);

        #endregion Country Contracts...

        #endregion Administration Contracts...

        #region Customers Contracts...

        #region Customer Contracts...

        [OperationContract()]
        ReturnNumber CustomerAdd(CustomerSaveRequest input);

        [OperationContract()]
        CustomerResponse CustomerGetByID(QueryByIdRequest request);

        [OperationContract()]
        CustomerSelectListResponse CustomerGetAllList();

        [OperationContract]
        CustomerListResponse CustomerGetAll(CustomersGetBySearchRequest request);

        [OperationContract()]
        ReturnNumber CustomerUpdate(CustomerSaveRequest input);

        [OperationContract()]
        ReturnNumber CustomerDelete(QueryByIdRequest input);

        #endregion Customer Contracts...

        #endregion Customers Contracts...

        #region Products Contracts...

        #region Category Contracts...


        #endregion Category Contracts...

        [OperationContract()]
        CategorySelectListResponse CategoryGetAllList();

        #region Product Contracts...

        //[OperationContract()]
        //ReturnNumber ProductAdd(ProductSaveRequest input);

        //[OperationContract()]
        //ProductResponse ProductGetByID(QueryByIdRequest request);

        //[OperationContract()]
        //ProductSelectListResponse ProductGetAllList();

        [OperationContract]
        ProductListResponse ProductGetAll(ProductsGetBySearchRequest request);

        //[OperationContract()]
        //ReturnNumber ProductUpdate(ProductSaveRequest input);

        //[OperationContract()]
        //ReturnNumber ProductDelete(QueryByIdRequest input);

        #endregion Product Contracts...

        #region Supplier Contracts...

        [OperationContract()]
        SupplierSelectListResponse SupplierGetAllList();

        #endregion Supplier Contracts...

        #endregion Products Contracts...

        #region Security Contracts...

        [OperationContract()]
        LoginResponse LoginAuthentication(LoginRequest request);

        [OperationContract()]
        UserInRoleResponse ApplicationUserToApplicationRoleIsIn(UserInRoleRequest request);

        [OperationContract()]
        UserInRolesResponse UsernameInApplicationRoles(UserInRoleRequest request);

        #endregion Security Contracts...
    }
}
