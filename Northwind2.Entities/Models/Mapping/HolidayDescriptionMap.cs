using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class HolidayDescriptionMap : EntityTypeConfiguration<HolidayDescription>
    {
        public HolidayDescriptionMap()
        {
            // Primary Key
            this.HasKey(t => t.HolidayDescriptionID);

            // Properties
            this.Property(t => t.HolidayDescriptionName)
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
            this.ToTable("HolidayDescription", "Administration");
            this.Property(t => t.HolidayDescriptionID).HasColumnName("HolidayDescriptionID");
            this.Property(t => t.HolidayDescriptionName).HasColumnName("HolidayDescriptionName");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");
        }
    }
}
