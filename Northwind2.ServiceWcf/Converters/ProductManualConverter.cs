/*****************************************************************************
 *        Class Name: ProductManualConverter
 *  Class Decription: Contains the converter for the Product BDO
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.BDO;
using Northwind2.ServiceWcf.Converters.Infrastructure;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.Converters
{
    public class ProductManualConverter : BaseConverter<ProductBDO, ProductSDO>
    {
        public override ProductSDO ConvertObject(ProductBDO bdo)
        {
            ProductSDO sdo = new ProductSDO();
            sdo.ProductID = bdo.ProductID;
            sdo.ProductName = bdo.ProductName;
            sdo.SupplierID = bdo.SupplierID;
            sdo.SupplierName = bdo.SupplierName;
            sdo.CategoryID = bdo.CategoryID;
            sdo.CategoryName = bdo.CategoryName;
            sdo.UnitPrice = bdo.UnitPrice;
            sdo.UnitsInStock = bdo.UnitsInStock;
            sdo.UnitsOnOrder = bdo.UnitsOnOrder;
            sdo.ReorderLevel = bdo.ReorderLevel;
            sdo.IsActive = bdo.IsActive;
            sdo.AddedBy = bdo.AddedBy;
            sdo.AddedDate = bdo.AddedDate;
            sdo.ModifiedBy = bdo.ModifiedBy;
            sdo.ModifiedDate = bdo.ModifiedDate;
            sdo.Modified = bdo.Modified;

            if (bdo.Invoices != null)
            {
                foreach (var item in bdo.Invoices)
                {
                    sdo.Invoices.Add(new ListItemSDO
                    {
                        ID = item.ID,
                        Date = item.Date,
                        Name = item.Name,
                        Amount = item.Amount
                    });
                }
            }

            return sdo;
        }
    }
}
