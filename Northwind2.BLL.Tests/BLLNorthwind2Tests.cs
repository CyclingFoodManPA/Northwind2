/*****************************************************************************
 *        Class Name: BLLNorthwind2Tests
 *  Class Decription: Contains base class for all BLL tests 
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Configuration;
using log4net;
//using Northwind2.Repository.Contracts;
//using Northwind2.Repository.Implementation;

namespace Northwind2.BLL.Tests
{
    public class BLLNorthwind2Tests
    {
        // Private Member Variables
        private const string THIS_CLASS = "BLLNorthwind2Tests";

        // Protected Variables
        protected ILog _log = null;
        
        // Public Constructor
        public BLLNorthwind2Tests()
        {
            // Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();
            // Get logger
            _log = LogManager.GetLogger(typeof(BLLNorthwind2Tests));
            // Start logging
            _log.Debug(THIS_CLASS + ": ConstruPublic Constructor Call");
        }
      
        //public string ConnectionStringGet()
        //{
        //    _log.Info(THIS_CLASS + ": ConnectionStringGet");

        //    return ConfigurationManager.ConnectionStrings["Northwind2DataEntities"].ConnectionString;
        //}

        //public IUnitOfWork UnitOfWorkGet()
        //{
        //    _log.Info(THIS_CLASS + ": UnitOfWorkGet");

        //    string connString = ConnectionStringGet();
        //    return new UnitOfWork(connString);
        //}
    }
}
