/*****************************************************************************
 *        Class Name: CountryResponse
 *  Class Decription: Contains response functionality for CountryService
 *              Date: Wednesday, July 6, 2016
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

namespace Northwind2.ServiceWcf.Other.DataContracts.Responses
{
    [DataContract(Name = "CountryResponse", Namespace = Constants.NAMESPACE)]
    public class CountryResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public CountrySDO Country { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "CountrySelectList", ItemName = "ListItem")]
    public class CountrySelectList : List<ListItemSDO> { }

    [DataContract(Name = "CountrySelectListResponse", Namespace = Constants.NAMESPACE)]
    public class CountrySelectListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public CountrySelectList CountrySelectList { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "Countries", ItemName = "Country")]
    public class Countries : List<CountrySDO> { }

    [DataContract(Name = "CountryListResponse", Namespace = Constants.NAMESPACE)]
    public class CountryListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public Countries Countries { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }
}
