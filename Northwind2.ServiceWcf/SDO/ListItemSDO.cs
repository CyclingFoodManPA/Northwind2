/*****************************************************************************
 *        Class Name: ListItemSDO
 *  Class Decription: Contains the ListItem information for the service
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

namespace Northwind2.ServiceWcf.SDO
{
    [DataContract(Namespace = Constants.NAMESPACE, IsReference = true)]
    public class ListItemSDO
    {
        [DataMember(Order = 0)]
        public int ID { get; set; }
        [DataMember(Order = 1)]
        public string Name { get; set; }
        [DataMember(Order = 2)]
        public DateTime Date { get; set; }
        [DataMember(Order = 3)]
        public decimal Amount { get; set; }
    }
}
