using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace CMG.DataAccess.Repository
{
    public class AgentRepository : Repository<Agent>, IAgentRepository
    {
        private readonly pb2Context _context;

        public AgentRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
