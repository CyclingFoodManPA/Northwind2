/*****************************************************************************
 *        Class Name: CustomersResponse
 *  Class Decription: Contains response functionality for CustomerService
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.DataContracts.Responses
{
    [DataContract(Name = "CustomerResponse", Namespace = Constants.NAMESPACE)]
    public class CustomerResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public CustomerSDO Customer { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }
    [DataContract(Name = "CustomerResponse", Namespace = Constants.NAMESPACE)]
    public class CustomerCMResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public CustomerSDO Customer { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [DataContract(Name = "CustomerListResponse", Namespace = Constants.NAMESPACE)]
    public class CustomerListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public Customers Customers { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "Customers", ItemName = "Customer")]
    public class Customers : List<CustomerSDO> { }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "CustomerSelectList", ItemName = "ListItem")]
    public class CustomerSelectList : List<ListItemSDO> { }

    [DataContract(Name = "CustomerSelectListResponse", Namespace = Constants.NAMESPACE)]
    public class CustomerSelectListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public CustomerSelectList CustomerSelectList { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }
}
