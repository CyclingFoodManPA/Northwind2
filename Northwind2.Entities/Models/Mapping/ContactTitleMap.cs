using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class ContactTitleMap : EntityTypeConfiguration<ContactTitle>
    {
        public ContactTitleMap()
        {
            // Primary Key
            this.HasKey(t => t.ContactTitleID);

            // Properties
            this.Property(t => t.ContactTitleName)
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
            this.ToTable("ContactTitle", "Administration");
            this.Property(t => t.ContactTitleID).HasColumnName("ContactTitleID");
            this.Property(t => t.ContactTitleName).HasColumnName("ContactTitleName");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");
        }
    }
}
