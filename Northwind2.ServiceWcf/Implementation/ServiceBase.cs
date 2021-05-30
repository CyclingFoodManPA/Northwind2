/*****************************************************************************
 *        Class Name: ServiceBase
 *  Class Decription: Contains base service for all services
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using log4net;

namespace Northwind2.ServiceWcf
{
    public abstract class ServiceBase
    {
        // Protected Variables
        protected ILog _log = null;

        public ServiceBase()
        {
            //Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();
            //Get logger
            _log = LogManager.GetLogger(typeof(ServiceBase));
            //Start logging
            _log.Debug("ServiceBase ConstruPublic Constructor Call");
        }
    }
}