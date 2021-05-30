using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using log4net;
using Northwind2.Entities.Models;
using Northwind2.Entities.Models.Mapping;

namespace Northwind2.Context
{
    public partial class Northwind2Context : DbContext
    {
        private const string THIS_CLASS = "Northwind2Context";
        protected ILog _log;

        static Northwind2Context()
        {
            Database.SetInitializer<Northwind2Context>(null);
        }

        public Northwind2Context()
            : base("Name=Northwind2Context")
        {
            //Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();

            //Get logger
            _log = LogManager.GetLogger(typeof(Northwind2Context));

            //Start logging
            _log.Info(THIS_CLASS + ": Northwind2Context Public Constructor Call");

            // http://www.codeproject.com/Tips/326059/The-underlying-connection-was-closed-The-connectio
            // http://ardalis.com/Working-with-Lazy-Loading-in-Entity-Framework-Code-First
            this.Configuration.LazyLoadingEnabled = false;
            this.Configuration.ProxyCreationEnabled = false;
        }

        public Northwind2Context(string connectionString)
            : base(connectionString)
        {
            //Load log4net Configuration
            log4net.Config.XmlConfigurator.Configure();

            //Get logger
            _log = LogManager.GetLogger(typeof(Northwind2Context));

            //Start logging
            _log.Info(THIS_CLASS + ": Northwind2Context Public Constructor(" + connectionString.Trim() + "... Call");

            // http://www.codeproject.com/Tips/326059/The-underlying-connection-was-closed-The-connectio
            // http://ardalis.com/Working-with-Lazy-Loading-in-Entity-Framework-Code-First
            this.Configuration.LazyLoadingEnabled = false;
            this.Configuration.ProxyCreationEnabled = false;
        }

        // ObjectContext
        public ObjectContext ObjectContext()
        {
            _log.Info(THIS_CLASS + ": ObjectContext");
            return (this as IObjectContextAdapter).ObjectContext;
        }

        public DbSet<ContactTitle> ContactTitles { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<Holiday> Holidays { get; set; }
        public DbSet<HolidayDescription> HolidayDescriptions { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<BuildVersion> BuildVersions { get; set; }
        public DbSet<ErrorLog> ErrorLogs { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<EmployeeToTerritory> EmployeeToTerritories { get; set; }
        public DbSet<Region> Regions { get; set; }
        public DbSet<Territory> Territories { get; set; }
        public DbSet<Title> Titles { get; set; }
        public DbSet<TitleOfCourtesy> TitleOfCourtesies { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }
        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<InvoiceItem> InvoiceItems { get; set; }
        public DbSet<Shipper> Shippers { get; set; }
        public DbSet<ApplicationRole> ApplicationRoles { get; set; }
        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
        public DbSet<ApplicationUserToApplicationRole> ApplicationUserToApplicationRoles { get; set; }
        public DbSet<vw_InvoiceSubtotals> vw_InvoiceSubtotals { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new ContactTitleMap());
            modelBuilder.Configurations.Add(new CountryMap());
            modelBuilder.Configurations.Add(new HolidayMap());
            modelBuilder.Configurations.Add(new HolidayDescriptionMap());
            modelBuilder.Configurations.Add(new CustomerMap());
            modelBuilder.Configurations.Add(new BuildVersionMap());
            modelBuilder.Configurations.Add(new ErrorLogMap());
            modelBuilder.Configurations.Add(new EmployeeMap());
            modelBuilder.Configurations.Add(new EmployeeToTerritoryMap());
            modelBuilder.Configurations.Add(new RegionMap());
            modelBuilder.Configurations.Add(new TerritoryMap());
            modelBuilder.Configurations.Add(new TitleMap());
            modelBuilder.Configurations.Add(new TitleOfCourtesyMap());
            modelBuilder.Configurations.Add(new CategoryMap());
            modelBuilder.Configurations.Add(new ProductMap());
            modelBuilder.Configurations.Add(new SupplierMap());
            modelBuilder.Configurations.Add(new InvoiceMap());
            modelBuilder.Configurations.Add(new InvoiceItemMap());
            modelBuilder.Configurations.Add(new ShipperMap());
            modelBuilder.Configurations.Add(new ApplicationRoleMap());
            modelBuilder.Configurations.Add(new ApplicationUserMap());
            modelBuilder.Configurations.Add(new ApplicationUserToApplicationRoleMap());
            modelBuilder.Configurations.Add(new vw_InvoiceSubtotalsMap());
        }
    }
}
