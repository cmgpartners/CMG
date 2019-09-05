using System.Collections.Generic;
using System.Linq;
using CMG.DataAccess.Interface;

namespace CMG.DataAccess.Query
{
    public class SearchQuery : ISearchCriteria
    {
        private IList<FilterBy> _filterBy;
        public int? Page { get; set; }
        public int? PageSize { get; set; }
        public SortBy SortBy { get; set; }

        public IList<FilterBy> FilterBy
        {
            get => _filterBy ?? (_filterBy = new List<FilterBy>());
            set => _filterBy = value;
        }

        public IFilterBy this[string key]
        {
            get
            {
                return FilterBy.SingleOrDefault(w => w.Property == key);
            }
        }

    }
}
