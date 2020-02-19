using CMG.DataAccess.Domain;

namespace CMG.DataAccess.Interface
{
    public interface IComboRepository : IRepository<Combo>
    {
        public Combo Find(long? id);
    }
}
