/*****************************************************************************
 *       Interface Name: IBaseConverter
 * Interface Decription: Contains Interface for BaseConverter
 *                 Date: Tuesday, July 5, 2016
 *               Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;

namespace Northwind2.ServiceWcf.Converters.Infrastructure
{
    public interface IBaseConverter<TSourceObj, TDestinationObj>
        where TSourceObj : class
        where TDestinationObj : class
    {
        TDestinationObj ConvertObject(TSourceObj srcObj);
        List<TDestinationObj> ConvertObjectCollection(IEnumerable<TSourceObj> srcObj);
    }
}
