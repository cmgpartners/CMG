using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class BusinessPolicyRepository : Repository<BusinessPolicys>, IBusinessPolicyRepository
    {
        private readonly pb2Context _context;

        public BusinessPolicyRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
