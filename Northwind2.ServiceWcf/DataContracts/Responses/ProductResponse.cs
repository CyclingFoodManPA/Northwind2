/*****************************************************************************
 *        Class Name: ProductsResponse
 *  Class Decription: Contains response functionality for ProductService
 *              Date: Tuesday, July 5, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Collections.Generic;
using System.Runtime.Serialization;
using Northwind2.Common.Constants;
using Northwind2.ServiceWcf.SDO;

namespace Northwind2.ServiceWcf.DataContracts.Responses
{
    [DataContract(Name = "ProductResponse", Namespace = Constants.NAMESPACE)]
    public class ProductResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public ProductSDO Product { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public string ErrorMessage { get; set; }
    }
    [DataContract(Name = "ProductResponse", Namespace = Constants.NAMESPACE)]
    public class ProductCMResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public ProductSDO Product { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [DataContract(Name = "ProductListResponse", Namespace = Constants.NAMESPACE)]
    public class ProductListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public Products Products { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "Products", ItemName = "Product")]
    public class Products : List<ProductSDO> { }

    [CollectionDataContract(Namespace = Constants.NAMESPACE, Name = "ProductSelectList", ItemName = "ListItem")]
    public class ProductSelectList : List<ListItemSDO> { }

    [DataContract(Name = "ProductSelectListResponse", Namespace = Constants.NAMESPACE)]
    public class ProductSelectListResponse
    {
        [DataMember(IsRequired = false, Order = 0)]
        public ProductSelectList ProductSelectList { get; set; }

        [DataMember(IsRequired = false, Order = 1)]
        public int TotalCount { get; set; }

        [DataMember(IsRequired = false, Order = 2)]
        public string ErrorMessage { get; set; }
    }
}
