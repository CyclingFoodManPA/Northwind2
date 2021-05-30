/*****************************************************************************
 *        Class Name: ProductSDO
 *  Class Decription: Contains the ProductSDO information for the service
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
    public class ProductSDO
    {
        public ProductSDO()
        {
            this.Invoices = new HashSet<ListItemSDO>();
        }

        [DataMember(Order = 0)]
        public int ProductID { get; set; }
        [DataMember(Order = 1)]
        public string ProductName { get; set; }
        [DataMember(Order = 2)]
        public int SupplierID { get; set; }
        [DataMember(Order = 3)]
        public string SupplierName { get; set; }
        [DataMember(Order = 4)]
        public int CategoryID { get; set; }
        [DataMember(Order = 5)]
        public string CategoryName { get; set; }
        [DataMember(Order = 6)]
        public string QuantityPerUnit { get; set; }
        [DataMember(Order = 7)]
        public decimal UnitPrice { get; set; }
        [DataMember(Order = 8)]
        public int UnitsInStock { get; set; }
        [DataMember(Order = 9)]
        public int UnitsOnOrder { get; set; }
        [DataMember(Order = 10)]
        public int ReorderLevel { get; set; }
        [DataMember(Order = 11)]
        public bool IsActive { get; set; }
        public string AddedBy { get; set; }
        [DataMember(Order = 12)]
        public DateTime AddedDate { get; set; }
        [DataMember(Order = 13)]
        public string ModifiedBy { get; set; }
        [DataMember(Order = 14)]
        public DateTime ModifiedDate { get; set; }
        [DataMember(Order = 15)]
        public Byte[] Modified { get; set; }

        [DataMember(Order = 16)]
        public virtual ICollection<ListItemSDO> Invoices { get; set; }
    }
}