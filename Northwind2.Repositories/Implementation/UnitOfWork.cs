/*****************************************************************************
 *        Class Name: Northwind2UnitOfWork
 *  Class Decription: Contains the UnitOfWork class
 *              Date: Friday, July 1, 2016
 *            Author: ksafford
 *                    
 *  Modification History
 *  Who    When    What
 *  --- ---------- -----------------------------------------------------------
 * 
 *****************************************************************************/
using System.Configuration;
using Northwind2.Context;
using Northwind2.Repositories.Contracts;

namespace Northwind2.Repositories.Implementation
{
    public class UnitOfWork : IUnitOfWork
    {
        private Northwind2Context context;

        public UnitOfWork(string connectionString)
        {
            // Needed if config file is in the separate assembly.
            var type = typeof(System.Data.Entity.SqlServer.SqlProviderServices);

            // Used for design time DI configuration
            if (connectionString == "{connectionString}")
            {
                connectionString = ConfigurationManager.ConnectionStrings["Northwind2Context"].ConnectionString;
            }
            this.context = new Northwind2Context(connectionString);
        }

        public Northwind2Context Context
        {
            get
            {
                return this.context;
            }
            set
            {
                this.context = value;
            }
        }

        public void Commit()
        {
            this.Context.SaveChanges();
        }

        public bool LazyLoadingEnabled
        {
            get { return this.Context.Configuration.LazyLoadingEnabled; }
            set { this.Context.Configuration.LazyLoadingEnabled = value; }
        }

        public void Dispose()
        {
            this.Context.Dispose();
        }
    }
}
