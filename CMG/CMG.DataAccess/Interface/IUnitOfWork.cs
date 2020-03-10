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
        IPeoplePolicyRepository PeoplePolicy { get; }
        IPeopleRepository People { get; }
        IBusinessRelationRepository BusinessRelation { get; }
        IPeopleRelationRepository PeopleRelation { get; }
        IBusinessRepository Business { get; }
        IBusinessPolicyRepository BusinessPolicy { get; }
        IPolicyIllustrationRepository PolicyIllustration { get; }

        IOptionsRepository Options { get; }

        void Commit();
        void SaveChanges();
        public bool HasCommissionAccess();
    }
}
