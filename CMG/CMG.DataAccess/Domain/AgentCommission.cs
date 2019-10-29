using System;
using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public partial class AgentCommission : EntityBaseNew
    {
        [Key]
        public int Id { get; set; }
        public int? AgentId { get; set; }
        public int CommissionId { get; set; }
        public double? Commission { get; set; }
        public double? Split { get; set; }
        public int? AgentOrder { get; set; }
        public virtual Agent Agent { get; set; }
        public virtual Comm CommissionNavigation { get; set; }
    }
}
