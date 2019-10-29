using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public partial class AgentWithdrawal : EntityBaseNew
    {
        [Key]
        public int Id { get; set; }
        public int WithdrawalId { get; set; }
        public int? AgentId { get; set; }
        public double? Amount { get; set; }
        public virtual Agent Agent { get; set; }
        public virtual Withd Withdrawal { get; set; }
    }
}
