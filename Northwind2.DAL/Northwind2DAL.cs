/*****************************************************************************
 *        Class Name: Northwind2DAL
 *  Class Decription: Base class for all DAL and Repository modules
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

namespace Northwind2.DAL
{
    public abstract class Northwind2DAL
    {
        // Private Member Variables
        private const string THIS_CLASS = "Northwind2DAL";

        // Protected Variables
        protected ILog _log = null;
        protected static string _connectionString =
            ConfigurationManager.ConnectionStrings["Northwind2Context"].ConnectionString;

        // Public Constructor
        public Northwind2DAL()
        {
            //Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();

            //Get logger
            _log = LogManager.GetLogger(typeof(Northwind2DAL));

            //Start logging
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
    }
}
