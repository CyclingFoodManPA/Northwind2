using System.Web.Mvc;
using System.Web.Routing;
using Microsoft.Practices.Unity;
using Northwind2.Mvc3UI.Infrastructure;
using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
using Unity.Mvc3;

namespace Northwind2.Mvc3UI
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            //Add additional locations of Views
            ViewEngines.Engines.Add(new Northwind2RazorViewEngine());
            

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);

            //Enable DI for Mvc3 UI using Unity
            var container = new UnityContainer();

            container
                .RegisterType<INorthwind2Service, Northwind2ServiceClient>()
                .Configure<InjectedMembers>()
                .ConfigureInjectionFor<Northwind2ServiceClient>(new InjectionConstructor("*"));

            DependencyResolver.SetResolver(new UnityDependencyResolver(container));

            //Register logging
            log4net.Config.XmlConfigurator.Configure();
        }
    }
}