/*****************************************************************************
 *        Class Name: BaseConverter
 *  Class Decription: Contains the base converter for the AutoMapConverter
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using System.Linq;

namespace Northwind2.ServiceWcf.Converters.Infrastructure
{
    public abstract class BaseConverter<TSourceObj, TDestinationObj> : IBaseConverter<TSourceObj, TDestinationObj>
        where TSourceObj : class
        where TDestinationObj : class
    {
        //Any derived class needs this to convert for a single object
        public abstract TDestinationObj ConvertObject(TSourceObj srcObj);

        //Convert collection of source object to destination object
        public virtual List<TDestinationObj> ConvertObjectCollection(IEnumerable<TSourceObj> srcObjList)
        {
            if (srcObjList == null) return null;
            var destList = srcObjList.Select(item => this.ConvertObject(item));
            return destList.ToList();
        }
    }
}
