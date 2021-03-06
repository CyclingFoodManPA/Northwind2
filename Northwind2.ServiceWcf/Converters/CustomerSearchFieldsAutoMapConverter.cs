/*****************************************************************************
 *        Class Name: CustomerSearchFieldsAutoMapConverter
 *  Class Decription: Contains the converter for the CustomerSearch fields
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
    public class CustomerSearchFieldsAutoMapConverter : AutoMapConverter<DataContracts.Requests.CustomerSearchFields, CustomerSearchFields>
    {
        public CustomerSearchFieldsAutoMapConverter()
            : base()
        {
            ConfigureMappings();
        }

        private static void ConfigureMappings()
        {
            Mapper.CreateMap<DataContracts.Requests.CustomerSearchFields, 
                CustomerSearchFields>();
        }
    }
}

