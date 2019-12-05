using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class BusinessRepository : Repository<Business>, IBusinessRepository
    {
        private readonly pb2Context _context;

        public BusinessRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
