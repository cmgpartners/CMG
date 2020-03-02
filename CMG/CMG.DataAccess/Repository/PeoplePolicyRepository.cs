using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Linq;

namespace CMG.DataAccess.Repository
{
    public class PeoplePolicyRepository : Repository<PeoplePolicys>, IPeoplePolicyRepository
    {
        private readonly pb2Context _context;

        public PeoplePolicyRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public PeoplePolicys GetById(long? relationshipId)
        {
            return Context.PeoplePolicys.SingleOrDefault(x => x.Keynuml == (relationshipId ?? 0));
        }
        public int GetMaxKeynuml()
        {
            var maxId = Context.PeoplePolicys.Select(x => x.Keynuml).OrderByDescending(x => x).FirstOrDefault();
            return maxId;
        }
    }
}
