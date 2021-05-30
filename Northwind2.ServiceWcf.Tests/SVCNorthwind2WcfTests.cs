namespace Northwind2.ServiceTestWcf.Tests
{
    using log4net;
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;

    public class SVCNorthwind2WcfTests
    {
        // Private Member Variables
        private const string THIS_CLASS = "SVCNorthwind2WcfTests";

        // Protected Variables
        protected ILog _log = null;

        // Public Constructor
        public SVCNorthwind2WcfTests()
        {
            // Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();
            // Get logger
            _log = LogManager.GetLogger(typeof(SVCNorthwind2WcfTests));
            // Start logging
            _log.Debug(THIS_CLASS + ": ConstruPublic Constructor Call");
        }

        public Northwind2ServiceClient GetServiceClient()
        {
            return new Northwind2ServiceClient();
        }
    }
}
