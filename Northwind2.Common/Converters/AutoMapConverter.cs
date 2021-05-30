/*****************************************************************************
 *        Class Name: AutoMapConverter
 *  Class Decription: Contains the converter for converting an entity object
 *                    to a data contract object
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Common.Converters
{
    public class AutoMapConverter<TSourceObj, TDestinationObj> : BaseConverter<TSourceObj, TDestinationObj>, IBaseConverter<TSourceObj, TDestinationObj>
        where TSourceObj : class
        where TDestinationObj : class
    {
        public AutoMapConverter()
        {
            AutoMapper.Mapper.CreateMap<TSourceObj, TDestinationObj>();
        }

        public override TDestinationObj ConvertObject(TSourceObj srcObj)
        {
            return AutoMapper.Mapper.Map<TSourceObj, TDestinationObj>(srcObj);
        }
    }
}