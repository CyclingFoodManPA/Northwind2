/*****************************************************************************
 *        Class Name: SharedRequest
 *  Class Decription: Contains shared request functionality
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

namespace Northwind2.ServiceWcf.DataContracts.Requests
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public class QueryByIdRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public int Id { get; set; }
    }

    public class QueryByIdsRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public Ids IdList { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE)]
    public class Ids : List<int>
    {
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class QueryByStringRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public string StringValue { get; set; }
    }

    public class QueryByStringsRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public Strings StringList { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE)]
    public class Strings : List<string>
    {
    }
}
