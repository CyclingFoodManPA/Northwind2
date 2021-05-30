/*****************************************************************************
 *        Class Name: Northwind2.zorViewEngine
 *  Class Decription: Inherits from AddressViewEngine and adds functionality
 *					  for locations of views.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    Notes: Northwind2.zorViewEngine was based on:
 *                    http://weblogs.asp.net/imranbaloch/archive/2011/06/27/view-engine-with-dynamic-view-location.aspx                                     
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Mvc3UI.Infrastructure
{
    using System.Web.Mvc;
    
    public class Northwind2RazorViewEngine : RazorViewEngine
    {
        public Northwind2RazorViewEngine()
            : base()
        {

            ViewLocationFormats = new[] 
            {
                "~/Views/{1}/{0}.cshtml",  
                "~/Views/Shared/{0}.cshtml",         
                "~/Views/Administration/{1}/{0}.cshtml",
                "~/Views/Customers/{1}/{0}.cshtml",
                "~/Views/HumanResources/{1}/{0}.cshtml",
                "~/Views/Products/{1}/{0}.cshtml",
                "~/Views/Sales/{1}/{0}.cshtml",
                "~/Views/Security/{1}/{0}.cshtml"
            };
        }

        protected override IView CreateView(ControllerContext controllerContext, string viewPath, string masterPath)
        {
            var nameSpace = controllerContext.Controller.GetType().Namespace;

            return base.CreateView(controllerContext,
                viewPath.Replace("%1", nameSpace), masterPath.Replace("%1", nameSpace));
        }
    }
}