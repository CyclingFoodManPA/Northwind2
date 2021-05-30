/*****************************************************************************
 *        Class Name: ListItemManualConverter
 *  Class Decription: Contains the converter for entity to data contract
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

namespace Northwind2.ServiceWcf.Converters.Infrastructure
{
    public class ListItemManualConverterEntity : BaseConverter<ListItem, ListItemSDO>
    {
        public override ListItemSDO ConvertObject(ListItem entity)
        {
            //Manual one-to-one mapping
            return new ListItemSDO()
            {
                ID = entity.ID,
                Name = entity.Name,
                Date = entity.Date,
                Amount = entity.Amount
            };
        }
    }
}