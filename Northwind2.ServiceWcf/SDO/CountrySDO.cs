/*****************************************************************************
 *        Class Name: CountrySDO
 *  Class Decription: Contains the Country information for the service
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Collections.Generic;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;

namespace Northwind2.ServiceWcf.SDO
{
    [DataContract(Namespace = Constants.NAMESPACE, IsReference = true)]
    [KnownType(typeof(ListItemSDO))]
    public class CountrySDO
    {
        public CountrySDO()
        {
            this.Customers = new HashSet<ListItemSDO>();
            this.Suppliers = new HashSet<ListItemSDO>();
            this.Invoices = new HashSet<ListItemSDO>();
        }

        [DataMember(Order = 0)]
        public int CountryID { get; set; }
        [DataMember(Order = 1)]
        public string CountryName { get; set; }
        [DataMember(Order = 2)]
        public bool IsActive { get; set; }
        [DataMember(Order = 3)]
        public string AddedBy { get; set; }
        [DataMember(Order = 4)]
        public DateTime AddedDate { get; set; }
        [DataMember(Order = 5)]
        public string ModifiedBy { get; set; }
        [DataMember(Order = 6)]
        public DateTime ModifiedDate { get; set; }
        [DataMember(Order = 7)]
        public byte[] Modified { get; set; }

        [DataMember(Order = 8)]
        public virtual ICollection<ListItemSDO> Customers { get; set; }
        [DataMember(Order = 9)]
        public virtual ICollection<ListItemSDO> Suppliers { get; set; }
        [DataMember(Order = 10)]
        public virtual ICollection<ListItemSDO> Invoices { get; set; }
    }
}
