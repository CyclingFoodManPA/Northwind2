namespace Northwind2.ServiceTestWcf.Security
{
    using Northwind2.ServiceWcf.Proxies.Northwind2ServiceReference;
    using NUnit.Framework;

    [TestFixture]
    public class SVCSecurityTests
    {
        private Northwind2ServiceClient GetServiceClient()
        {
            return new Northwind2ServiceClient();
        }

        [Test]
        public void SVCWcf_Security_LoginAuthentication_A_IsValidID()
        {
            //Arrange - get contact title service
            Northwind2ServiceClient proxy = GetServiceClient();

            ////Arrange - set CategoryID to 1
            //QueryByIdRequest inputItem = new QueryByIdRequest { Id = 1 };
        }

    }
}
