/*****************************************************************************
 *        Class Name: CustomerManualConverter
 *  Class Decription: Contains the converter for the Customer BDO
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
    public class CustomerManualConverter : BaseConverter<CustomerBDO, CustomerSDO>
    {
        public override CustomerSDO ConvertObject(CustomerBDO bdo)
        {
            CustomerSDO sdo = new CustomerSDO();
            sdo.CustomerID = bdo.CustomerID;
            sdo.CustomerName = bdo.CustomerName;
            sdo.ContactName = bdo.ContactName;
            sdo.ContactTitleID = bdo.ContactTitleID;
            sdo.ContactTitleName = bdo.ContactTitleName;
            sdo.Address1 = bdo.Address1;
            sdo.Address2 = bdo.Address2;
            sdo.City = bdo.City;
            sdo.Region = bdo.Region;
            sdo.PostalCode = bdo.PostalCode;
            sdo.CountryID = bdo.CountryID;
            sdo.Phone = bdo.Phone;
            sdo.Fax = bdo.Fax;
            sdo.CustomerIDOld = bdo.CustomerIDOld;
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
