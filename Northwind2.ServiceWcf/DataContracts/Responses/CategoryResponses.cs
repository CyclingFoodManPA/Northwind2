/*****************************************************************************
 *        Class Name: CategorysResponse
 *  Class Decription: Contains response functionality for CategoryService
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
    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "CategorySelectList", ItemName = "ListItem")]
    public class CategorySelectList : List<ListItemSDO> { }

    [DataContract(Name = "CategorySelectListResponse", Namespace = Constants.NAMESPACE)]
    public class CategorySelectListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public CategorySelectList CategorySelectList { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }
}
