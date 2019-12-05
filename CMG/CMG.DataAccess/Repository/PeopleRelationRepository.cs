using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class PeopleRelationRepository : Repository<RelPp>, IPeopleRelationRepository
    {
        private readonly pb2Context _context;

        public PeopleRelationRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
