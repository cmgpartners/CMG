using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class BusinessRelationRepository : Repository<RelBp>, IBusinessRelationRepository
    {
        private readonly pb2Context _context;

        public BusinessRelationRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
