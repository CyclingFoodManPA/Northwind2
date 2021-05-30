using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class CustomerMap : EntityTypeConfiguration<Customer>
    {
        public CustomerMap()
        {
            // Primary Key
            this.HasKey(t => t.CustomerID);

            // Properties
            this.Property(t => t.CustomerName)
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

            this.Property(t => t.Email)
                .HasMaxLength(100);

            this.Property(t => t.CustomerIDOld)
                .IsRequired()
                .IsFixedLength()
                .HasMaxLength(5);

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
            this.ToTable("Customer", "Customers");
            this.Property(t => t.CustomerID).HasColumnName("CustomerID");
            this.Property(t => t.CustomerName).HasColumnName("CustomerName");
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
            this.Property(t => t.Email).HasColumnName("Email");
            this.Property(t => t.CustomerIDOld).HasColumnName("CustomerIDOld");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");

            // Relationships
            this.HasRequired(t => t.ContactTitle)
                .WithMany(t => t.Customers)
                .HasForeignKey(d => d.ContactTitleID);
            this.HasRequired(t => t.Country)
                .WithMany(t => t.Customers)
                .HasForeignKey(d => d.CountryID);

        }
    }
}
