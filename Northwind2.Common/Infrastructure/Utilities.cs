using System;
using System.Data.SqlClient;

namespace Northwind2.Common.Infrastructure
{
    public static class Utilities
    {
        public static bool SearchFieldNotNullOrEmpty(string searchField)
        {
            bool result = false;

            if ((searchField != null) && (searchField != String.Empty))
                result = true;

            return result;
        }
    }
}
