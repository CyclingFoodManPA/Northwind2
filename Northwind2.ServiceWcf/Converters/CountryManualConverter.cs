/*****************************************************************************
 *        Class Name: CountryManualConverter
 *  Class Decription: Contains the converter for the Country entity
 *              Date: Monday, May 24, 2021
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.Common.Converters;
using Northwind2.Entities.Models;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.Converters
{
    public class CountryManualConverter : BaseConverter<Country, CountrySDO>
    {
        public override CountrySDO ConvertObject(Country entity)
        {
            //Manual one-to-one mapping
            CountrySDO Country = new CountrySDO()
            {
                CountryID = entity.CountryID,
                CountryName = entity.CountryName,
                IsActive = entity.IsActive,
                AddedBy = entity.AddedBy,
                AddedDate = entity.AddedDate,
                ModifiedBy = entity.ModifiedBy,
                ModifiedDate = entity.ModifiedDate,
                Modified = entity.Modified
            };

            if (entity.Customers != null)
            {
                foreach (var item in entity.Customers)
                {
                    Country.Customers.Add(new ListItemSDO
                    {
                        ID = item.CustomerID,
                        Name = item.CustomerName
                    });
                }
            }

            if (entity.Suppliers != null)
            {
                foreach (var item in entity.Suppliers)
                {
                    Country.Suppliers.Add(new ListItemSDO
                    {
                        ID = item.SupplierID,
                        Name = item.SupplierName
                    });
                }
            }

            if (entity.Invoices != null)
            {
                foreach(var item in entity.Invoices)
                {
                    Country.Invoices.Add(new ListItemSDO
                    {
                        ID = item.InvoiceID,
                        Name = item.InvoiceDate.ToString()
                    });
                }
            }
            return Country;
        }
    }
}
