using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Collections.Generic;
using System.Linq;

namespace CMG.DataAccess.Repository
{
    public class BusinessRelationRepository : Repository<RelBp>, IBusinessRelationRepository
    {
        private readonly pb2Context _context;

        public BusinessRelationRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public ICollection<Business> GetById(long? id)
        {
            List<Business> business = new List<Business>();
            List<RelBp> businessRelations = new List<RelBp>();
            businessRelations.AddRange(Context.RelBp.Where(x => x.Keynump == (id ?? 0)));
            BusinessRepository businessRepository = new BusinessRepository(Context);
            for (int i = 0; i < businessRelations.Count; i++)
            {
                business.Add(businessRepository.GetById(businessRelations[i].Keynumb));
            }

            return business;
        }
    }
}
