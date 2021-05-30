/*****************************************************************************
 *        Class Name: SuppliersResponse
 *  Class Decription: Contains response functionality for SupplierService
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
    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "SupplierSelectList", ItemName = "ListItem")]
    public class SupplierSelectList : List<ListItemSDO> { }

    [DataContract(Name = "SupplierSelectListResponse", Namespace = Constants.NAMESPACE)]
    public class SupplierSelectListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public SupplierSelectList SupplierSelectList { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }
}
