using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace Northwind2.Entities.Models.Mapping
{
    public class BuildVersionMap : EntityTypeConfiguration<BuildVersion>
    {
        public BuildVersionMap()
        {
            // Primary Key
            this.HasKey(t => t.BuildVersionID);

            // Properties
            this.Property(t => t.DatabaseVersion)
                .IsRequired()
                .HasMaxLength(25);

            // Table & Column Mappings
            this.ToTable("BuildVersion");
            this.Property(t => t.BuildVersionID).HasColumnName("BuildVersionID");
            this.Property(t => t.DatabaseVersion).HasColumnName("DatabaseVersion");
            this.Property(t => t.VersionDate).HasColumnName("VersionDate");
            this.Property(t => t.ModifiedDate).HasColumnName("ModifiedDate");
        }
    }
}
