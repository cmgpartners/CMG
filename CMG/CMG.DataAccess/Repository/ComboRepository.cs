using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Repository
{
    public class ComboRepository : Repository<Combo>, IComboRepository
    {
        private readonly pb2Context _context;

        public ComboRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
