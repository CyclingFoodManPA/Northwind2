/*****************************************************************************
 *        Class Name: ErrorMessage
 *  Class Decription: Contains the error message returned in wcf.
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
    public class ErrorMessage
    {
        [DataMember(Order = 0)]
        public string Code { get; set; }

        [DataMember(Order = 1)]
        public string Message { get; set; }
    }
}
