using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using Northwind2.Entities.Models.Mapping;

namespace Northwind2.Entities.Models
{
    public partial class Northwind2Context : DbContext
    {
        static Northwind2Context()
        {
            Database.SetInitializer<Northwind2Context>(null);
        }

        public Northwind2Context()
            : base("Name=Northwind2Context")
        {
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
