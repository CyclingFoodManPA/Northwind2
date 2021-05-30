using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class TitleOfCourtesyMap : EntityTypeConfiguration<TitleOfCourtesy>
    {
        public TitleOfCourtesyMap()
        {
            // Primary Key
            this.HasKey(t => t.TitleOfCourtesyID);

            // Properties
            this.Property(t => t.TitleOfCourtesyName)
                .IsRequired()
                .HasMaxLength(40);

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
            this.ToTable("TitleOfCourtesy", "HumanResources");
            this.Property(t => t.TitleOfCourtesyID).HasColumnName("TitleOfCourtesyID");
            this.Property(t => t.TitleOfCourtesyName).HasColumnName("TitleOfCourtesyName");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");
        }
    }
}
