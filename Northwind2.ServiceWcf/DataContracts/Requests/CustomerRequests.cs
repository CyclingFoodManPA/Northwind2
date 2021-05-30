/*****************************************************************************
 *        Class Name: ContactTitleRequest
 *  Class Decription: Contains request functionality for Customer
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Runtime.Serialization;
using Northwind2.Common.Constants;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.DataContracts.Requests
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public class CustomerSearchFields
    {
        [DataMember(Order = 1, IsRequired = false)]
        public string CustomerName { get; set; }
        [DataMember(Order = 2, IsRequired = false)]
        public string ContactName { get; set; }
        [DataMember(Order = 3, IsRequired = false)]
        public int ContactTitleID { get; set; }
        [DataMember(Order = 4, IsRequired = false)]
        public string ContactTitleName { get; set; }
        [DataMember(Order = 5, IsRequired = false)]
        public string Address1 { get; set; }
        [DataMember(Order = 6, IsRequired = false)]
        public string City { get; set; }
        [DataMember(Order = 7, IsRequired = false)]
        public string Region { get; set; }
        [DataMember(Order = 8, IsRequired = false)]
        public string PostalCode { get; set; }
        [DataMember(Order = 9, IsRequired = false)]
        public int CountryID { get; set; }
        [DataMember(Order = 10, IsRequired = false)]
        public string CountryName { get; set; }
        [DataMember(Order = 11, IsRequired = false)]
        public string Phone { get; set; }
        [DataMember(Order = 12, IsRequired = false)]
        public string Fax { get; set; }
        [DataMember(Order = 13, IsRequired = false)]
        public string Email { get; set; }
        [DataMember(Order = 14, IsRequired = false)]
        public bool IsActive { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class CustomerSaveRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public CustomerSDO Customer { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class CustomersGetBySearchRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public CustomerSearchFields CustomerSearchFields { get; set; }  

        [DataMember(Order = 2, IsRequired = false)]
        public PaginationRequest PaginationRequest { get; set; }
    }
}