/*****************************************************************************
 *        Class Name: Northwind2BLL
 *  Class Decription: Base class for all BLL modules
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.BLL
{
    using log4net;

    public abstract class Northwind2BLL
    {
        private const string THIS_CLASS = "Northwind2BLL";    
        protected ILog _log = null;

        public Northwind2BLL()
        {
            _log = LogManager.GetLogger(typeof(Northwind2BLL));
            _log.Info(THIS_CLASS + ": Public Constructor");
        }
    }
}
