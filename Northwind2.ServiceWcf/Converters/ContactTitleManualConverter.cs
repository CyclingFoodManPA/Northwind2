/*****************************************************************************
 *        Class Name: ContactTitleManualConverter
 *  Class Decription: Contains the converter for the ContactTitle entity
 *              Date: Tuesday, July 5, 2016
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
    public class ContactTitleManualConverter : BaseConverter<ContactTitle, ContactTitleSDO>
    {
        public override ContactTitleSDO ConvertObject(ContactTitle entity)
        {
            //Manual one-to-one mapping
            ContactTitleSDO contactTitle = new ContactTitleSDO()
            {
                ContactTitleID = entity.ContactTitleID,
                ContactTitleName = entity.ContactTitleName,
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
                    contactTitle.Customers.Add(new ListItemSDO
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
                    contactTitle.Suppliers.Add(new ListItemSDO
                    {
                        ID = item.SupplierID,
                        Name = item.SupplierName
                    });
                }
            }

            return contactTitle;
        }
    }
}
