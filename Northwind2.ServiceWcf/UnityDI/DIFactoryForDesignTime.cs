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
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;

namespace Northwind2.ServiceWcf.UnityDI
{
    public static class DIFactoryForDesigntime
    {
        private static volatile UnityContainer container;
        private static object syncRoot = new Object();

        public static InstanceT GetInstance<InstanceT>()
        {
            if (container == null)
            {
                lock (syncRoot)
                {
                    if (container == null)
                    {
                        container = new UnityContainer();
                        container.LoadConfiguration();
                    }
                }
            }

            InstanceT instance = container.Resolve<InstanceT>();
            return instance;
        }

        public static void CleanUp()
        {
            if (container != null)
                container.Dispose();
        }
    }
}
