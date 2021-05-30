/*****************************************************************************
 *        Class Name: CustomerSDO
 *  Class Decription: Contains the CustomerSDO information for the service
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
    public class CustomerSDO
    {
        public CustomerSDO()
        {
            this.Invoices = new HashSet<ListItemSDO>();
        }

        [DataMember(Order = 0)]
        public int CustomerID { get; set; }
        [DataMember(Order = 1)]
        public string CustomerName { get; set; }
        [DataMember(Order = 2)]
        public string ContactName { get; set; }
        [DataMember(Order = 3)]
        public int ContactTitleID { get; set; }
        [DataMember(Order = 4)]
        public string ContactTitleName { get; set; }
        [DataMember(Order = 5)]
        public string Address1 { get; set; }
        [DataMember(Order = 6)]
        public string Address2 { get; set; }
        [DataMember(Order = 7)]
        public string City { get; set; }
        [DataMember(Order = 8)]
        public string Region { get; set; }
        [DataMember(Order = 9)]
        public string PostalCode { get; set; }
        [DataMember(Order = 10)]
        public int CountryID { get; set; }
        [DataMember(Order = 11)]
        public string CountryName { get; set; }
        [DataMember(Order = 12)]
        public string Phone { get; set; }
        [DataMember(Order = 13)]
        public string Fax { get; set; }
        [DataMember(Order = 14)]
        public string Email { get; set; }
        [DataMember(Order = 15)]
        public string CustomerIDOld { get; set; }
        [DataMember(Order = 16)]
        public bool IsActive { get; set; }
        [DataMember(Order = 17)]
        public string AddedBy { get; set; }
        [DataMember(Order = 18)]
        public DateTime AddedDate { get; set; }
        [DataMember(Order = 19)]
        public string ModifiedBy { get; set; }
        [DataMember(Order = 20)]
        public DateTime ModifiedDate { get; set; }
        [DataMember(Order = 21)]
        public Byte[] Modified { get; set; }

        [DataMember(Order = 22)]
        public virtual ICollection<ListItemSDO> Invoices { get; set; }
    }
}