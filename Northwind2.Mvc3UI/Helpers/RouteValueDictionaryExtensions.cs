/*****************************************************************************
 *        Class Name: RouteValueDictionaryExtensions
 *  Class Decription: Helps with the routing of MVC views
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Mvc3UI.Helpers
{
    using System.Web;
    using System.Web.Routing;

    public static class RouteValueDictionaryExtensions
    {
        public static RouteValueDictionary AddQueryStringParameters(this RouteValueDictionary dict)
        {
            var querystring = HttpContext.Current.Request.QueryString;

            foreach (var key in querystring.AllKeys)
                if (!dict.ContainsKey(key))
                    dict.Add(key, querystring.GetValues(key)[0]);

            return dict;
        }

        public static RouteValueDictionary ExceptFor(this RouteValueDictionary dict, params string[] keysToRemove)
        {
            foreach (var key in keysToRemove)
                if (dict.ContainsKey(key))
                    dict.Remove(key);

            return dict;
        }
    }
}