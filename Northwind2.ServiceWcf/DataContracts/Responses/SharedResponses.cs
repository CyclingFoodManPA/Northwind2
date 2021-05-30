/*****************************************************************************
 *        Class Name: SharedResponses
 *  Class Decription: Contains response functionality for a number of services
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

namespace Northwind2.ServiceWcf.Other.DataContracts.Responses
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ReturnNumber
    {
        [DataMember(IsRequired = false, Order = 0)]
        public int NumberValue { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string Message { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ReturnString
    {
        [DataMember(IsRequired = false, Order = 0)]
        public string StringValue { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }
}
