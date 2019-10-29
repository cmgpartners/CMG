using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface IUnitOfWork
    {
        ICommissionRepository Commissions { get; }
        IAgentRepository Agents { get; }
        IPolicyRepository Policies { get; }
        IAgentCommissionRepository AgentCommissions { get; }

        void Commit();
        void SaveChanges();
    }
}
