using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Collections.ObjectModel;
using System.Linq;
using AutoMapper;
using System.Globalization;
using System.Collections.Generic;
using System;
using CMG.DataAccess.Query;
using System.Windows.Input;
using CMG.DataAccess.Domain;
using System.Windows;

namespace CMG.Application.ViewModel
{
    public class RenewalsViewModel : BaseViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        #endregion Member variables

        #region Constructor
        public RenewalsViewModel(IUnitOfWork unitOfWork, IMapper mapper)
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
                IsImportEnabled = false;
                OnPropertyChanged("SelectedYear");
                GetCommissions();
            }
        }

        private string _selectedMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("MMM", CultureInfo.InvariantCulture);
        public string SelectedMonth
        {
            get { return _selectedMonth; }
            set
            {
                _selectedMonth = value;
                IsImportEnabled = false;
                OnPropertyChanged("SelectedMonth");
                GetCommissions();
            }
        }

        private ObservableCollection<ViewCommissionDto> _dataCollection;
        public ObservableCollection<ViewCommissionDto> DataCollection
        {
            get { return _dataCollection; }
            set
            {
                _dataCollection = value;
                OnPropertyChanged("DataCollection");
                OnPropertyChanged("IsNoRecordFound");
            }
        }

        public bool IsNoRecordFound
        {
            get
            {
                return DataCollection != null && DataCollection.Count == 0;
            }
        }

        public ICommand ImportCommand
        {
            get { return CreateCommand(Import); }
        }

        public ICommand SaveCommand
        {
            get { return CreateCommand(Save); }
        }
        private bool isImportEnabled;
        public bool IsImportEnabled
        {
            get { return isImportEnabled; }
            set
            {
                isImportEnabled = value;
                OnPropertyChanged("IsImportEnabled");
            }
        }

        #endregion Properties

        #region Methods
        public void GetCommissions()
        {
            int year;
            if (IsImportEnabled)
            {
                year = SelectedYear - 1;
            }
            else
            {
                year = SelectedYear;
            }
            SearchQuery searchQuery = BuildSearchQuery(year, SelectedMonth);
            var dataSearchBy = _unitOfWork.Commissions.Find(searchQuery);
            DataCollection = new ObservableCollection<ViewCommissionDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
            if (IsImportEnabled)
            {
                UpdateImportCollection();
            }
        }

        public void Import()
        {
            IsImportEnabled = true;
            GetCommissions();
        }

        public void Save()
        {
            if(DataCollection != null && DataCollection.Count > 0)
            {
                if (isImportEnabled)
                {
                    try
                    {
                        foreach (ViewCommissionDto commission in DataCollection)
                        {
                            foreach (ViewAgentCommissionDto agentComm in commission.AgentCommissions)
                            {
                                agentComm.Agent = null;
                                agentComm.CreatedDate = null;
                                agentComm.CreatedBy = null;
                            }
                            var entityCommission = _mapper.Map<Comm>(commission);
                            entityCommission.Yrmo = entityCommission.Paydate?.ToString("yyyyMM");
                            var commissionId = _unitOfWork.Commissions.Add(entityCommission);
                            _unitOfWork.Commit();
                        }
                        //MessageBox.Show("Records saved successfully", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                    }
                    catch (Exception ex)
                    {
                        //MessageBox.Show("Error: " + ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                    }
                }
            }
        }

       
        private void LoadData()
        {
            GetCommissions();
            GetCommissions();
        }
        private SearchQuery BuildSearchQuery(int year, string month)
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            var fromPayDate = new DateTime(year, Array.IndexOf(Months.ToArray(),month) + 1, 1);
            var toPayDate = fromPayDate.AddMonths(1).AddDays(-1);
            FilterBy filterBy = new FilterBy();
            filterBy.Property = "PayDate";
            filterBy.GreaterThan = fromPayDate.ToShortDateString();
            filterBy.LessThan = toPayDate.ToShortDateString();
            searchBy.Add(filterBy);
            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }

        private void UpdateImportCollection()
        {
            if (DataCollection != null && DataCollection.Count > 0)
            {
                foreach(ViewCommissionDto commission in DataCollection)
                {
                    commission.CommissionId = 0;
                    commission.CreatedDate = null;
                    commission.CreatedBy = null;
                    commission.TotalAmount = 0;
                    commission.AgentCommissions.Select(comm => { comm.Commission = 0; return comm; }).ToList();
                }
            }
        }
        #endregion Methods
    }
}
