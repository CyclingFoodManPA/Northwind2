/*****************************************************************************
 *        Class Name: Status
 *  Class Decription: Contains the status returned in wcf.
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

namespace Northwind2.ServiceWcf.DataContracts.Common
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public class Status
    {
        [DataMember(IsRequired = true, Order = 0)]
        public int StatusCode { get; set; }

        [DataMember(Order = 1)]
        public string StatusMsg { get; set; }

        [DataMember(Order = 2)]
        public string Details { get; set; }
    }
}
