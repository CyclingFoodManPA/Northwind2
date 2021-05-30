using System;
using Microsoft.Practices.Unity;
using Microsoft.Practices.Unity.Configuration;

namespace Northwind2.BLL.Tests.UnityDI
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
