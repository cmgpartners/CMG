using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Collections.Generic;
using System.Linq;

namespace CMG.DataAccess.Repository
{
    public class PolicyRepository : Repository<Policys>, IPolicyRepository
    {
        private readonly pb2Context _context;

        public PolicyRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public ICollection<Policys> GetAllPolicyNumber()
        {
            var result = _context.Policys.Select(x => new Policys
            {
                Keynumo = x.Keynumo,
                Policynum = x.Policynum
            }).ToList();

            return result;
        }
    }
}
