using Northwind2.BDO;
/*****************************************************************************
 *        Class Name: CustomerConverterList
 *  Class Decription: Contains the converter for the Customer list
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using Northwind2.ServiceWcf.Converters.Infrastructure;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.Converters
{
    public class CustomerManualConverterList : BaseConverter<CustomerBDO, CustomerSDO>
    {
        public override CustomerSDO ConvertObject(CustomerBDO bdo)
        {
            //Manual one-to-one mapping
            return new CustomerSDO()
            {
                CustomerID = bdo.CustomerID,
                CustomerName = bdo.CustomerName,
                IsActive = bdo.IsActive,
                AddedBy = bdo.AddedBy,
                AddedDate = bdo.AddedDate,
                ModifiedBy = bdo.ModifiedBy,
                ModifiedDate = bdo.ModifiedDate,
                Modified = bdo.Modified
            };
        }
    }
}