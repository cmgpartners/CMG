using CMG.Common;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using LinqKit;
using System.Collections.Generic;

namespace CMG.DataAccess.Respository
{
    public class AgentRepository : Repository<Agent>, IAgentRepository
    {
        private readonly pb2Context _context;

        public AgentRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public Agent Find(long id)
        {
            return Context.Agent
                .SingleOrDefault(x => x.Id == id);
        }
    }
}
