using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class ApplicationUserToApplicationRoleMap : EntityTypeConfiguration<ApplicationUserToApplicationRole>
    {
        public ApplicationUserToApplicationRoleMap()
        {
            // Primary Key
            this.HasKey(t => t.ApplicationUserToApplicationRoleID);

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
            this.ToTable("ApplicationUserToApplicationRole", "Security");
            this.Property(t => t.ApplicationUserToApplicationRoleID).HasColumnName("ApplicationUserToApplicationRoleID");
            this.Property(t => t.ApplicationRoleID).HasColumnName("ApplicationRoleID");
            this.Property(t => t.ApplicationUserID).HasColumnName("ApplicationUserID");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
            this.Property(t => t.AddedBy).HasColumnName("AddedBy");
            this.Property(t => t.AddedDate).HasColumnName("AddedDate");
            this.Property(t => t.ModifiedBy).HasColumnName("ModifiedBy");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
            this.Property(t => t.Modified).HasColumnName("Modified");

            // Relationships
            this.HasRequired(t => t.ApplicationRole)
                .WithMany(t => t.ApplicationUserToApplicationRoles)
                .HasForeignKey(d => d.ApplicationRoleID);
            this.HasRequired(t => t.ApplicationUser)
                .WithMany(t => t.ApplicationUserToApplicationRoles)
                .HasForeignKey(d => d.ApplicationUserID);

        }
    }
}
