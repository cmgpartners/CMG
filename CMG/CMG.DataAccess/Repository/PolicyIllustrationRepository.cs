using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class PolicyIllustrationRepository : Repository<PolIll>, IPolicyIllustrationRepository
    {
        private readonly pb2Context _context;

        public PolicyIllustrationRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
