/*****************************************************************************
 *        Class Name: SiteMapMenuHelper
 *  Class Decription: Constructs the menu for application navigation and helps
 *                    with routing.
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    Notes: MvcSiteMapProvider was based on:
 *                    http://www.webpirates.nl/webpirates/robin-van-der-knaap/29-aspnet-mvc-site-map
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
namespace Northwind2.Mvc3UI.HtmlHelpers
{
    using System.Web;
    using System.Web.Mvc;

    public static class SiteMapMenuHelper
    {
        #region Public Constructors

        public static string SiteMapMenu(this HtmlHelper helper, string id, bool showNestedItems)
        {
            return createMenu(id, SiteMap.RootNode, showNestedItems, helper.ViewContext);
        }

        public static string SiteMapMenu(this HtmlHelper helper, string id, SiteMapNode siteMapNode, bool showNestedItems)
        {
            return createMenu(id, siteMapNode, showNestedItems, helper.ViewContext);
        }

        #endregion Public Constructors

        #region Private Methods

        private static string createMenu(string id, SiteMapNode siteMapNode, bool isRecursive, ViewContext viewContext)
        {
            // Only render when node has childnodes
            if (!siteMapNode.HasChildNodes)
            {
                return string.Empty;
            }

            // Create ul element
            var ul = new TagBuilder("ul");

            // Set id if specified
            if (!string.IsNullOrEmpty(id))
            {
                ul.Attributes.Add("id", id);
            }

            // Iterate through childnodes
            foreach (SiteMapNode childNode in siteMapNode.ChildNodes)
            {
                // Create listitem element
                var li = new TagBuilder("li");

                // Declare element
                TagBuilder element;

                if (childNode.HasChildNodes)
                {
                    // Create heading
                    element = new TagBuilder("span");
                }
                else
                {
                    // Create hyperlink
                    element = new TagBuilder("a");

                    // Set url
                    element.Attributes.Add("href", childNode.Url);
                }

                // Set text
                element.InnerHtml = childNode.Title;

                // When current sitemapnode is null, try to determine selected node based on matching of routevalues
                if (SiteMap.CurrentNode == null)
                {
                    bool Selected = true;

                    // Iterate route keys which are stored in custom attribute seperated by ','
                    foreach (string RouteKey in childNode["RouteKeys"].Split(','))
                    {
                        if (!string.IsNullOrEmpty(RouteKey))
                        {
                            string current = viewContext.RouteData.Values[RouteKey].ToString(); // Current value
                            string child = childNode[RouteKey]; // Sitemap value

                            if (viewContext.RouteData.Values[RouteKey].ToString().ToLower() != childNode[RouteKey].ToLower())
                            {
                                Selected = false;
                            }
                        }
                        else
                        {
                            Selected = false;
                        }
                    }
                    if (Selected)
                    {
                        element.AddCssClass("selected");
                    }
                }
                else
                {
                    // Set 'selected' class on hyperlink if element equals current node
                    if (childNode.Equals(SiteMap.CurrentNode))
                    {

                        element.AddCssClass("selected");
                    }
                }

                // Add element to listitem
                li.InnerHtml = element.ToString();

                // Determine if nested items are to be displayed
                if (isRecursive)
                {
                    // Call function again for childnodes
                    li.InnerHtml += createMenu(string.Empty, childNode, true, viewContext);
                }

                // Add listitem to unordered list
                ul.InnerHtml += li.ToString();
            }

            // Return unordered list
            return ul.ToString();
        }

        #endregion Private Methods
    }
}
