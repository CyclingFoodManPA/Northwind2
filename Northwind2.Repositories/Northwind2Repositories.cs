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

namespace Northwind2.Repositories
{
    public abstract class Northwind2Repositories
    {
        #region Private Member Variables

        private const string THIS_CLASS = "Northwind2Repository";

        #endregion Private Member Variables
        
        #region Protected Member Variables

        protected ILog _log = null;
        protected static string _connectionString =
            ConfigurationManager.ConnectionStrings["Northwind2Context"].ConnectionString;

        #endregion Protected Member Variables

        #region Public Constructor

        public Northwind2Repositories()
        {
            //Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();

            //Get logger
            _log = LogManager.GetLogger(typeof(Northwind2Repositories));

            //Start logging
            _log.Info(THIS_CLASS + ": ConstruPublic Constructor Call");

        }

        #endregion Public Constructor
    }
}
