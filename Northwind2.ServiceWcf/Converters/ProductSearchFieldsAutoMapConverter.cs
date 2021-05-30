/*****************************************************************************
 *        Class Name: ProductSearchFieldsAutoMapConverter
 *  Class Decription: Contains the converter for the ProductSearch fields
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
using Northwind2.ServiceWcf.Converters.Infrastructure;

namespace Northwind2.ServiceWcf.Converters
{
    public class ProductSearchFieldsAutoMapConverter : AutoMapConverter<DataContracts.Requests.ProductSearchFields, ProductSearchFields>
    {
        public ProductSearchFieldsAutoMapConverter()
            : base()
        {
            ConfigureMappings();
        }

        private static void ConfigureMappings()
        {
            Mapper.CreateMap<DataContracts.Requests.ProductSearchFields,
                ProductSearchFields>();
        }
    }
}

