using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Windows.Input;

namespace CMG.Application.ViewModel
{
    public class FinanceSummaryViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork; 
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        #endregion Member variables

        #region Constructor
        public FinanceSummaryViewModel(IUnitOfWork unitOfWork, IMapper mapper)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            LoadData();            
        }
        #endregion Constructor

        #region Properties
        public ICollection<string> Months
        {
            get
            {
                return DateTimeFormatInfo.CurrentInfo.MonthNames.Where(t => t.Length > 0).Select(m => m.Substring(0, 3)).ToList();
            }
        }

        public ICollection<int> Years
        {
            get
            {
                return Enumerable.Range(startYear, DateTime.Now.Year + 1 - startYear).ToList();
            }
        }

        private int _selectedYear = DateTime.Now.Year;
        public int SelectedYear
        {
            get { return _selectedYear; }
            set
            {
                _selectedYear = value;
                OnPropertyChanged("SelectedYear");
                LoadData();
            }
        }

        private string _selectedMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("MMM", CultureInfo.InvariantCulture);
        public string SelectedMonth
        {
            get { return _selectedMonth; }
            set
            {
                _selectedMonth = value;
                OnPropertyChanged("SelectedMonth");
                LoadData();
            }
        }

        private ObservableCollection<ViewWithdrawalDto> _dueToPartnersCollection;
        public ObservableCollection<ViewWithdrawalDto> DueToPartnersCollection
        {
            get { return _dueToPartnersCollection; }
            set
            {
                _dueToPartnersCollection = value;
                OnPropertyChanged("DueToPartnersCollection");
                OnPropertyChanged("IsNoRecordFound");
            }
        }
        private ObservableCollection<ViewWithdrawalDto> _agentExpensesCollection;
        public ObservableCollection<ViewWithdrawalDto> AgentExpensesCollection
        {
            get { return _agentExpensesCollection; }
            set
            {
                _agentExpensesCollection = value;
                OnPropertyChanged("AgentExpensesCollection");
            }
        }
        public ICommand RemoveAgentCommand
        {
            get { return CreateCommand(RemoveAgent); }
        }

        #endregion Properties

        #region Methods

        public void LoadData()
        {
            GetAgentExpenses();
            GetDueToPartners();
            //GetBankPositiosn();
            //GetPersonalCommissions();
        }
        public void GetDueToPartners()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            DueToPartnersCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList());
        }
        public void GetAgentExpenses()
        {
            SearchQuery searchQuery = BuildSearchQuery("W");
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            AgentExpensesCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList());
        }
        public void RemoveAgent(object selectedAgentWithdrawal)
        {
            var _selectedAgentWithdrawal = (ViewAgentWithdrawalDto)selectedAgentWithdrawal;
            _selectedAgentWithdrawal.IsVisible = false;
            var currentAgentWithdrawal = AgentExpensesCollection.Where(expense => expense.WithdrawalId == _selectedAgentWithdrawal.WithdrawalId).SingleOrDefault();
            var index = AgentExpensesCollection.IndexOf(currentAgentWithdrawal);
            AgentExpensesCollection.Remove(currentAgentWithdrawal);
            AgentExpensesCollection.Insert(index, currentAgentWithdrawal);
        }
        private SearchQuery BuildSearchQuery(string dType = "L")
        {
            int month = DateTime.ParseExact(SelectedMonth, "MMM", null).Month;
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> filterBy = new List<FilterBy>();
            filterBy.Add(FilterByEqual("yrmo", SelectedYear.ToString() + month.ToString("D2")));
            filterBy.Add(FilterByEqual("dtype", dType));
            searchQuery.FilterBy = filterBy;
            return searchQuery;
        }

        private FilterBy FilterByEqual(string propertyName, string value)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.Equal = value;
            return filterBy;
        }
        #endregion Methods
    }
}
