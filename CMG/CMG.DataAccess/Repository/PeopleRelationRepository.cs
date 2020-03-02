using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Linq;
using System.Collections.Generic;

namespace CMG.DataAccess.Repository
{
    public class PeopleRelationRepository : Repository<RelPp>, IPeopleRelationRepository
    {
        private readonly pb2Context _context;

        public PeopleRelationRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public ICollection<People> GetById(long? id)
        {
            List<People> people = new List<People>();
            List<RelPp> relationships = new List<RelPp>();
            relationships.AddRange(Context.RelPp.Where(x => x.Keynump == (id ?? 0) 
                                                        || x.Keynump2 == (id ?? 0)).Select(x => new RelPp { Keynump = x.Keynump,
                                                                                                            Keynump2 = x.Keynump2}).ToList());
            List<int> peopleId = new List<int>();
            peopleId.AddRange(relationships.Select(x => x.Keynump));
            peopleId.AddRange(relationships.Select(x => x.Keynump2));
            peopleId = peopleId.Select(x => x).Distinct().ToList();

            PeopleRepository peopleRepository = new PeopleRepository(Context);

            for (int i = 0; i < peopleId.Count; i++)
            {
                people.Add(peopleRepository.GetById(peopleId[i]));
            }
            return people;
        }

    }
}
