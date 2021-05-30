/*****************************************************************************
 *        Class Name: CountryConverterList
 *  Class Decription: Contains the converter for the Country list
 *              Date: Monday, May 24, 2021
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
    public class CountryManualConverterList : BaseConverter<Country, CountrySDO>
    {
        public override CountrySDO ConvertObject(Country entity)
        {
            //Manual one-to-one mapping
            return new CountrySDO()
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
        }
    }
}