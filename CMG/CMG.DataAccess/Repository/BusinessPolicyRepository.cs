using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Linq;

namespace CMG.DataAccess.Repository
{
    public class BusinessPolicyRepository : Repository<BusinessPolicys>, IBusinessPolicyRepository
    {
        private readonly pb2Context _context;

        public BusinessPolicyRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public BusinessPolicys GetById(long? relationshipId)
        {
            return Context.BusinessPolicys.SingleOrDefault(x => x.Keynum == (relationshipId ?? 0));
        }
        public int GetMaxKeynum()
        {
            var maxId = All().OrderByDescending(x => x.Keynum).FirstOrDefault()?.Keynum;
            return maxId == null ? 0 : maxId.Value;
        }
    }
}
