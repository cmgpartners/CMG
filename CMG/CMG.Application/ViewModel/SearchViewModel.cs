using System;
using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using System.Collections.ObjectModel;
using System.Linq;
using System.Collections.Generic;
using System.Windows.Input;
using ToastNotifications;
using ToastNotifications.Messages;

namespace CMG.Application.ViewModel
{
    public class SearchViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly Notifier _notifier;
        private readonly int PageSize = 15;
        #endregion Member variables

        #region Constructor
        public SearchViewModel(IUnitOfWork unitOfWork, IMapper mapper, Notifier notifier)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            LoadData();
        }
        #endregion Constructor

        #region Properties
        private ObservableCollection<ViewCommissionDto> _dataCollection;
        public ObservableCollection<ViewCommissionDto> DataCollection
        {
            get { return _dataCollection; }
            set
            {
                _dataCollection = value;
                OnPropertyChanged("DataCollection");
                OnPropertyChanged("IsPaginationVisible");
                OnPropertyChanged("IsNoRecordFound");
            }
        }

        private ObservableCollection<ViewAgentDto> _agentList;

        public ObservableCollection<ViewAgentDto> AgentList
        {
            get { return _agentList; }
            set
            {
                _agentList = value;
                OnPropertyChanged("AgentList");
            }
        }

        private List<ViewComboDto> _combo;
        public List<ViewComboDto> Combo
        {
            get { return _combo; }
            set { _combo = value; }
        }

        private List<ViewComboDto> _companies;
        public List<ViewComboDto> Companies
        {
            get { return _companies; }
            set { _companies = value; OnPropertyChanged("Companies"); }
        }

        private List<string> _companyNames;
        public List<string> CompanyNames
        {
            get { return _companyNames; }
            set { _companyNames = value; OnPropertyChanged("CompanyNames"); }
        }

        private int selecteAgentIndex;
        public int SelecteAgentIndex
        {
            get
            {
                return selecteAgentIndex;
            }
            set
            {
                selecteAgentIndex = value;
                OnPropertyChanged("SelecteAgentIndex");
            }
        }
        private List<string> _policies;
        public List<string> Policies
        {
            get { return _policies; }
            set
            {
                _policies = value;
                OnPropertyChanged("Policies");
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
            get { return _insured; }
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
        private ViewAgentDto _agent;

        public ViewAgentDto Agent
        {
            get { return _agent; }
            set
            {
                _agent = value;
                OnPropertyChanged("Agent");
            }
        }

        private bool _isFYC;
        public bool IsFYC
        {
            get { return _isFYC; }
            set
            {
                _isFYC = value;
                OnPropertyChanged("IsFYC");
            }
        }
        private bool _isRenewals;
        public bool IsRenewals
        {
            get { return _isRenewals; }
            set
            {
                _isRenewals = value;
                OnPropertyChanged("IsRenewals");
            }
        }

        private string _comment;
        public string Comment
        {
            get { return _comment; }
            set
            {
                _comment = value;
                OnPropertyChanged("Comment");
            }
        }
        private decimal _totalAmount;
        public decimal TotalAmount
        {
            get { return _totalAmount; }
            set
            {
                _totalAmount = value;
                OnPropertyChanged("TotalAmount");
            }
        }
        #region pagination properties
        private int _totalRecords;
        public int TotalRecords
        {
            get { return _totalRecords; }
            set
            {
                _totalRecords = value;
                OnPropertyChanged("TotalRecords");
                OnPropertyChanged("TotalPages");
            }
        }
        private int _currentPage = 1;
        public int CurrentPage
        {
            get { return _currentPage; }
            set
            {
                _currentPage = value;
                OnPropertyChanged("CurrentPage");
            }

        }
        private List<int> _pages;
        public List<int> Pages
        {
            get { return _pages; }
            set
            {
                _pages = value;
                OnPropertyChanged("Pages");
            }
        }
        public int TotalPages
        {
            get { return TotalRecords % PageSize == 0 ? (TotalRecords / PageSize) : (TotalRecords / PageSize) + 1; }
        }
        public bool IsPaginationVisible
        {
            get { return DataCollection != null && DataCollection.Count > 0; }
        }

        public bool IsNoRecordFound
        {
            get
            {
                return DataCollection != null && DataCollection.Count == 0;
            }
        }
        #endregion

        #region command properties
        public ICommand SearchCommand
        {
            get { return CreateCommand(Search); }
        }
        public ICommand FirstPageCommand
        {
            get { return CreateCommand(FirstPage); }
        }
        public ICommand LastPageCommand
        {
            get { return CreateCommand(LastPage); }
        }
        public ICommand NextPageCommand
        {
            get { return CreateCommand(NextPage); }
        }
        public ICommand PreviousPageCommand
        {
            get { return CreateCommand(PreviousPage); }
        }
        #endregion command properties
        #endregion Properties

        #region Methods
        public void FirstPage()
        {
            CurrentPage = 1;
            Search(false);
        }
        public void LastPage()
        {
            CurrentPage = TotalPages;
            Search(false);
        }
        public void NextPage()
        {
            if (CurrentPage < TotalPages)
            {
                CurrentPage += 1;
                Search(false);
            }
        }
        public void PreviousPage()
        {
            if (CurrentPage > 1)
            {
                CurrentPage -= 1;
                Search(false);
            }
        }

        public void Search(object isPageReset)
        {
            SearchQuery searchQuery = BuildSearchQuery();
            if (searchQuery != null)
            {
                if (Convert.ToBoolean(isPageReset))
                {
                    CurrentPage = 1;
                }
                searchQuery.Page = CurrentPage;
                searchQuery.PageSize = PageSize;
                var dataSearchBy = _unitOfWork.Commissions.Find(searchQuery);
                var dataCollection = dataSearchBy.Result.Select(x => { x.Company = x.Company.Trim() == "" ? "" : Companies.Where(c => c.FieldCode == x.Company.Trim()).FirstOrDefault().Description; return x; });
                DataCollection = new ObservableCollection<ViewCommissionDto>(dataCollection.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
                TotalRecords = dataSearchBy.TotalRecords;
                TotalAmount = dataSearchBy.TotalAmount;
                LoadPagination();
            }
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
                if (!(Companies.Any(x => x.Description.ToLower() == Company.ToLower()))) 
                {
                    _notifier.ShowError($@"Company name ""{Company}"" does not exist");
                    return null;
                }
                var companyCode = string.IsNullOrEmpty(Company) ? string.Empty : Companies.Where(x => x.Description.ToLower() == Company.ToLower()).FirstOrDefault().FieldCode;
                BuildFilterByContains("Company", companyCode, searchBy);
            }
            if (FromPayDate != null && ToPayDate != null)
            {
                BuildFilterByRange("PayDate", FromPayDate.Value.ToShortDateString(), ToPayDate.Value.ToShortDateString(), searchBy);
            }
            else if (FromPayDate != null && ToPayDate == null)
            {
                BuildFilterByRange("PayDate", FromPayDate.Value.ToShortDateString(), DateTime.Today.ToShortDateString(), searchBy);
            }
            if (Agent != null)
            {
                BuildFilterByEquals("Agent", Agent.Id.ToString(), searchBy);
            }
            if (!(IsFYC && IsRenewals))
            {
                if (IsFYC)
                    BuildFilterByEquals("FYC", "F", searchBy);
                else if (IsRenewals)
                    BuildFilterByEquals("Renewal", "R", searchBy);
            }
            if (!string.IsNullOrEmpty(Comment))
            {
                BuildFilterByContains("Comment", Comment, searchBy);
            }
            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }

        private void BuildFilterByIn(string property, string value, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.In = value;
            searchBy.Add(filterBy);
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

        private void BuildFilterByEquals(string property, string value, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.Equal = value;
            searchBy.Add(filterBy);
        }

        private void LoadData()
        {
            var agents = _unitOfWork.Agents.All();
            AgentList = new ObservableCollection<ViewAgentDto>(agents.Select(r => _mapper.Map<ViewAgentDto>(r)).ToList());
            GetComboData();
            GetCompanies();
            GetPolicies();
        }
        private void LoadPagination()
        {
            _pages = new List<int>();
            Pages.AddRange(Enumerable.Range(1, TotalPages));
        }
        private void GetComboData()
        {
            var combo = _unitOfWork.Combo.All();
            Combo = combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
        }
        private void GetCompanies()
        {
            Companies = Combo.Where(x => x.FieldName.Trim() == "COMPANY").ToList();
            CompanyNames = Companies.Select(x => x.Description).ToList();
        }
        private void GetPolicies()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).ToList();
        }

        #endregion Methods
    }
}
