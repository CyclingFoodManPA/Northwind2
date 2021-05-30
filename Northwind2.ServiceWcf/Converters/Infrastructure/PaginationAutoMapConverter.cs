/*****************************************************************************
 *        Class Name: PaginationAutoMapConverter
 *  Class Decription: Contains the converter for pagination
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using AutoMapper;
using Northwind2.Common.Classes;

namespace Northwind2.ServiceWcf.Converters.Infrastructure
{
    public class PaginationAutoMapConverter : AutoMapConverter<DataContracts.Requests.PaginationRequest, Common.Classes.PaginationRequest>
    {
        public PaginationAutoMapConverter()
            : base()
        {
            ConfigureMappings();
        }

        private static void ConfigureMappings()
        {
            Mapper.CreateMap<DataContracts.Requests.Sort, Northwind2.Common.Classes.Sort>();
        }
    }
}