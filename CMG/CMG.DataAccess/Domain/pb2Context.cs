using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace CMG.DataAccess.Domain
{
    public partial class pb2Context : DbContext
    {
        public pb2Context()
        {
        }

        public pb2Context(DbContextOptions<pb2Context> options)
            : base(options)
        {
        }

        public virtual DbSet<AccTable> AccTable { get; set; }
        public virtual DbSet<Agent> Agent { get; set; }
        public virtual DbSet<AgentCommission> AgentCommission { get; set; }
        public virtual DbSet<Business> Business { get; set; }
        public virtual DbSet<BusinessPolicys> BusinessPolicys { get; set; }
        public virtual DbSet<Calls> Calls { get; set; }
        public virtual DbSet<Cases> Cases { get; set; }
        public virtual DbSet<Comm> Comm { get; set; }
        public virtual DbSet<Grp> Grp { get; set; }
        public virtual DbSet<Grpitem> Grpitem { get; set; }
        public virtual DbSet<PeoCall> PeoCall { get; set; }
        public virtual DbSet<PeoPol> PeoPol { get; set; }
        public virtual DbSet<People> People { get; set; }
        public virtual DbSet<PeoplePolicys> PeoplePolicys { get; set; }
        public virtual DbSet<PolChg> PolChg { get; set; }
        public virtual DbSet<PolIll> PolIll { get; set; }
        public virtual DbSet<PolicyAgent> PolicyAgent { get; set; }
        public virtual DbSet<Policys> Policys { get; set; }
        public virtual DbSet<RelBp> RelBp { get; set; }
        public virtual DbSet<RelPp> RelPp { get; set; }
        public virtual DbSet<Todo> Todo { get; set; }
        public virtual DbSet<Withd> Withd { get; set; }

        // Unable to generate entity type for table 'dbo.KEY_TABLE'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.TEMPLATES1'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.COMM_BACKUP'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.POL_ILL2'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.POL_ILL_BACKUP'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.COMBO'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.ERRLOG'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.SF_Map'. Please see the warning messages.
        // Unable to generate entity type for table 'dbo.POLICYS_BACKUP'. Please see the warning messages.

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=SERVER06;Database=pb2;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("ProductVersion", "2.2.6-servicing-10079");

            modelBuilder.Entity<AccTable>(entity =>
            {
                entity.HasKey(e => e.UserName)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("ACC_TABLE");

                entity.HasIndex(e => e.IdUser)
                    .HasName("IDX_ACC_TABLE_ID_USER");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_ACC_TABLE_KEYNUMP");

                entity.Property(e => e.UserName)
                    .HasColumnName("USER_NAME")
                    .HasMaxLength(16)
                    .IsUnicode(false)
                    .ValueGeneratedNever();

                entity.Property(e => e.Bcc)
                    .IsRequired()
                    .HasColumnName("BCC")
                    .HasMaxLength(80)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.IdAcct)
                    .IsRequired()
                    .HasColumnName("ID_ACCT")
                    .HasMaxLength(18)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.IdUser)
                    .IsRequired()
                    .HasColumnName("ID_USER")
                    .HasMaxLength(18)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.OrgGrp)
                    .HasColumnName("ORG_GRP")
                    .HasColumnType("numeric(2, 0)");
            });

            modelBuilder.Entity<Agent>(entity =>
            {
                entity.Property(e => e.AgentCode)
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.Color)
                    .IsRequired()
                    .HasMaxLength(15)
                    .IsUnicode(false);

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.CreatedDate).HasColumnType("datetime");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.MiddleName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");
            });

            modelBuilder.Entity<AgentCommission>(entity =>
            {
                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.CreatedDate).HasColumnType("datetime");

                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");
                entity.HasOne(d => d.CommissionNavigation)
                    .WithMany(p => p.AgentCommissions)
                    .HasForeignKey(d => d.CommissionId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Commission_AgentCommission");
            });

            modelBuilder.Entity<Business>(entity =>
            {
                entity.HasKey(e => e.Keynumb)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("BUSINESS");

                entity.HasIndex(e => e.Bpostalcod)
                    .HasName("IDX_BUSINESS_BPOSTALCOD");

                entity.HasIndex(e => e.Bstreet)
                    .HasName("IDX_BUSINESS_BSTREET");

                entity.HasIndex(e => e.Busname)
                    .HasName("IDX_BUSINESS_BUSNAME");

                entity.HasIndex(e => e.Clientdir)
                    .HasName("IDX_BUSINESS_CLIENTDIR");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Bus_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.HasIndex(e => e.Sic1)
                    .HasName("IDX_BUSINESS_SIC1");

                entity.HasIndex(e => e.Sic2)
                    .HasName("IDX_BUSINESS_SIC2");

                entity.HasIndex(e => e.Sic3)
                    .HasName("IDX_BUSINESS_SIC3");

                entity.HasIndex(e => e.Sic4)
                    .HasName("IDX_BUSINESS_SIC4");

                entity.Property(e => e.Keynumb)
                    .HasColumnName("KEYNUMB")
                    .ValueGeneratedNever();

                entity.Property(e => e.Annprofit)
                    .HasColumnName("ANNPROFIT")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annprofit2)
                    .HasColumnName("ANNPROFIT2")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annprofit3)
                    .HasColumnName("ANNPROFIT3")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annprofit4)
                    .HasColumnName("ANNPROFIT4")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annprofit5)
                    .HasColumnName("ANNPROFIT5")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annsales)
                    .HasColumnName("ANNSALES")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annsales2)
                    .HasColumnName("ANNSALES2")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annsales3)
                    .HasColumnName("ANNSALES3")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annsales4)
                    .HasColumnName("ANNSALES4")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Annsales5)
                    .HasColumnName("ANNSALES5")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Bcity)
                    .IsRequired()
                    .HasColumnName("BCITY")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Bforeign).HasColumnName("BFOREIGN");

                entity.Property(e => e.Bnotes)
                    .IsRequired()
                    .HasColumnName("BNOTES")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Bookval)
                    .HasColumnName("BOOKVAL")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Bookval2)
                    .HasColumnName("BOOKVAL2")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Bookval3)
                    .HasColumnName("BOOKVAL3")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Bookval4)
                    .HasColumnName("BOOKVAL4")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Bookval5)
                    .HasColumnName("BOOKVAL5")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Bothtype)
                    .IsRequired()
                    .HasColumnName("BOTHTYPE")
                    .HasMaxLength(16)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Bphoneoth)
                    .IsRequired()
                    .HasColumnName("BPHONEOTH")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Bpostalcod)
                    .IsRequired()
                    .HasColumnName("BPOSTALCOD")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Bprov)
                    .IsRequired()
                    .HasColumnName("BPROV")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Bpublic).HasColumnName("BPUBLIC");

                entity.Property(e => e.Bstreet)
                    .IsRequired()
                    .HasColumnName("BSTREET")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Busname)
                    .IsRequired()
                    .HasColumnName("BUSNAME")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Clientdir)
                    .IsRequired()
                    .HasColumnName("CLIENTDIR")
                    .HasMaxLength(33)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dunsno)
                    .IsRequired()
                    .HasColumnName("DUNSNO")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fyear)
                    .HasColumnName("FYEAR")
                    .HasColumnType("numeric(4, 0)");

                entity.Property(e => e.Fyear2)
                    .HasColumnName("FYEAR2")
                    .HasColumnType("numeric(4, 0)");

                entity.Property(e => e.Fyear3)
                    .HasColumnName("FYEAR3")
                    .HasColumnType("numeric(4, 0)");

                entity.Property(e => e.Fyear4)
                    .HasColumnName("FYEAR4")
                    .HasColumnType("numeric(4, 0)");

                entity.Property(e => e.Fyear5)
                    .HasColumnName("FYEAR5")
                    .HasColumnType("numeric(4, 0)");

                entity.Property(e => e.Mapid)
                    .IsRequired()
                    .HasColumnName("MAPID")
                    .HasMaxLength(16)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Marketval)
                    .HasColumnName("MARKETVAL")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Marketval2)
                    .HasColumnName("MARKETVAL2")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Marketval3)
                    .HasColumnName("MARKETVAL3")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Marketval4)
                    .HasColumnName("MARKETVAL4")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Marketval5)
                    .HasColumnName("MARKETVAL5")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.NumEmpl).HasColumnName("NUM_EMPL");

                entity.Property(e => e.NumEmpl2).HasColumnName("NUM_EMPL2");

                entity.Property(e => e.NumEmpl3).HasColumnName("NUM_EMPL3");

                entity.Property(e => e.NumEmpl4).HasColumnName("NUM_EMPL4");

                entity.Property(e => e.NumEmpl5).HasColumnName("NUM_EMPL5");

                entity.Property(e => e.Parname)
                    .IsRequired()
                    .HasColumnName("PARNAME")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Phonebus)
                    .IsRequired()
                    .HasColumnName("PHONEBUS")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Phonefax)
                    .IsRequired()
                    .HasColumnName("PHONEFAX")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.ProdType)
                    .IsRequired()
                    .HasColumnName("PROD_TYPE")
                    .HasMaxLength(24)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Sic1)
                    .IsRequired()
                    .HasColumnName("SIC1")
                    .HasMaxLength(4)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Sic2)
                    .IsRequired()
                    .HasColumnName("SIC2")
                    .HasMaxLength(4)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Sic3)
                    .IsRequired()
                    .HasColumnName("SIC3")
                    .HasMaxLength(4)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Sic4)
                    .IsRequired()
                    .HasColumnName("SIC4")
                    .HasMaxLength(4)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.SummPolc).HasColumnName("SUMM_POLC");

                entity.Property(e => e.Website)
                    .IsRequired()
                    .HasColumnName("WEBSITE")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Yearend)
                    .IsRequired()
                    .HasColumnName("YEAREND")
                    .HasMaxLength(4)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");
            });

            modelBuilder.Entity<BusinessPolicys>(entity =>
            {
                entity.HasKey(e => e.Keynum)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("BUSINESS_POLICYS");

                entity.Property(e => e.Keynum)
                    .HasColumnName("KEYNUM")
                    .ValueGeneratedNever();

                entity.Property(e => e.Bus).HasColumnName("BUS");

                entity.Property(e => e.Catgry)
                    .IsRequired()
                    .HasColumnName("CATGRY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dphonebusc)
                    .HasColumnName("DPHONEBUSC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumb],[bus],'A.DPHONEBUS'))");

                entity.Property(e => e.Dphoneextc)
                    .HasColumnName("DPHONEEXTC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumb],[bus],'B.DPHONEEXT'))");

                entity.Property(e => e.Emailc)
                    .HasColumnName("EMAILC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumb],[bus],'A.EMAIL'))");

                entity.Property(e => e.Hname)
                    .IsRequired()
                    .HasColumnName("HNAME")
                    .HasMaxLength(35)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Hnamec)
                    .HasColumnName("hnamec")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_hname]([keynumb],[bus],[hname],(5)))");

                entity.Property(e => e.Hsplit).HasColumnType("numeric(5, 2)");

                entity.Property(e => e.Islinked)
                    .HasColumnName("islinked")
                    .HasComputedColumnSql("([dbo].[FUNC_linkpol]([keynumb],[bus]))");

                entity.Property(e => e.Keynumb).HasColumnName("KEYNUMB");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Phonebusc)
                    .HasColumnName("PHONEBUSC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumb],[bus],'C.PHONEBUS'))");

                entity.Property(e => e.Relatn)
                    .IsRequired()
                    .HasColumnName("RELATN")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Split)
                    .HasColumnName("split")
                    .HasColumnType("numeric(5, 2)")
                    .HasDefaultValueSql("((0.0))");

                entity.HasOne(d => d.KeynumbNavigation)
                    .WithMany(p => p.BusinessPolicys)
                    .HasForeignKey(d => d.Keynumb)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_BUSINESS_POLICYS_BUSINESS");
            });

            modelBuilder.Entity<Calls>(entity =>
            {
                entity.HasKey(e => e.Keycall)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CALLS");

                entity.HasIndex(e => e.Calldate)
                    .HasName("IDX_CALLS_CALLDATE");

                entity.HasIndex(e => e.Callgrp)
                    .HasName("IDX_CALLS_CALLGRP");

                entity.HasIndex(e => e.Calltype)
                    .HasName("IDX_CALLS_CALLTYPE");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_CALLS_KEYNUMP");

                entity.HasIndex(e => e.Priority)
                    .HasName("IDX_CALLS_PRIORITY");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Calls_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.HasIndex(e => e.Tstatus)
                    .HasName("IDX_CALLS_TSTATUS");

                entity.Property(e => e.Keycall)
                    .HasColumnName("KEYCALL")
                    .ValueGeneratedNever();

                entity.Property(e => e.Calldate)
                    .HasColumnName("CALLDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Calldate2)
                    .HasColumnName("CALLDATE2")
                    .HasColumnType("datetime");

                entity.Property(e => e.Caller)
                    .HasColumnName("CALLER")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Callgrp)
                    .HasColumnName("CALLGRP")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasComputedColumnSql("(CONVERT([char](1),left([calltype],(1)),0))");

                entity.Property(e => e.Callres)
                    .IsRequired()
                    .HasColumnName("CALLRES")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Calltype)
                    .IsRequired()
                    .HasColumnName("CALLTYPE")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Comments)
                    .IsRequired()
                    .HasColumnName("COMMENTS")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Details)
                    .IsRequired()
                    .HasColumnName("DETAILS")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Details2)
                    .IsRequired()
                    .HasColumnName("DETAILS2")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fullname)
                    .HasColumnName("fullname")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_NameK]((6),[keynump]))");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Messageid)
                    .IsRequired()
                    .HasColumnName("MESSAGEID")
                    .HasMaxLength(120)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Priority)
                    .IsRequired()
                    .HasColumnName("PRIORITY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Salutation)
                    .IsRequired()
                    .HasColumnName("SALUTATION")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Subject)
                    .IsRequired()
                    .HasColumnName("SUBJECT")
                    .HasMaxLength(95)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.SummTodo).HasColumnName("SUMM_TODO");

                entity.Property(e => e.To)
                    .IsRequired()
                    .HasColumnName("TO_")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Tstatus)
                    .IsRequired()
                    .HasColumnName("TSTATUS")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Writer)
                    .IsRequired()
                    .HasColumnName("WRITER")
                    .HasMaxLength(12)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");
            });

            modelBuilder.Entity<Cases>(entity =>
            {
                entity.HasKey(e => e.Keycase)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("CASES");

                entity.HasIndex(e => e.CaseStage)
                    .HasName("IDX_CASES_CASE_STAGE");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Cases_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.Property(e => e.Keycase)
                    .HasColumnName("KEYCASE")
                    .ValueGeneratedNever();

                entity.Property(e => e.Agent1)
                    .IsRequired()
                    .HasColumnName("AGENT1")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent2)
                    .IsRequired()
                    .HasColumnName("AGENT2")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent3)
                    .IsRequired()
                    .HasColumnName("AGENT3")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent4)
                    .IsRequired()
                    .HasColumnName("AGENT4")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent5)
                    .IsRequired()
                    .HasColumnName("AGENT5")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Case1).HasColumnName("CASE1");

                entity.Property(e => e.Case1d)
                    .HasColumnName("CASE1D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case2).HasColumnName("CASE2");

                entity.Property(e => e.Case2d)
                    .HasColumnName("CASE2D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case3).HasColumnName("CASE3");

                entity.Property(e => e.Case3d)
                    .HasColumnName("CASE3D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case4).HasColumnName("CASE4");

                entity.Property(e => e.Case4d)
                    .HasColumnName("CASE4D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case5).HasColumnName("CASE5");

                entity.Property(e => e.Case5d)
                    .HasColumnName("CASE5D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case6).HasColumnName("CASE6");

                entity.Property(e => e.Case6d)
                    .HasColumnName("CASE6D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case7).HasColumnName("CASE7");

                entity.Property(e => e.Case7d)
                    .HasColumnName("CASE7D")
                    .HasColumnType("datetime");

                entity.Property(e => e.Case8).HasColumnName("CASE8");

                entity.Property(e => e.Case8d)
                    .HasColumnName("CASE8D")
                    .HasColumnType("datetime");

                entity.Property(e => e.CaseStage)
                    .HasColumnName("CASE_STAGE")
                    .HasColumnType("numeric(1, 0)");

                entity.Property(e => e.Casehilite).HasColumnName("CASEHILITE");

                entity.Property(e => e.Casenew).HasColumnName("CASENEW");

                entity.Property(e => e.Casey1)
                    .IsRequired()
                    .HasColumnName("CASEY1")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey2)
                    .IsRequired()
                    .HasColumnName("CASEY2")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey3)
                    .IsRequired()
                    .HasColumnName("CASEY3")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey4)
                    .IsRequired()
                    .HasColumnName("CASEY4")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey5)
                    .IsRequired()
                    .HasColumnName("CASEY5")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey6)
                    .IsRequired()
                    .HasColumnName("CASEY6")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey7)
                    .IsRequired()
                    .HasColumnName("CASEY7")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casey8)
                    .IsRequired()
                    .HasColumnName("CASEY8")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dictas)
                    .HasColumnName("DICTAS")
                    .HasComputedColumnSql("([dbo].[FUNC_Dicta]([keynump],[CASE_stage],[Case1d],[Case2d],[Case3d],[Case4d],[Case5d],[Case6d],[Case7d],[Case8d]))");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Num)
                    .HasColumnName("num_")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Tdate)
                    .HasColumnName("TDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasColumnName("TITLE")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");
            });

            modelBuilder.Entity<Comm>(entity =>
            {
                entity.HasKey(e => e.Keycomm)
                    .HasName("PK_Commission");

                entity.ToTable("COMM");

                entity.Property(e => e.Keycomm).HasColumnName("KEYCOMM");

                entity.Property(e => e.Comment)
                    .HasColumnName("COMMENT")
                    .IsUnicode(false);

                entity.Property(e => e.Commtype)
                    .IsRequired()
                    .HasColumnName("COMMTYPE")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('F')");

                entity.Property(e => e.Company)
                    .IsRequired()
                    .HasColumnName("COMPANY")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del)
                    .HasColumnName("DEL_")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.Insured)
                    .IsRequired()
                    .HasColumnName("INSURED")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Paydate)
                    .HasColumnName("PAYDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Policynum)
                    .IsRequired()
                    .HasColumnName("POLICYNUM")
                    .HasMaxLength(25)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Premium)
                    .HasColumnName("PREMIUM")
                    .HasColumnType("numeric(8, 0)");

                entity.Property(e => e.Renewals)
                    .IsRequired()
                    .HasColumnName("RENEWALS")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Total)
                    .HasColumnName("TOTAL")
                    .HasColumnType("numeric(10, 2)");

                entity.Property(e => e.Yrmo)
                    .IsRequired()
                    .HasColumnName("YRMO")
                    .HasMaxLength(6)
                    .IsUnicode(false);

                entity.HasOne(d => d.Policy)
                    .WithMany(p => p.Commissions)
                    .HasForeignKey(d => d.Keynumo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Policys_Commission");
            });

            modelBuilder.Entity<Grp>(entity =>
            {
                entity.HasKey(e => e.Keynumg)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("GRP");

                entity.Property(e => e.Keynumg)
                    .HasColumnName("KEYNUMG")
                    .ValueGeneratedNever();

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Fldlist)
                    .IsRequired()
                    .HasColumnName("FLDLIST")
                    .HasMaxLength(2000)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Grpnam)
                    .IsRequired()
                    .HasColumnName("GRPNAM")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Iscreator)
                    .HasColumnName("ISCREATOR")
                    .HasComputedColumnSql("(CONVERT([bit],case when suser_sname()=[cr8_locn] then (1) else (0) end,0))");

                entity.Property(e => e.Public).HasColumnName("PUBLIC_");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");
            });

            modelBuilder.Entity<Grpitem>(entity =>
            {
                entity.HasKey(e => e.Keynumi)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("GRPITEM");

                entity.HasIndex(e => e.Bus)
                    .HasName("IDX_GRPITEM_BUS");

                entity.HasIndex(e => e.Keynumbp)
                    .HasName("IDX_GRPITEM_KEYNUMBP");

                entity.HasIndex(e => e.Keynumg)
                    .HasName("IDX_GRPITEM_KEYNUMG");

                entity.Property(e => e.Keynumi)
                    .HasColumnName("KEYNUMI")
                    .ValueGeneratedNever();

                entity.Property(e => e.Bus).HasColumnName("BUS");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Keynumbp).HasColumnName("KEYNUMBP");

                entity.Property(e => e.Keynumg).HasColumnName("KEYNUMG");
            });

            modelBuilder.Entity<PeoCall>(entity =>
            {
                entity.HasKey(e => e.Keycp)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PEO_CALL");

                entity.HasIndex(e => e.Bus)
                    .HasName("IDX_PEO_CALL_BUS");

                entity.HasIndex(e => e.CallRole)
                    .HasName("IDX_PEO_CALL_CALL_ROLE");

                entity.HasIndex(e => e.Keycall)
                    .HasName("IDX_PEO_CALL_KEYCALL");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_PEO_CALL_KEYNUMP");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_PeoCall_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.Property(e => e.Keycp)
                    .HasColumnName("KEYCP")
                    .ValueGeneratedNever();

                entity.Property(e => e.Bus).HasColumnName("BUS");

                entity.Property(e => e.CallRole)
                    .IsRequired()
                    .HasColumnName("CALL_ROLE")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Keycall).HasColumnName("KEYCALL");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<PeoPol>(entity =>
            {
                entity.HasKey(e => e.Keynuml)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PEO_POL");

                entity.HasIndex(e => e.Catgry)
                    .HasName("IDX_PEO_POL_CATGRY");

                entity.HasIndex(e => e.Keynumbp)
                    .HasName("IDX_PEO_POL_KEYNUMBP");

                entity.HasIndex(e => e.Keynumo)
                    .HasName("IDX_PEO_POL_KEYNUMO");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.Property(e => e.Keynuml)
                    .HasColumnName("KEYNUML")
                    .ValueGeneratedNever();

                entity.Property(e => e.Bus).HasColumnName("BUS");

                entity.Property(e => e.Catgry)
                    .IsRequired()
                    .HasColumnName("CATGRY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dphonebusc)
                    .HasColumnName("DPHONEBUSC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumbp],[bus],'A.DPHONEBUS'))");

                entity.Property(e => e.Dphoneextc)
                    .HasColumnName("DPHONEEXTC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumbp],[bus],'B.DPHONEEXT'))");

                entity.Property(e => e.Emailc)
                    .HasColumnName("EMAILC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumbp],[bus],'A.EMAIL'))");

                entity.Property(e => e.Hname)
                    .IsRequired()
                    .HasColumnName("HNAME")
                    .HasMaxLength(35)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Hnamec)
                    .HasColumnName("hnamec")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_hname]([keynumbp],[bus],[hname],(5)))");

                entity.Property(e => e.Hsplit).HasColumnType("numeric(5, 2)");

                entity.Property(e => e.Islinked)
                    .HasColumnName("islinked")
                    .HasComputedColumnSql("([dbo].[FUNC_linkpol]([keynumbp],[bus]))");

                entity.Property(e => e.Keynumbp).HasColumnName("KEYNUMBP");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Phonebusc)
                    .HasColumnName("PHONEBUSC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([keynumbp],[bus],'C.PHONEBUS'))");

                entity.Property(e => e.Relatn)
                    .IsRequired()
                    .HasColumnName("RELATN")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Split)
                    .HasColumnName("split")
                    .HasColumnType("numeric(5, 2)")
                    .HasDefaultValueSql("((0.0))");
            });

            modelBuilder.Entity<People>(entity =>
            {
                entity.HasKey(e => e.Keynump)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PEOPLE");

                entity.HasIndex(e => e.Clientdir)
                    .HasName("IDX_PEOPLE_CLIENTDIR");

                entity.HasIndex(e => e.Clienttyp)
                    .HasName("IDX_PEOPLE_CLIENTTYP");

                entity.HasIndex(e => e.Commname)
                    .HasName("IDX_PEOPLE_COMMNAME");

                entity.HasIndex(e => e.Firstname)
                    .HasName("IDX_PEOPLE_FIRSTNAME");

                entity.HasIndex(e => e.Fullname)
                    .HasName("IDX_PEOPLE_fullname");

                entity.HasIndex(e => e.Givenname)
                    .HasName("IDX_PEOPLE_GIVENNAME");

                entity.HasIndex(e => e.Lastname)
                    .HasName("IDX_PEOPLE_LASTNAME");

                entity.HasIndex(e => e.Maidname)
                    .HasName("IDX_PEOPLE_MAIDNAME");

                entity.HasIndex(e => e.Midname)
                    .HasName("IDX_PEOPLE_MIDNAME");

                entity.HasIndex(e => e.Pstatus)
                    .HasName("IDX_PEOPLE_PSTATUS");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_People_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.HasIndex(e => e.Salute)
                    .HasName("IDX_PEOPLE_SALUTE");

                entity.HasIndex(e => e.Thirdname)
                    .HasName("IDX_PEOPLE_THIRDNAME");

                entity.Property(e => e.Keynump)
                    .HasColumnName("KEYNUMP")
                    .ValueGeneratedNever();

                entity.Property(e => e.Agent1)
                    .IsRequired()
                    .HasColumnName("AGENT1")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent2)
                    .IsRequired()
                    .HasColumnName("AGENT2")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent3)
                    .IsRequired()
                    .HasColumnName("AGENT3")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent4)
                    .IsRequired()
                    .HasColumnName("AGENT4")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Agent5)
                    .IsRequired()
                    .HasColumnName("AGENT5")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Annprem)
                    .HasColumnName("annprem")
                    .HasColumnType("numeric(12, 2)")
                    .HasComputedColumnSql("([dbo].[FUNC_ann_prem]([keynump],(0),'%'))");

                entity.Property(e => e.Birthdate)
                    .HasColumnName("BIRTHDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Brnote)
                    .IsRequired()
                    .HasColumnName("BRNOTE")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.CaseStage)
                    .HasColumnName("CASE_STAGE")
                    .HasColumnType("numeric(1, 0)");

                entity.Property(e => e.Caseagent1)
                    .IsRequired()
                    .HasColumnName("CASEAGENT1")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Casenew)
                    .HasColumnName("casenew")
                    .HasComputedColumnSql("(case when [clienttyp]='K' OR [clienttyp]='C' then (0) else (1) end)");

                entity.Property(e => e.City)
                    .IsRequired()
                    .HasColumnName("CITY")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Clientdir)
                    .IsRequired()
                    .HasColumnName("CLIENTDIR")
                    .HasMaxLength(33)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Clienttyp)
                    .IsRequired()
                    .HasColumnName("CLIENTTYP")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cnotes)
                    .IsRequired()
                    .HasColumnName("CNOTES")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Commname)
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasComputedColumnSql("(CONVERT([char](20),case when [salute]>' ' then [salute] when [givenname]>(1) then [midname] else [firstname] end))");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.DecDate)
                    .HasColumnName("DEC_DATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dphonebus)
                    .IsRequired()
                    .HasColumnName("DPHONEBUS")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Dphonefax)
                    .IsRequired()
                    .HasColumnName("DPHONEFAX")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasColumnName("EMAIL")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Email2)
                    .IsRequired()
                    .HasColumnName("EMAIL2")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Etype2)
                    .IsRequired()
                    .HasColumnName("ETYPE2")
                    .HasMaxLength(16)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdbl)
                    .IsRequired()
                    .HasColumnName("FCDBL")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdes)
                    .IsRequired()
                    .HasColumnName("FCDES")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdffp)
                    .IsRequired()
                    .HasColumnName("FCDFFP")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdfl)
                    .IsRequired()
                    .HasColumnName("FCDFL")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdfp)
                    .IsRequired()
                    .HasColumnName("FCDFP")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdfrb)
                    .IsRequired()
                    .HasColumnName("FCDFRB")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdsa)
                    .IsRequired()
                    .HasColumnName("FCDSA")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdtr)
                    .IsRequired()
                    .HasColumnName("FCDTR")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdvs)
                    .IsRequired()
                    .HasColumnName("FCDVS")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fcdws)
                    .IsRequired()
                    .HasColumnName("FCDWS")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Firstname)
                    .IsRequired()
                    .HasColumnName("FIRSTNAME")
                    .HasMaxLength(40)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fullname)
                    .HasColumnName("fullname")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[Func_NameC]((6),[Mr_mrs],[Firstname],[Midname],[Salute],[Givenname],[Lastname],'',[pstatus]))");

                entity.Property(e => e.Givenname)
                    .HasColumnName("GIVENNAME")
                    .HasColumnType("numeric(1, 0)");

                entity.Property(e => e.Gnotes)
                    .IsRequired()
                    .HasColumnName("GNOTES")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Haddr).HasColumnName("HADDR");

                entity.Property(e => e.Initials)
                    .HasColumnName("INITIALS")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasComputedColumnSql("(CONVERT([varchar](3),replace((left([firstname],(1))+left([midname],(1)))+left([lastname],(1)),' ',''),0))");

                entity.Property(e => e.Keyasst)
                    .HasColumnName("KEYASST")
                    .HasComputedColumnSql("([dbo].[FUNC_ASSTKEY]([keynump]))");

                entity.Property(e => e.Kolbe)
                    .IsRequired()
                    .HasColumnName("KOLBE")
                    .HasMaxLength(4)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Lastname)
                    .IsRequired()
                    .HasColumnName("LASTNAME")
                    .HasMaxLength(80)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Maidname)
                    .IsRequired()
                    .HasColumnName("MAIDNAME")
                    .HasMaxLength(80)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Market)
                    .IsRequired()
                    .HasColumnName("MARKET")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Midname)
                    .IsRequired()
                    .HasColumnName("MIDNAME")
                    .HasMaxLength(40)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.MrMrs)
                    .IsRequired()
                    .HasColumnName("MR_MRS")
                    .HasMaxLength(8)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Networth)
                    .HasColumnName("NETWORTH")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.Occupation)
                    .IsRequired()
                    .HasColumnName("OCCUPATION")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Othtype)
                    .IsRequired()
                    .HasColumnName("OTHTYPE")
                    .HasMaxLength(16)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Phonecar)
                    .IsRequired()
                    .HasColumnName("PHONECAR")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Phonehom)
                    .IsRequired()
                    .HasColumnName("PHONEHOM")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Phoneoth)
                    .IsRequired()
                    .HasColumnName("PHONEOTH")
                    .HasMaxLength(18)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Picpath)
                    .IsRequired()
                    .HasColumnName("PICPATH")
                    .HasColumnType("text")
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Pin)
                    .IsRequired()
                    .HasColumnName("PIN")
                    .HasMaxLength(8)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Pnotes)
                    .IsRequired()
                    .HasColumnName("PNOTES")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Postalcode)
                    .IsRequired()
                    .HasColumnName("POSTALCODE")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Prov)
                    .IsRequired()
                    .HasColumnName("PROV")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Pstatus)
                    .IsRequired()
                    .HasColumnName("PSTATUS")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Recept)
                    .IsRequired()
                    .HasColumnName("RECEPT")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Religion)
                    .IsRequired()
                    .HasColumnName("RELIGION")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Salute)
                    .IsRequired()
                    .HasColumnName("SALUTE")
                    .HasMaxLength(40)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Score1).HasColumnName("SCORE1");

                entity.Property(e => e.Score10).HasColumnName("SCORE10");

                entity.Property(e => e.Score2).HasColumnName("SCORE2");

                entity.Property(e => e.Score3).HasColumnName("SCORE3");

                entity.Property(e => e.Score4).HasColumnName("SCORE4");

                entity.Property(e => e.Score5).HasColumnName("SCORE5");

                entity.Property(e => e.Score6).HasColumnName("SCORE6");

                entity.Property(e => e.Score7).HasColumnName("SCORE7");

                entity.Property(e => e.Score8).HasColumnName("SCORE8");

                entity.Property(e => e.Score9).HasColumnName("SCORE9");

                entity.Property(e => e.SecExt)
                    .IsRequired()
                    .HasColumnName("SEC_EXT")
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Secretary)
                    .IsRequired()
                    .HasColumnName("SECRETARY")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Sex)
                    .IsRequired()
                    .HasColumnName("SEX")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Sin)
                    .IsRequired()
                    .HasColumnName("SIN")
                    .HasMaxLength(13)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Smoker)
                    .IsRequired()
                    .HasColumnName("SMOKER")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Source)
                    .IsRequired()
                    .HasColumnName("SOURCE")
                    .HasMaxLength(64)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Spouse)
                    .HasColumnName("SPOUSE")
                    .HasMaxLength(80)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_RELSPS]([keynump],(1)))");

                entity.Property(e => e.Srccat)
                    .IsRequired()
                    .HasColumnName("SRCCAT")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Street)
                    .IsRequired()
                    .HasColumnName("STREET")
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.SvcDate)
                    .HasColumnName("svc_date")
                    .HasColumnType("datetime");

                entity.Property(e => e.SvcType)
                    .IsRequired()
                    .HasColumnName("SVC_TYPE")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Tdate)
                    .HasColumnName("TDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Thirdname)
                    .IsRequired()
                    .HasColumnName("THIRDNAME")
                    .HasMaxLength(40)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Weddate)
                    .HasColumnName("WEDDATE")
                    .HasColumnType("datetime");
            });

            modelBuilder.Entity<PeoplePolicys>(entity =>
            {
                entity.HasKey(e => e.Keynuml)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("PEOPLE_POLICYS");

                entity.Property(e => e.Keynuml)
                    .HasColumnName("KEYNUML")
                    .ValueGeneratedNever();

                entity.Property(e => e.Bus).HasColumnName("BUS");

                entity.Property(e => e.Catgry)
                    .IsRequired()
                    .HasColumnName("CATGRY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dphonebusc)
                    .HasColumnName("DPHONEBUSC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'A.DPHONEBUS'))");

                entity.Property(e => e.Dphoneextc)
                    .HasColumnName("DPHONEEXTC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'B.DPHONEEXT'))");

                entity.Property(e => e.Emailc)
                    .HasColumnName("EMAILC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'A.EMAIL'))");

                entity.Property(e => e.Hname)
                    .IsRequired()
                    .HasColumnName("HNAME")
                    .HasMaxLength(35)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Hnamec)
                    .HasColumnName("hnamec")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_hname]([KEYNUMP],[bus],[hname],(5)))");

                entity.Property(e => e.Hsplit).HasColumnType("numeric(5, 2)");

                entity.Property(e => e.Islinked)
                    .HasColumnName("islinked")
                    .HasComputedColumnSql("([dbo].[FUNC_linkpol]([KEYNUMP],[bus]))");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Phonebusc)
                    .HasColumnName("PHONEBUSC")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_Cinfo]([KEYNUMP],[bus],'C.PHONEBUS'))");

                entity.Property(e => e.Relatn)
                    .IsRequired()
                    .HasColumnName("RELATN")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Split)
                    .HasColumnName("split")
                    .HasColumnType("numeric(5, 2)")
                    .HasDefaultValueSql("((0.0))");

                entity.HasOne(d => d.KeynumpNavigation)
                    .WithMany(p => p.PeoplePolicys)
                    .HasForeignKey(d => d.Keynump)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PEOPLE_POLICYS_PEOPLE");
            });

            modelBuilder.Entity<PolChg>(entity =>
            {
                entity.HasKey(e => e.Keychgs)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("POL_CHG");

                entity.HasIndex(e => e.Chgtype)
                    .HasName("IDX_POL_CHG_CHGTYPE");

                entity.HasIndex(e => e.Keynumo)
                    .HasName("IDX_POL_CHG_KEYNUMO");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_POL_CHG_KEYNUMP");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.Property(e => e.Keychgs)
                    .HasColumnName("KEYCHGS")
                    .ValueGeneratedNever();

                entity.Property(e => e.Chgtype)
                    .IsRequired()
                    .HasColumnName("CHGTYPE")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Det)
                    .IsRequired()
                    .HasColumnName("det_")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.EffDate)
                    .HasColumnName("EFF_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Policynum2)
                    .HasColumnName("POLICYNUM2")
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_POLCNUM]([keynumo]))");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Subject)
                    .IsRequired()
                    .HasColumnName("SUBJECT")
                    .HasMaxLength(95)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");
            });

            modelBuilder.Entity<PolIll>(entity =>
            {
                entity.ToTable("POL_ILL");

                entity.HasIndex(e => e.Divscale)
                    .HasName("IDX_POL_ILL_DIVSCALE");

                entity.HasIndex(e => e.Keynumo)
                    .HasName("IDX_POL_ILL_KEYNUMO");

                entity.HasIndex(e => e.Year)
                    .HasName("IDX_POL_ILL_YEAR");

                entity.Property(e => e.Acb)
                    .HasColumnName("ACB")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Acbact)
                    .HasColumnName("ACBACT")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Acbre)
                    .HasColumnName("ACBRE")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Anndep)
                    .HasColumnName("ANNDEP")
                    .HasColumnType("numeric(12, 2)");

                entity.Property(e => e.Anndepact)
                    .HasColumnName("ANNDEPACT")
                    .HasColumnType("numeric(12, 2)");

                entity.Property(e => e.Anndepre)
                    .HasColumnName("ANNDEPRE")
                    .HasColumnType("numeric(12, 2)");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Cv)
                    .HasColumnName("CV")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Cvact)
                    .HasColumnName("CVACT")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Cvre)
                    .HasColumnName("CVRE")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Db)
                    .HasColumnName("DB")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Dbact)
                    .HasColumnName("DBACT")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Dbre)
                    .HasColumnName("DBRE")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Display)
                    .IsRequired()
                    .HasColumnName("DISPLAY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Divscale).HasColumnName("DIVSCALE");

                entity.Property(e => e.Incpay)
                    .HasColumnName("INCPAY")
                    .HasColumnType("numeric(12, 2)");

                entity.Property(e => e.KeyIll).HasColumnName("KEY_ILL");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Lifepay)
                    .HasColumnName("LIFEPAY")
                    .HasColumnType("numeric(12, 2)");

                entity.Property(e => e.Ncpi)
                    .HasColumnName("NCPI")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Ncpiact)
                    .HasColumnName("NCPIACT")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.Ncpire)
                    .HasColumnName("NCPIRE")
                    .HasColumnType("numeric(12, 0)");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Year)
                    .HasColumnName("YEAR")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.Yearcal)
                    .HasColumnName("YEARCAL")
                    .HasComputedColumnSql("([dbo].[FUNC_ICalYr]([keynumo],[year]))");

                entity.HasOne(d => d.KeynumoNavigation)
                    .WithMany(p => p.PolIll)
                    .HasForeignKey(d => d.Keynumo)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Policys_POL_ILL");
            });

            modelBuilder.Entity<PolicyAgent>(entity =>
            {
                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.CreatedDate).HasColumnType("datetime");

                entity.Property(e => e.ModifiedBy)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.ModifiedDate).HasColumnType("datetime");

                entity.HasOne(d => d.Policy)
                    .WithMany(p => p.PolicyAgent)
                    .HasForeignKey(d => d.PolicyId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Policies_PolicyAgent");
            });

            modelBuilder.Entity<Policys>(entity =>
            {
                entity.HasKey(e => e.Keynumo)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("POLICYS");

                entity.HasIndex(e => e.Class)
                    .HasName("IDX_POLICYS_CLASS");

                entity.HasIndex(e => e.Cmsnexport)
                    .HasName("IDX_POLICYS_CMSNEXPORT");

                entity.HasIndex(e => e.Company)
                    .HasName("IDX_POLICYS_COMPANY");

                entity.HasIndex(e => e.Id)
                    .HasName("Unique_Policys_ID")
                    .IsUnique()
                    .HasFilter("([ID] IS NOT NULL)");

                entity.HasIndex(e => e.IssueAge)
                    .HasName("IDX_POLICYS_ISSUE_AGE");

                entity.HasIndex(e => e.Plancode)
                    .HasName("IDX_POLICYS_PLANCODE");

                entity.HasIndex(e => e.Policynum)
                    .HasName("IDX_POLICYS_POLICYNUM");

                entity.HasIndex(e => e.Restricted)
                    .HasName("IDX_POLICYS_RESTRICTED");

                entity.HasIndex(e => e.Status)
                    .HasName("IDX_POLICYS_STATUS");

                entity.HasIndex(e => e.Type)
                    .HasName("IDX_POLICYS_TYPE");

                entity.Property(e => e.Keynumo)
                    .HasColumnName("KEYNUMO")
                    .ValueGeneratedNever();

                entity.Property(e => e.Acc0)
                    .HasColumnName("ACC_0")
                    .HasComputedColumnSql("(CONVERT([bit],(1)&[restricted],0))");

                entity.Property(e => e.Acc1)
                    .HasColumnName("ACC_1")
                    .HasComputedColumnSql("(CONVERT([bit],(2)&[restricted],0))");

                entity.Property(e => e.Acc2)
                    .HasColumnName("ACC_2")
                    .HasComputedColumnSql("(CONVERT([bit],(4)&[restricted],0))");

                entity.Property(e => e.Amount)
                    .HasColumnName("AMOUNT")
                    .HasColumnType("numeric(12, 2)");

                entity.Property(e => e.Annprem)
                    .HasColumnName("annprem")
                    .HasColumnType("numeric(14, 2)")
                    .HasComputedColumnSql("(CONVERT([numeric](14,2),case when [frequency]='N' then (1)/(0.09) else charindex([frequency],'SZQZZZZZZZM')+(1) end*[payment],0))");

                entity.Property(e => e.AorEnd)
                    .HasColumnName("AOR_END")
                    .HasColumnType("datetime");

                entity.Property(e => e.AorStart)
                    .HasColumnName("AOR_START")
                    .HasColumnType("datetime");

                entity.Property(e => e.Benef)
                    .HasColumnName("BENEF")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[f_IOB]([keynumo],(66),(0),[del_]))");

                entity.Property(e => e.Benper)
                    .HasColumnName("BENPER")
                    .HasColumnType("numeric(3, 0)");

                entity.Property(e => e.Callres)
                    .IsRequired()
                    .HasColumnName("CALLRES")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Class)
                    .IsRequired()
                    .HasColumnName("CLASS")
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cmsnexport)
                    .HasColumnName("CMSNEXPORT")
                    .HasColumnType("datetime");

                entity.Property(e => e.Cola)
                    .HasColumnName("COLA")
                    .HasColumnType("numeric(3, 0)");

                entity.Property(e => e.Comment)
                    .IsRequired()
                    .HasColumnName("COMMENT")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Company)
                    .IsRequired()
                    .HasColumnName("COMPANY")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Grp)
                    .HasColumnName("CR8_GRP")
                    .HasColumnType("numeric(1, 0)")
                    .HasDefaultValueSql("([dbo].[GET_GRPLVL]())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.CumDepact)
                    .HasColumnName("CUM_DEPACT")
                    .HasColumnType("numeric(12, 2)")
                    .HasComputedColumnSql("([dbo].[f_POLCUM]([keynumo]))");

                entity.Property(e => e.Currency)
                    .HasColumnName("CURRENCY")
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('CAD')");

                entity.Property(e => e.Dateplaced)
                    .HasColumnName("DATEPLACED")
                    .HasColumnType("datetime");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.DivScale)
                    .IsRequired()
                    .HasColumnName("DIV_SCALE")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Elimper)
                    .HasColumnName("ELIMPER")
                    .HasColumnType("numeric(3, 0)");

                entity.Property(e => e.Filename)
                    .IsRequired()
                    .HasColumnName("FILENAME")
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Fiogib).HasColumnName("FIOGIB");

                entity.Property(e => e.Frequency)
                    .IsRequired()
                    .HasColumnName("FREQUENCY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Id)
                    .HasColumnName("ID")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Insur)
                    .HasColumnName("INSUR")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[f_IOB]([keynumo],(73),(0),[del_]))");

                entity.Property(e => e.IssueAge)
                    .IsRequired()
                    .HasColumnName("ISSUE_AGE")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Issuedate)
                    .HasColumnName("ISSUEDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Moamt).HasColumnName("MOAMT");

                entity.Property(e => e.Noprint).HasColumnName("NOPRINT");

                entity.Property(e => e.NoteCli)
                    .IsRequired()
                    .HasColumnName("NOTE_CLI")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.NoteInt)
                    .IsRequired()
                    .HasColumnName("NOTE_INT")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Oclass)
                    .IsRequired()
                    .HasColumnName("OCLASS")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Owner)
                    .HasColumnName("OWNER")
                    .HasMaxLength(250)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[f_IOB]([keynumo],(79),(0),[del_]))");

                entity.Property(e => e.Ownocc).HasColumnName("OWNOCC");

                entity.Property(e => e.Payment)
                    .HasColumnName("PAYMENT")
                    .HasColumnType("numeric(11, 2)");

                entity.Property(e => e.Plancode)
                    .HasColumnName("PLANCODE")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Policynum)
                    .IsRequired()
                    .HasColumnName("POLICYNUM")
                    .HasMaxLength(15)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.PprNote)
                    .IsRequired()
                    .HasColumnName("PPR_NOTE")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Reprojdate)
                    .HasColumnName("REPROJDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Restricted)
                    .HasColumnName("RESTRICTED")
                    .HasDefaultValueSql("([dbo].[GET_RestrictLvl](suser_sname()))");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Risk)
                    .IsRequired()
                    .HasColumnName("RISK")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Rpr).HasColumnName("RPR");

                entity.Property(e => e.Status)
                    .IsRequired()
                    .HasColumnName("STATUS")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Status2)
                    .IsRequired()
                    .HasColumnName("STATUS2")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.SubPols)
                    .HasColumnName("SUB_POLS")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.SvcAgt).HasColumnName("SVC_AGT");

                entity.Property(e => e.Type)
                    .IsRequired()
                    .HasColumnName("TYPE")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Updat).HasColumnName("UPDAT");
            });

            modelBuilder.Entity<RelBp>(entity =>
            {
                entity.HasKey(e => e.Keyrelb)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("REL_BP");

                entity.HasIndex(e => e.Keynumb)
                    .HasName("IDX_REL_BP_KEYNUMB");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_REL_BP_KEYNUMP");

                entity.HasIndex(e => e.Primary)
                    .HasName("IDX_REL_BP_PRIMARY_");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Rel_BP_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.Property(e => e.Keyrelb)
                    .HasColumnName("KEYRELB")
                    .ValueGeneratedNever();

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Dphoneext)
                    .IsRequired()
                    .HasColumnName("DPHONEEXT")
                    .HasMaxLength(12)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Keynumb).HasColumnName("KEYNUMB");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Ophoneext)
                    .IsRequired()
                    .HasColumnName("OPHONEEXT")
                    .HasMaxLength(12)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.PcntOwner)
                    .HasColumnName("PCNT_OWNER")
                    .HasColumnType("numeric(5, 2)");

                entity.Property(e => e.Primary).HasColumnName("PRIMARY_");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.TitleOcc)
                    .HasColumnName("TITLE_OCC")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.HasOne(d => d.KeynumbNavigation)
                    .WithMany(p => p.RelBp)
                    .HasForeignKey(d => d.Keynumb)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_REL_BP_BUSINESS");

                entity.HasOne(d => d.KeynumpNavigation)
                    .WithMany(p => p.RelBp)
                    .HasForeignKey(d => d.Keynump)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_REL_BP_PEOPLE");
            });

            modelBuilder.Entity<RelPp>(entity =>
            {
                entity.HasKey(e => e.Keynumr)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("REL_PP");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_REL_PP_KEYNUMP");

                entity.HasIndex(e => e.Keynump2)
                    .HasName("IDX_REL_PP_KEYNUMP2");

                entity.HasIndex(e => e.RelCode)
                    .HasName("IDX_REL_PP_REL_CODE");

                entity.HasIndex(e => e.RelGrp)
                    .HasName("IDX_REL_PP_REL_GRP");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_Rel_PP_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.Property(e => e.Keynumr)
                    .HasColumnName("KEYNUMR")
                    .ValueGeneratedNever();

                entity.Property(e => e.Connectn)
                    .IsRequired()
                    .HasColumnName("CONNECTN")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Details)
                    .IsRequired()
                    .HasColumnName("DETAILS")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Keynump2).HasColumnName("KEYNUMP2");

                entity.Property(e => e.Leader)
                    .IsRequired()
                    .HasColumnName("LEADER")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Magicthred)
                    .IsRequired()
                    .HasColumnName("MAGICTHRED")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Others)
                    .IsRequired()
                    .HasColumnName("OTHERS")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Reason)
                    .IsRequired()
                    .HasColumnName("REASON")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RelCode)
                    .IsRequired()
                    .HasColumnName("REL_CODE")
                    .HasMaxLength(2)
                    .IsUnicode(false);

                entity.Property(e => e.RelGrp)
                    .HasColumnName("REL_GRP")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasComputedColumnSql("(left([REL_CODE],(1)))");

                entity.Property(e => e.Relation)
                    .IsRequired()
                    .HasColumnName("RELATION")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.StatDate)
                    .HasColumnName("STAT_DATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.StatDate2)
                    .HasColumnName("STAT_DATE2")
                    .HasColumnType("datetime");

                entity.Property(e => e.Tmqual)
                    .IsRequired()
                    .HasColumnName("TMQUAL")
                    .HasMaxLength(60)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.HasOne(d => d.KeynumpNavigation)
                    .WithMany(p => p.RelPpKeynumpNavigation)
                    .HasForeignKey(d => d.Keynump)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_REL_PP_PEOPLE");

                entity.HasOne(d => d.Keynump2Navigation)
                    .WithMany(p => p.RelPpKeynump2Navigation)
                    .HasForeignKey(d => d.Keynump2)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            modelBuilder.Entity<Todo>(entity =>
            {
                entity.HasKey(e => e.Keytodo)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("TODO");

                entity.HasIndex(e => e.Compdate)
                    .HasName("IDX_TODO_COMPDATE");

                entity.HasIndex(e => e.Duedate)
                    .HasName("IDX_TODO_DUEDATE");

                entity.HasIndex(e => e.Keynump)
                    .HasName("IDX_TODO_KEYNUMP");

                entity.HasIndex(e => e.SalesforceId)
                    .HasName("Unique_ToDo_Salesforce_Id")
                    .IsUnique()
                    .HasFilter("([Salesforce_Id] IS NOT NULL)");

                entity.HasIndex(e => e.Tasktype)
                    .HasName("IDX_TODO_TASKTYPE");

                entity.HasIndex(e => e.Tstatus)
                    .HasName("IDX_TODO_TSTATUS");

                entity.Property(e => e.Keytodo)
                    .HasColumnName("KEYTODO")
                    .ValueGeneratedNever();

                entity.Property(e => e.Clientname)
                    .HasColumnName("CLIENTNAME")
                    .HasMaxLength(80)
                    .IsUnicode(false)
                    .HasComputedColumnSql("([dbo].[FUNC_CLIENT]([keynump]))");

                entity.Property(e => e.Compdate)
                    .HasColumnName("COMPDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Cr8key).HasColumnName("CR8KEY");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Detail)
                    .IsRequired()
                    .HasColumnName("DETAIL")
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Duedate)
                    .HasColumnName("DUEDATE")
                    .HasColumnType("datetime");

                entity.Property(e => e.Keycall).HasColumnName("KEYCALL");

                entity.Property(e => e.Keynumo).HasColumnName("KEYNUMO");

                entity.Property(e => e.Keynump).HasColumnName("KEYNUMP");

                entity.Property(e => e.Priority)
                    .IsRequired()
                    .HasColumnName("PRIORITY")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Private).HasColumnName("PRIVATE");

                entity.Property(e => e.Respkey).HasColumnName("RESPKEY");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.SalesforceId)
                    .HasColumnName("Salesforce_Id")
                    .HasMaxLength(18)
                    .IsUnicode(false);

                entity.Property(e => e.Subj)
                    .IsRequired()
                    .HasColumnName("SUBJ")
                    .HasMaxLength(95)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Tasktype)
                    .IsRequired()
                    .HasColumnName("TASKTYPE")
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Tstatus)
                    .IsRequired()
                    .HasColumnName("TSTATUS")
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");
            });

            modelBuilder.Entity<Withd>(entity =>
            {
                entity.HasKey(e => e.Keywith)
                    .ForSqlServerIsClustered(false);

                entity.ToTable("WITHD");

                entity.HasIndex(e => e.Ctype)
                    .HasName("IDX_WITHD_CTYPE");

                entity.HasIndex(e => e.Dtype)
                    .HasName("IDX_WITHD_DTYPE");

                entity.HasIndex(e => e.Yrmo)
                    .HasName("IDX_WITHD_YRMO");

                entity.Property(e => e.Keywith)
                    .HasColumnName("KEYWITH")
                    .ValueGeneratedNever();

                entity.Property(e => e.Bob)
                    .HasColumnName("BOB")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.Cr8Date)
                    .HasColumnName("CR8_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Cr8Locn)
                    .IsRequired()
                    .HasColumnName("CR8_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Ctype)
                    .IsRequired()
                    .HasColumnName("CTYPE")
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Del).HasColumnName("DEL_");

                entity.Property(e => e.Desc)
                    .IsRequired()
                    .HasColumnName("DESC_")
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasDefaultValueSql("('')");

                entity.Property(e => e.Dtype)
                    .IsRequired()
                    .HasColumnName("DTYPE")
                    .HasMaxLength(1)
                    .IsUnicode(false);

                entity.Property(e => e.Frank)
                    .HasColumnName("FRANK")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.Marty)
                    .HasColumnName("MARTY")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.Mary)
                    .HasColumnName("MARY")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.Other)
                    .HasColumnName("OTHER")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.Peter)
                    .HasColumnName("PETER")
                    .HasColumnType("numeric(9, 0)");

                entity.Property(e => e.RevDate)
                    .HasColumnName("REV_DATE")
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.RevLocn)
                    .IsRequired()
                    .HasColumnName("REV_LOCN")
                    .HasMaxLength(14)
                    .IsUnicode(false)
                    .HasDefaultValueSql("(suser_sname())");

                entity.Property(e => e.Yrmo)
                    .IsRequired()
                    .HasColumnName("YRMO")
                    .HasMaxLength(6)
                    .IsUnicode(false);
            });
        }
    }
}
