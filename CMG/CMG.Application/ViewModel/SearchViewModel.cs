using System;
using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using System.Collections.ObjectModel;
using System.Linq;
using System.Collections.Generic;
using System.Windows.Input;

namespace CMG.Application.ViewModel
{
    public class SearchViewModel : BaseViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        #endregion Member variables

        #region Properties
        private ObservableCollection<ViewCommissionDto> _dataCollection;
        public ObservableCollection<ViewCommissionDto> DataCollection
        {
            get { return _dataCollection; }
            set
            {
                _dataCollection = value;
                OnPropertyChanged("DataCollection");
            }
        }
        private string _policyNumber;
        public string PolicyNumber
        {
            get { return _policyNumber; }
            set
            {
                _policyNumber = value;
                OnPropertyChanged("PolicyNumber");
            }
        }
        private string _insured;
        public string Insured
        {
            get { return _insured;  }
            set
            {
                _insured = value;
                OnPropertyChanged("Insured");
            }
        }
        private string _company;
        public string Company
        {
            get { return _company; }
            set
            {
                _company = value;
                OnPropertyChanged("Company");
            }
        }
        private DateTime? _fromPayDate;
        public DateTime? FromPayDate
        {
            get { return _fromPayDate; }
            set
            {
                _fromPayDate = value;
                OnPropertyChanged("FromPayDate");
            }
        }
        private DateTime? _toPayDate;
        public DateTime? ToPayDate
        {
            get { return _toPayDate; }
            set
            {
                _toPayDate = value;
                OnPropertyChanged("ToPayDate");
            }
        }
        private string _agent;
        public string Agent
        {
            get { return _agent; }
            set
            {
                _agent = value;
                OnPropertyChanged("Agent");
            }
        }
        public ICommand SearchCommand
        {
            get { return CreateCommand(Search); }
        }
        #endregion Properties

        #region Constructor
        public SearchViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        #endregion Constructor

        #region Methods
        public void Search()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            var dataSearchBy = _unitOfWork.Commissions.Find(searchQuery);
            DataCollection = new ObservableCollection<ViewCommissionDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
        }
        private SearchQuery BuildSearchQuery()
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            if (!string.IsNullOrEmpty(PolicyNumber))
            {
                BuildFilterByContains("PolicyNumber", PolicyNumber, searchBy);
            }
            if (!string.IsNullOrEmpty(Insured))
            {
                BuildFilterByContains("Insured", Insured, searchBy);
            }
            if (!string.IsNullOrEmpty(Company))
            {
                BuildFilterByContains("Company", Company, searchBy);
            }
            if(FromPayDate != null && ToPayDate != null)
            {
                BuildFilterByRange("PayDate", FromPayDate.Value.ToShortDateString() , ToPayDate.Value.ToShortDateString(), searchBy);
            }
            else if(FromPayDate != null && ToPayDate == null)
            {
                BuildFilterByRange("PayDate", FromPayDate.Value.ToShortDateString(), DateTime.Today.ToShortDateString(), searchBy);
            }
            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }
        private void BuildFilterByContains(string property, string value, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.Contains = value;
            searchBy.Add(filterBy);
        }

        private void BuildFilterByRange(string property, string fromvalue, string toValue, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.GreaterThan = fromvalue;
            filterBy.LessThan = toValue;
            searchBy.Add(filterBy);
        }
        #endregion Methods
    }
}
