/*****************************************************************************
 *        Class Name: ContactTitleConverterList
 *  Class Decription: Contains the converter for the ContactTitle list
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.Entities.Models;
using Northwind2.ServiceWcf.Converters.Infrastructure;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.Converters
{
    public class ContactTitleManualConverterList : BaseConverter<ContactTitle, ContactTitleSDO>
    {
        public override ContactTitleSDO ConvertObject(ContactTitle entity)
        {
            //Manual one-to-one mapping
            return new ContactTitleSDO()
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
        }
    }
}