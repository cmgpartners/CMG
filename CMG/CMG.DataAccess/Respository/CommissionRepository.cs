using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Respository
{
    public class CommissionRepository : Repository<Comm>, ICommissionRepository
    {
        private readonly pb2Context _context;

        public CommissionRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
