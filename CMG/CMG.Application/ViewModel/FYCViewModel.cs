using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Windows.Input;

namespace CMG.Application.ViewModel
{
    public class FYCViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        private int newId;
        #endregion Member variables

        #region Constructor
        public FYCViewModel(IUnitOfWork unitOfWork, IMapper mapper)
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
                OnPropertyChanged("SelectedMonth");
                GetCommissions();
            }
        }
        private ViewCommissionDto _copiedCommission;
        public ViewCommissionDto CopiedCommission
        {
            get { return _copiedCommission; }
            set
            {
                _copiedCommission = value;
                OnPropertyChanged("CopiedCommission");
            }
        }
        private bool _isPasteEnables;
        public bool IsPasteEnabled
        {
            get
            {
                return _isPasteEnables = CopiedCommission != null;
            }
            set
            {
                _isPasteEnables = CopiedCommission != null;
                OnPropertyChanged("IsPasteEnabled");
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
        private IEnumerable<string> _policies;
        public IEnumerable<string> Policies
        {
            get { return _policies; }
            set
            {
                _policies = value;
                OnPropertyChanged("Policies");
            }
        }
        public ICommand SaveCommand
        {
            get { return CreateCommand(Save); }
        }
        public ICommand AddCommand
        {
            get { return CreateCommand(Add); }
        }
        public ICommand DeleteCommand
        {
            get { return CreateCommand(Delete); }
        }
        public ICommand PolicyAgentCommand
        {
            get { return CreateCommand(PolicyAgent); }
        }
        public ICommand CopyCommand
        {
            get { return CreateCommand(Copy); }
        }

        public ICommand PasteCommand
        {
            get { return CreateCommand(Paste); }
        }
        #endregion

        #region Methods

        public void GetCommissions()
        {
            SearchQuery searchQuery = BuildFYCSearchQuery(SelectedYear, SelectedMonth);
            var dataSearchBy = _unitOfWork.Commissions.Find(searchQuery);
            DataCollection = new ObservableCollection<ViewCommissionDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
        }
        public void Save()
        {
            if (DataCollection != null && DataCollection.Count > 0)
            {
                foreach (ViewCommissionDto commission in DataCollection)
                {
                    if (commission.CommissionId > 0)
                    {
                        var entity = _mapper.Map<Comm>(commission);
                        entity.Yrmo = entity.Paydate?.ToString("yyyyMM");
                        entity.RevDate = DateTime.Now;
                        entity.RevLocn = $"{Environment.UserDomainName}\\{Environment.UserName}";
                        foreach (AgentCommission agentComm in entity.AgentCommissions)
                        {
                            agentComm.ModifiedBy = $"{Environment.UserDomainName}\\{Environment.UserName}";
                            agentComm.ModifiedDate = DateTime.Now;
                            _unitOfWork.AgentCommissions.Save(agentComm);
                        }
                        var commissionId = _unitOfWork.Commissions.Save(entity);
                        _unitOfWork.Commit();
                    }
                    else
                    {
                        foreach (ViewAgentCommissionDto agentComm in commission.AgentCommissions)
                        {
                            agentComm.Agent = null;
                            agentComm.CreatedDate = null;
                            agentComm.CreatedBy = null;
                        }
                        commission.CommissionId = 0;
                        var entityCommission = _mapper.Map<Comm>(commission);
                        entityCommission.Yrmo = entityCommission.Paydate?.ToString("yyyyMM");
                        entityCommission.Commtype = "F";
                        var commissionId = _unitOfWork.Commissions.Add(entityCommission);
                        _unitOfWork.Commit();
                    }
                }
                GetCommissions();
            }
        }
        public void Add()
        {
            DataCollection.Add(new ViewCommissionDto() { IsNew = true, IsNotNew = false, CommissionId = --newId });
        }
        public void Delete(object commissionId)
        {
            if (commissionId != null && Convert.ToInt32(commissionId) > 0)
            {
                var commission = _unitOfWork.Commissions.Find(Convert.ToInt32(commissionId));
                commission.Del = true;
                commission.RevDate = DateTime.Now;
                commission.RevLocn = $"{Environment.UserDomainName}\\{Environment.UserName}";
                commission.AgentCommissions = commission.AgentCommissions.Select(agentComm => { agentComm.IsDeleted = true; return agentComm; }).AsEnumerable();
                _unitOfWork.Commit();
                GetCommissions();
            }
            else
            {
                DataCollection.Remove(DataCollection.Where(commission => commission.CommissionId == Convert.ToInt32(commissionId)).SingleOrDefault());
            }
        }

        public void PolicyAgent(object currentItem)
        {
            if (string.IsNullOrEmpty(((ViewCommissionDto)currentItem).PolicyNumber)) { return; }

            SearchQuery searchQuery = BuildPolicySearchQuery("PolicyNumber", ((ViewCommissionDto)currentItem).PolicyNumber);
            var policy = _unitOfWork.Policies.Find(searchQuery);
            ViewPolicyDto policyDto;
            if (policy != null)
            {
                policyDto = policy.Result.Select(r => _mapper.Map<ViewPolicyDto>(r)).SingleOrDefault();
                if (policyDto != null)
                {
                    List<ViewAgentCommissionDto> agnetCommissions = new List<ViewAgentCommissionDto>();
                    var currentCommission = DataCollection.Where(comm => comm.CommissionId == ((ViewCommissionDto)currentItem).CommissionId).SingleOrDefault();
                    if (currentCommission != null)
                    {
                        var mappedCurrrentItem = _mapper.Map(policyDto, currentCommission);
                        agnetCommissions = mappedCurrrentItem.AgentCommissions.ToList();
                        var index = DataCollection.IndexOf(currentCommission);
                        DataCollection[index] = new ViewCommissionDto()
                        {
                            CompanyName = mappedCurrrentItem.CompanyName,
                            InsuredName = mappedCurrrentItem.InsuredName,
                            IsNew = true,
                            PolicyId = mappedCurrrentItem.PolicyId,
                            AgentCommissions = agnetCommissions,
                            PayDate = currentCommission.PayDate,
                            PolicyNumber = currentCommission.PolicyNumber,
                            IsNotNew = false,
                            Renewal = currentCommission.Renewal,
                        };
                    }
                }
            }
        }
        public void Copy(object commissionInput)
        {
            CopiedCommission = commissionInput as ViewCommissionDto;
            IsPasteEnabled = true;
        }

        public void Paste(object dataInput)
        {
            ViewCommissionDto data = dataInput as ViewCommissionDto;
            int index = DataCollection.IndexOf(data);
            if (CopiedCommission != null)
            {
                CopiedCommission.CommissionId = 0;
                CopiedCommission.AgentCommissions.ToList().ForEach(a => a.Id = 0);
                DataCollection.Insert(index, CopiedCommission);
                CopiedCommission = null;
                IsPasteEnabled = false;
            }
        }

        #region Helper Methods
        private void LoadData()
        {
            GetCommissions();
            GetPolicies();
        }

        private SearchQuery BuildFYCSearchQuery(int year, string month)
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> filterBy = new List<FilterBy>();
            var fromPayDate = new DateTime(year, Array.IndexOf(Months.ToArray(), month) + 1, 1);
            var toPayDate = fromPayDate.AddMonths(1).AddDays(-1);
            filterBy.Add(FilterByRange("PayDate", fromPayDate.ToShortDateString(), toPayDate.ToShortDateString()));
            filterBy.Add(FilterByEqual("FYC", "F"));
            searchQuery.FilterBy = filterBy;
            return searchQuery;
        }

        private SearchQuery BuildPolicySearchQuery(string propertyName, string propertyValue)
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.Equal = propertyValue;
            searchBy.Add(filterBy);
            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }

        private FilterBy FilterByRange(string propertyName, string greaterThan, string lessThan)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.GreaterThan = greaterThan;
            filterBy.LessThan = lessThan;
            return filterBy;
        }

        private FilterBy FilterByEqual(string propertyName, string value)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.Equal = value;
            return filterBy;
        }

        private void GetPolicies()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).AsEnumerable();
        }
        #endregion

        #endregion
    }
}
