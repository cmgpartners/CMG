using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.DataAccess.Interface
{
    public interface ISearchCriteria
    {
        int? Page { get; set; }
        int? PageSize { get; set; }
        SortBy SortBy { get; set; }
        IList<FilterBy> FilterBy { get; set; }
        IFilterBy this[string key]
        {
            get;
        }
    }

    public interface ISortBy
    {
        string Property { get; set; }
        bool? DescendingOrder { get; set; }
    }

    public interface IFilterBy
    {
        string Property { get; set; }
        string Equal { get; set; }
        string GreaterThan { get; set; }
        string LessThan { get; set; }
        string NotEqual { get; set; }
        string In { get; set; }
        string Contains { get; set; }
    }

    public class SortBy : ISortBy
    {
        public string Property { get; set; }
        public bool? DescendingOrder { get; set; }
    }

    public class FilterBy : IFilterBy
    {
        public string Property { get; set; }
        public string Equal { get; set; }
        public string GreaterThan { get; set; }
        public string LessThan { get; set; }
        public string NotEqual { get; set; }
        public string In { get; set; }
        public string Contains { get; set; }
    }
}
