using CMG.DataAccess.Interface;
using System;
using CMG.DataAccess.Domain;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore.Storage;
using System.Threading.Tasks;
using CMG.DataAccess.Repository;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Linq;

namespace CMG.DataAccess
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private readonly pb2Context _context;
        private bool _isDisposed = false;
        private readonly ILogger _logger;
        private IDbContextTransaction _transaction;

        public UnitOfWork(pb2Context context, ILogger<UnitOfWork> logger = null)
        {
            _logger = logger;
            _context = context;
            _transaction = _context.Database.BeginTransaction();
        }

        #region Repositories
        private ICommissionRepository _commissionRepository;
        private IAgentRepository _agentRepository;
        private IPolicyRepository _policyRepository;
        private IAgentCommissionRepository _agentCommissionRepository;
        private IWithdrawalsRepository _withdrawalsRepository;
        private IAgentWithdrawalsRepository _agentWithdrawalsRepository;
        private IComboRepository _comboRepository;

        private IPeoplePolicyRepository _peoplePolicyRepository;
        private IPeopleRepository _peopleRepository;
        private IBusinessRelationRepository _businessRelationRepository;
        private IPeopleRelationRepository _peopleRelationRepository;
        private IBusinessRepository _businessRepository;
        private IBusinessPolicyRepository _businessPolicyRepository;
        private IPolicyIllustrationRepository _policyIllustrationRepository;
        private IOptionsRepository _optionsRepository;

        public ICommissionRepository Commissions => _commissionRepository ?? (_commissionRepository = new CommissionRepository(_context));
        public IAgentRepository Agents => _agentRepository ?? (_agentRepository = new AgentRepository(_context));
        public IPolicyRepository Policies => _policyRepository ?? (_policyRepository = new PolicyRepository(_context));
        public IAgentCommissionRepository AgentCommissions => _agentCommissionRepository ?? (_agentCommissionRepository = new AgentCommissionRepository(_context));
        public IWithdrawalsRepository Withdrawals => _withdrawalsRepository ?? (_withdrawalsRepository = new WithdrawalRepository(_context));
        public IAgentWithdrawalsRepository AgentWithdrawals => _agentWithdrawalsRepository ?? (_agentWithdrawalsRepository = new AgentWithdrawalsRepository(_context));
        public IComboRepository Combo => _comboRepository ?? (_comboRepository = new ComboRepository(_context));
        public IPeoplePolicyRepository PeoplePolicy => _peoplePolicyRepository ?? (_peoplePolicyRepository = new PeoplePolicyRepository(_context));
        public IPeopleRepository People => _peopleRepository ?? (_peopleRepository = new PeopleRepository(_context));
        public IBusinessRelationRepository BusinessRelation => _businessRelationRepository ?? (_businessRelationRepository = new BusinessRelationRepository(_context));
        public IPeopleRelationRepository PeopleRelation => _peopleRelationRepository ?? (_peopleRelationRepository = new PeopleRelationRepository(_context));
        public IBusinessRepository Business => _businessRepository ?? (_businessRepository = new BusinessRepository(_context));
        public IBusinessPolicyRepository BusinessPolicy => _businessPolicyRepository ?? (_businessPolicyRepository = new BusinessPolicyRepository(_context));
        public IPolicyIllustrationRepository PolicyIllustration => _policyIllustrationRepository ?? (_policyIllustrationRepository = new PolicyIllustrationRepository(_context));
        public IOptionsRepository Options => _optionsRepository ?? (_optionsRepository = new OptionsRepository(_context));

        public void Commit()
        {
            try
            {
                _context.SaveChanges();
                _transaction.Commit();
                _transaction = _context.Database.BeginTransaction();
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, ex.Message);
                _transaction.Rollback();
                _transaction.Dispose();
                throw;
            }
        }

        public void SaveChanges()
        {
            try
            {
                 _context.SaveChanges();
            }
            catch(Exception ex)
            {
                _logger?.LogError(ex, ex.Message);
                throw;
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        private void Dispose(bool isDisposing)
        {
            if (!_isDisposed)
            {
                if (isDisposing)
                {
                    try
                    {
                        if (_transaction != null)
                        {
                            try
                            {
                                _transaction.Rollback();
                                _transaction.Dispose();
                            }
                            catch (Exception ex)
                            {
                                _logger?.LogError(ex, ex.Message);
                            }
                        }
                        _context.Dispose();
                    }
                    catch (Exception ex)
                    {
                        _logger?.LogError(ex, ex.Message);
                    }
                    _isDisposed = true;
                }
            }
        }

        public bool HasCommissionAccess()
        {
            var result = _context.TablePermissions.FromSql("EXEC sp_table_privileges @table_name = 'COMM';").ToList();
            if(result != null && result.Count > 0)
            {
                result = result.Where(r => r.Grantee != "dbo").ToList();
                if(result != null && result.Count > 0)
                {
                    if (result.Any(r => (r.Privilege == "INSERT" && r.Is_Grantable == "YES") && (r.Privilege == "UPDATE" && r.Is_Grantable == "YES") && (r.Privilege == "DELETE" && r.Is_Grantable == "YES")))
                    {
                        return true;
                    }
                }
            }
            return false;
        }
    }
}
#endregion 