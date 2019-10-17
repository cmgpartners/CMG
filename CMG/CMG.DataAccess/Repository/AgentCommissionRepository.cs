using System.Collections.Generic;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;



namespace CMG.DataAccess.Repository
{
    public class AgentCommissionRepository : Repository<AgentCommission>, IAgentCommissionRepository
    {
        private readonly pb2Context _context;

        public AgentCommissionRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
