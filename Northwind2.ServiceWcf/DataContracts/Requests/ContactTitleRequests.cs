/*****************************************************************************
 *        Class Name: ContactTitleRequest
 *  Class Decription: Contains request functionality for ContactTitleService
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
using Northwind2.ServiceWcf.DataContracts.Requests;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.DataContracts.Requests
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public enum ContactTitleSearchField
    {
        [EnumMember]
        ContactTitleID,
        [EnumMember]
        ContactTitleName
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ContactTitleSaveRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public ContactTitleSDO ContactTitle { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ContactTitlesGetBySearchRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public int ContactTitleId { get; set; }

        [DataMember(Order = 2, IsRequired = false)]
        public string ContactTitleSearchText { get; set; }

        [DataMember(Order = 3, IsRequired = false)]
        public PaginationRequest PaginationRequest { get; set; }
    }
}