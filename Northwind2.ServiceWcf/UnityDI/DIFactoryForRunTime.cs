/*****************************************************************************
 *        Class Name: DIFactoryForDesignTime
 *  Class Decription: Contains the 
 *                    
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 * 
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System;
using System.Configuration;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;

namespace Northwind2.ServiceWcf.UnityDI
{
    public class DIFactoryForRuntime
    {
        private static volatile UnityContainer container;
        private static object syncRoot = new Object();

        public static UnityContainer Container
        {
            get
            {
                if (container == null)
                {
                    lock (syncRoot)
                    {
                        if (container == null)
                            container = new UnityContainer();
                    }
                }
                return container;
            }
        }

        static DIFactoryForRuntime()
        {
            var section = (UnityConfigurationSection)ConfigurationManager.GetSection("unity");
            if (section != null)
            {
                section.Configure(Container);
            }
        }

        public static T Resolve<T>()
        {
            T ret = default(T);

            if (Container.IsRegistered(typeof(T)))
            {
                ret = Container.Resolve<T>();
            }
            return ret;
        }

        public static T Resolve<T>(string keyName)
        {
            T ret = default(T);

            if (Container.IsRegistered(typeof(T), keyName))
            {
                ret = Container.Resolve<T>(keyName);
            }
            return ret;
        }

        public static void CleanUp()
        {
            if (Container != null)
                Container.Dispose();
        }
    }
}
