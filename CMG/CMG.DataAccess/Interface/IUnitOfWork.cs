using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface IUnitOfWork
    {
        ICommissionRepository Commissions { get; }
        IAgentRepository Agents { get; }
        IPolicyRepository Policies { get; }
        IAgentCommissionRepository AgentCommissions { get; }
        IWithdrawalsRepository Withdrawals { get; }
        IAgentWithdrawalsRepository AgentWithdrawals { get; }
        IComboRepository Combo { get; }

        void Commit();
        void SaveChanges();
    }
}
