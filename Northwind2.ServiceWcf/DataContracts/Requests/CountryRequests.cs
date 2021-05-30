/*****************************************************************************
 *        Class Name: CountryRequest
 *  Class Decription: Contains request functionality for CountryService
 *              Date: Wednesday, July 6, 2016
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
    public enum CountrySearchField
    {
        [EnumMember]
        CountryID,
        [EnumMember]
        CountryName
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class CountrySaveRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public CountrySDO Country { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class CountriesGetBySearchRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public int CountryId { get; set; }

        [DataMember(Order = 2, IsRequired = false)]
        public string CountrySearchText { get; set; }

        [DataMember(Order = 3, IsRequired = false)]
        public PaginationRequest PaginationRequest { get; set; }
    }
}