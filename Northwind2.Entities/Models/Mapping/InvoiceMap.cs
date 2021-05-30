using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class InvoiceMap : EntityTypeConfiguration<Invoice>
    {
        public InvoiceMap()
        {
            // Primary Key
            this.HasKey(t => t.InvoiceID);

            // Properties
            this.Property(t => t.ShipName)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.ShipAddress1)
                .IsRequired()
                .HasMaxLength(60);

            this.Property(t => t.ShipAddress2)
                .HasMaxLength(60);

            this.Property(t => t.ShipCity)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.ShipRegion)
                .HasMaxLength(15);

            this.Property(t => t.ShipPostalCode)
                .IsRequired()
                .HasMaxLength(10);

            this.Property(t => t.AddedBy)
                .IsRequired()
                .HasMaxLength(100);

            this.Property(t => t.ModifiedBy)
                .IsRequired()
                .HasMaxLength(100);

            this.Property(t => t.Modified)
                .IsRequired()
                .IsFixedLength()
                .HasMaxLength(8)
                .IsRowVersion();

            // Table & Column Mappings
            this.ToTable("Invoice", "Sales");
            this.Property(t => t.InvoiceID).HasColumnName("InvoiceID");
            this.Property(t => t.CustomerID).HasColumnName("CustomerID");
            this.Property(t => t.EmployeeID).HasColumnName("EmployeeID");
            this.Property(t => t.InvoiceDate).HasColumnName("InvoiceDate");
            this.Property(t => t.RequiredDate).HasColumnName("RequiredDate");
            this.Property(t => t.ShippedDate).HasColumnName("ShippedDate");
            this.Property(t => t.ShipperID).HasColumnName("ShipperID");
            this.Property(t => t.Freight).HasColumnName("Freight");
            this.Property(t => t.ShipName).HasColumnName("ShipName");
            this.Property(t => t.ShipAddress1).HasColumnName("ShipAddress1");
            this.Property(t => t.ShipAddress2).HasColumnName("ShipAddress2");
            this.Property(t => t.ShipCity).HasColumnName("ShipCity");
            this.Property(t => t.ShipRegion).HasColumnName("ShipRegion");
            this.Property(t => t.ShipPostalCode).HasColumnName("ShipPostalCode");
            this.Property(t => t.CountryID).HasColumnName("CountryID");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");

            // Relationships
            this.HasRequired(t => t.Country)
                .WithMany(t => t.Invoices)
                .HasForeignKey(d => d.CountryID);
            this.HasRequired(t => t.Customer)
                .WithMany(t => t.Invoices)
                .HasForeignKey(d => d.CustomerID);
            this.HasRequired(t => t.Employee)
                .WithMany(t => t.Invoices)
                .HasForeignKey(d => d.EmployeeID);
            this.HasRequired(t => t.Shipper)
                .WithMany(t => t.Invoices)
                .HasForeignKey(d => d.ShipperID);

        }
    }
}
