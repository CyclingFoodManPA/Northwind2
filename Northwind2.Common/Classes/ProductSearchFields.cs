/*****************************************************************************
 *         Enum Name: ProductSearchFields
 *  Class Decription: Contains search fields for Product
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.Common.Classes.Infrastructure;

namespace Northwind2.Common.Classes
{
    public class ProductSearchFields : SearchBase
    {
        public string ProductName { get; set; }
        public int SupplierID { get; set; }
        public string SupplierName { get; set; }
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public decimal MinUnitPrice { get; set; }
        public decimal MaxUnitPrice { get; set; }
        public int MinUnitsInStock { get; set;}
        public int MaxUnitsInStock { get; set;}
        public int MinUnitsOnOrder { get; set;}
        public int MaxUnitsOnOrder { get; set;}
        public int MinReorderLevel { get; set;}
        public int MaxReorderLevel { get; set; }
        public short IsActive { get; set;}
    }
}