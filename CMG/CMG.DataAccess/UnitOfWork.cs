﻿using CMG.DataAccess.Interface;
using System;
using CMG.DataAccess.Domain;
using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore.Storage;
using System.Threading.Tasks;
using CMG.DataAccess.Respository;

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

        public ICommissionRepository Commissions => _commissionRepository ?? (_commissionRepository = new CommissionRepository(_context));
        public IAgentRepository Agents => _agentRepository ?? (_agentRepository = new AgentRepository(_context));

        public async Task Commit()
        {
            try
            {
                await _context.SaveChangesAsync();
                _transaction.Commit();
                _transaction = _context.Database.BeginTransaction();
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, ex.Message);
                throw;
            }
        }

        public async Task SaveChangesAsync()
        {
            try
            {
                await _context.SaveChangesAsync();
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
    }
}
#endregion 