using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface IUnitOfWork
    {
        ICommissionRepository Commissions { get; }
        IAgentRepository Agents { get; }

        ICommissionSearchRepository CommissionSearch { get; }

        Task Commit();
        Task SaveChangesAsync();
    }
}
