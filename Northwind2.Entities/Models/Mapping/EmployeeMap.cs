using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class EmployeeMap : EntityTypeConfiguration<Employee>
    {
        public EmployeeMap()
        {
            // Primary Key
            this.HasKey(t => t.EmployeeID);

            // Properties
            this.Property(t => t.LastName)
                .IsRequired()
                .HasMaxLength(20);

            this.Property(t => t.FirstName)
                .IsRequired()
                .HasMaxLength(20);

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

            this.Property(t => t.HomePhone)
                .IsRequired()
                .HasMaxLength(40);

            this.Property(t => t.Extension)
                .IsRequired()
                .HasMaxLength(4);

            this.Property(t => t.PicturePath)
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
            this.ToTable("Employee", "HumanResources");
            this.Property(t => t.EmployeeID).HasColumnName("EmployeeID");
            this.Property(t => t.LastName).HasColumnName("LastName");
            this.Property(t => t.FirstName).HasColumnName("FirstName");
            this.Property(t => t.TitleID).HasColumnName("TitleID");
            this.Property(t => t.TitleOfCourtesyID).HasColumnName("TitleOfCourtesyID");
            this.Property(t => t.BirthDate).HasColumnName("BirthDate");
            this.Property(t => t.HireDate).HasColumnName("HireDate");
            this.Property(t => t.Address1).HasColumnName("Address1");
            this.Property(t => t.Address2).HasColumnName("Address2");
            this.Property(t => t.City).HasColumnName("City");
            this.Property(t => t.Region).HasColumnName("Region");
            this.Property(t => t.PostalCode).HasColumnName("PostalCode");
            this.Property(t => t.CountryID).HasColumnName("CountryID");
            this.Property(t => t.HomePhone).HasColumnName("HomePhone");
            this.Property(t => t.Extension).HasColumnName("Extension");
            this.Property(t => t.Picture).HasColumnName("Picture");
            this.Property(t => t.Notes).HasColumnName("Notes");
            this.Property(t => t.ReportsToID).HasColumnName("ReportsToID");
            this.Property(t => t.PicturePath).HasColumnName("PicturePath");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");

            // Relationships
            this.HasRequired(t => t.Country)
                .WithMany(t => t.Employees)
                .HasForeignKey(d => d.CountryID);
            this.HasRequired(t => t.Title)
                .WithMany(t => t.Employees)
                .HasForeignKey(d => d.TitleID);
            this.HasRequired(t => t.TitleOfCourtesy)
                .WithMany(t => t.Employees)
                .HasForeignKey(d => d.TitleOfCourtesyID);

        }
    }
}
