/*****************************************************************************
 *        Class Name: PaginationRequest
 *  Class Decription: Contains request functionality for pagination
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;

namespace Northwind2.ServiceWcf.DataContracts.Requests
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public enum SortDirection
    {
        [EnumMember]
        Ascending,

        [EnumMember]
        Descending
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class PaginationRequest
    {
        [DataMember(Order = 0)]
        public int PageIndex { get; set; }

        [DataMember(Order = 1)]
        public int PageSize { get; set; }

        [DataMember(Order = 2)]
        public Sort Sort { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class Sort
    {
        [DataMember(Order = 0)]
        public string SortBy { get; set; }

        [DataMember(Order = 1)]
        public SortDirection SortDirection { get; set; }
    }
}
