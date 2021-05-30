using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class SupplierMap : EntityTypeConfiguration<Supplier>
    {
        public SupplierMap()
        {
            // Primary Key
            this.HasKey(t => t.SupplierID);

            // Properties
            this.Property(t => t.SupplierName)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.ContactName)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.Address1)
                .IsRequired()
                .HasMaxLength(60);

            this.Property(t => t.Address2)
                .HasMaxLength(60);

            this.Property(t => t.City)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.Region)
                .HasMaxLength(15);

            this.Property(t => t.PostalCode)
                .HasMaxLength(10);

            this.Property(t => t.Phone)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.Fax)
                .HasMaxLength(40);

            this.Property(t => t.HomePage)
                .HasMaxLength(255);

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
            this.ToTable("Supplier", "Products");
            this.Property(t => t.SupplierID).HasColumnName("SupplierID");
            this.Property(t => t.SupplierName).HasColumnName("SupplierName");
            this.Property(t => t.ContactName).HasColumnName("ContactName");
            this.Property(t => t.ContactTitleID).HasColumnName("ContactTitleID");
            this.Property(t => t.Address1).HasColumnName("Address1");
            this.Property(t => t.Address2).HasColumnName("Address2");
            this.Property(t => t.City).HasColumnName("City");
            this.Property(t => t.Region).HasColumnName("Region");
            this.Property(t => t.PostalCode).HasColumnName("PostalCode");
            this.Property(t => t.CountryID).HasColumnName("CountryID");
            this.Property(t => t.Phone).HasColumnName("Phone");
            this.Property(t => t.Fax).HasColumnName("Fax");
            this.Property(t => t.HomePage).HasColumnName("HomePage");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");

            // Relationships
            this.HasRequired(t => t.ContactTitle)
                .WithMany(t => t.Suppliers)
                .HasForeignKey(d => d.ContactTitleID);
            this.HasRequired(t => t.Country)
                .WithMany(t => t.Suppliers)
                .HasForeignKey(d => d.CountryID);

        }
    }
}
