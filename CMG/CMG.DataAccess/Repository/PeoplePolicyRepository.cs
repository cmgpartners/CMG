using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class PeoplePolicyRepository : Repository<PeoplePolicys>, IPeoplePolicyRepository
    {
        private readonly pb2Context _context;

        public PeoplePolicyRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
