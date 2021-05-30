/*****************************************************************************
 *        Class Name: MvcSiteMapProvider
 *  Class Decription: Inherits from StaticSiteMapProvider in System.Web and
 *                    adds functionality for site navigation
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
    using System;
    using System.Collections.Generic;
    using System.Collections.Specialized;
    using System.Linq;
    using System.Web;
    using System.Web.Hosting;
    using System.Web.Routing;
    using System.Xml;

    public class MvcSiteMapProvider : StaticSiteMapProvider
    {
        #region Private Member Variables

        // Sitemap attributes which are not considered part of route, you can add your custom attributes here.
        private string[] _ExcludedAttributes = { "title", "description", "roles" };
        private RequestContext _RequestContext;
        private SiteMapNode _RootNode;

        #endregion Private Member Variables

        #region Initializer

        public override void Initialize(string name, NameValueCollection attributes)
        {
            // Set default location for sitemap file
            string siteMapPath = "~/Web.sitemap";

            // If location of sitemp is specified in provider attributes
            if (!string.IsNullOrEmpty(attributes["siteMapFile"]))
            {
                // Set specified sitemap location
                siteMapPath = attributes["siteMapFile"];
            }

            // Load sitemap file
            var xmlDocument = new XmlDocument();
            xmlDocument.Load(HostingEnvironment.MapPath(siteMapPath));

            // Create new requestcontext, needed to resolve url's from route values. Current http context is used, route data is cleared.
            this._RequestContext = new RequestContext(new HttpContextWrapper(HttpContext.Current), new RouteData());

            // Get nodes recursively
            this._RootNode = createSiteMapNode(xmlDocument.DocumentElement["siteMapNode"], null);

            base.Initialize(name, attributes);
        }

        #endregion Initializer

        #region Public Overrideable Methods

        public override SiteMapNode BuildSiteMap()
        {
            // Return rootnode which contains all childnodes
            return this._RootNode;
        }

        public override bool IsAccessibleToUser(System.Web.HttpContext context, System.Web.SiteMapNode node)
        {
            // If node has no roles specified means it is accessible (unless parent is not accessible)
            if (node.Roles == null)
            {
                return true;
            }

            // Iterate roles
            foreach (string role in node.Roles)
            {
                // If user is in role, node is accessible
                if (context.User.IsInRole(role))
                {
                    // Node is accessible
                    return true;
                }
            }

            // Node is not accessible
            return false;

        }

        #endregion Public Methods

        #region Private Methods

        private SiteMapNode createSiteMapNode(XmlNode xmlNode, SiteMapNode parentNode)
        {
            var routeData = new Dictionary<string, object>();

            foreach (XmlAttribute xmlAttribute in xmlNode.Attributes)
            {
                if (!this._ExcludedAttributes.Contains(xmlAttribute.Name))
                {
                    routeData.Add(xmlAttribute.Name, (object)xmlAttribute.Value);
                }
            }

            // Create route dictionary
            var routeDict = new RouteValueDictionary(routeData);

            // Resolve relative url from route values (from xml attributes)
            // Only resolve url when routevalues are specified (avoids creating "/" as url when no route values are specified)
            // Every url in a sitemap must be unique (except when empty), so if mulitple url's were to be set to '/' this would result in an exception
            string url = string.Empty;
            if (routeData.Count > 0)
            {
                url = RouteTable.Routes.GetVirtualPath(this._RequestContext, routeDict).VirtualPath;
            }

            // Create collection of custom sitemap attributes
            NameValueCollection attributes = new NameValueCollection();

            // Store collection of route attribute keys in one custom sitemap attribute
            attributes.Add("RouteKeys", string.Join(",", routeData.Keys.ToArray()));

            // Store each routeValue in custom attribute
            foreach (var routeValue in routeData)
            {
                attributes.Add(routeValue.Key, routeValue.Value.ToString());
            }

            // Store each reserved xml attribute (not considered part of routevalues) in custom attribute
            foreach (string excludedAttribute in this._ExcludedAttributes)
            {
                if (xmlNode.Attributes[excludedAttribute] != null)
                {
                    attributes.Add(excludedAttribute, xmlNode.Attributes[excludedAttribute].Value);
                }
            }

            // Retrieve title, description and roles from xml node
            string title = xmlNode.Attributes["title"] == null ? "" : xmlNode.Attributes["title"].Value;
            string description = xmlNode.Attributes["description"] == null ? "" : xmlNode.Attributes["description"].Value;
            List<string> roles = xmlNode.Attributes["roles"] == null ? null : xmlNode.Attributes["roles"].Value.Replace(" ", "").Split(',').ToList();

            // Create new sitemap node
            SiteMapNode node = new SiteMapNode(this, Guid.NewGuid().ToString(), url, title, description, roles, attributes, null, null);

            // Add sitemapnode
            base.AddNode(node, parentNode);

            // Iterate through children
            foreach (XmlNode childNode in xmlNode.ChildNodes)
            {
                // Add children to sitemap
                createSiteMapNode(childNode, node);
            }

            return node;
        }

        #endregion Private Methods

        protected override SiteMapNode GetRootNodeCore()
        {
            return this._RootNode;
        }
    }
}
