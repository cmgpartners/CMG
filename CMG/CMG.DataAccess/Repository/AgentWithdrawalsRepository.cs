using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.DataAccess.Repository
{
    public class AgentWithdrawalsRepository : Repository<AgentWithdrawal>, IAgentWithdrawalsRepository
    {
        private readonly pb2Context _context;

        public AgentWithdrawalsRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
