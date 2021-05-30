/*****************************************************************************
 *        Class Name: ContactTitleResponse
 *  Class Decription: Contains response functionality for ContactTitleService
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.Common.Constants;
using Northwind2.ServiceWcf.SDO;
using System.Collections.Generic;
using System.Runtime.Serialization;

namespace Northwind2.ServiceWcf.Other.DataContracts.Responses
{
    [DataContract(Name = "ContactTitleResponse", Namespace = Constants.NAMESPACE)]
    public class ContactTitleResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public ContactTitleSDO ContactTitle { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "ContactTitleSelectList", ItemName = "ListItem")]
    public class ContactTitleSelectList : List<ListItemSDO> { }

    [DataContract(Name = "ContactTitleSelectListResponse", Namespace = Constants.NAMESPACE)]
    public class ContactTitleSelectListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public ContactTitleSelectList ContactTitleSelectList { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "Categories", ItemName = "ContactTitle")]
    public class ContactTitles : List<ContactTitleSDO> { }

    [DataContract(Name = "ContactTitleListResponse", Namespace = Constants.NAMESPACE)]
    public class ContactTitleListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public ContactTitles ContactTitles { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }
}
