using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class EmployeeToTerritoryMap : EntityTypeConfiguration<EmployeeToTerritory>
    {
        public EmployeeToTerritoryMap()
        {
            // Primary Key
            this.HasKey(t => t.EmployeeToTerritoryID);

            // Properties
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
            this.ToTable("EmployeeToTerritory", "HumanResources");
            this.Property(t => t.EmployeeToTerritoryID).HasColumnName("EmployeeToTerritoryID");
            this.Property(t => t.EmployeeID).HasColumnName("EmployeeID");
            this.Property(t => t.TerritoryID).HasColumnName("TerritoryID");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");

            // Relationships
            this.HasRequired(t => t.Employee)
                .WithMany(t => t.EmployeeToTerritories)
                .HasForeignKey(d => d.EmployeeID);
            this.HasRequired(t => t.Territory)
                .WithMany(t => t.EmployeeToTerritories)
                .HasForeignKey(d => d.TerritoryID);

        }
    }
}
