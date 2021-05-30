/*****************************************************************************
 *        Class Name: ProductRequest
 *  Class Decription: Contains request functionality for Product
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
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.DataContracts.Requests
{
    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ProductSearchFields
    {
        [DataMember(Order = 1, IsRequired = false)]
        public string ProductName { get; set; }

        [DataMember(Order = 2, IsRequired = false)]
        public int SupplierID { get; set; }
        [DataMember(Order = 3, IsRequired = false)]
        public string SupplierName { get; set; }

        [DataMember(Order = 4, IsRequired = false)]
        public int CategoryID { get; set; }
        [DataMember(Order = 5, IsRequired = false)]
        public string CategoryName { get; set; }

        [DataMember(Order = 6, IsRequired = false)]
        public decimal MinUnitPrice { get; set; }
        [DataMember(Order = 7, IsRequired = false)]
        public decimal MaxUnitPrice { get; set; }

        [DataMember(Order = 8, IsRequired = false)]
        public decimal MinUnitsInStock { get; set; }
        [DataMember(Order = 9, IsRequired = false)]
        public decimal MaxUnitsInStock { get; set; }

        [DataMember(Order = 10, IsRequired = false)]
        public decimal MinUnitsOnOrder { get; set; }
        [DataMember(Order = 11, IsRequired = false)]
        public decimal MaxUnitsOnOrder { get; set; }
        
        [DataMember(Order = 12, IsRequired = false)]
        public decimal MinReorderLevel { get; set; }
        [DataMember(Order = 13, IsRequired = false)]
        public decimal MaxReorderLevel { get; set; }

        [DataMember(Order = 14, IsRequired = false)]
        public bool IsActive { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ProductSaveRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public ProductSDO Product { get; set; }
    }

    [DataContract(Namespace = Constants.NAMESPACE)]
    public class ProductsGetBySearchRequest
    {
        [DataMember(Order = 1, IsRequired = false)]
        public ProductSearchFields ProductSearchFields { get; set; }

        [DataMember(Order = 2, IsRequired = false)]
        public PaginationRequest PaginationRequest { get; set; }
    }
}