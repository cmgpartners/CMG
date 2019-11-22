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
using ToastNotifications;
using ToastNotifications.Messages;

namespace CMG.Application.ViewModel
{
    public class FYCViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly Notifier _notifier;
        private const int startYear = 1925;
        private int newId;
        #endregion Member variables

        #region Constructor
        public FYCViewModel(IUnitOfWork unitOfWork, IMapper mapper, Notifier notifier)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
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

        public string SelectedMonthNumber
        {
            get
            {
                return DateTime.ParseExact(SelectedMonth, "MMM", null).Month.ToString("00");
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
        public ICommand PolicyDetailsCommand
        {
            get { return CreateCommand(PolicyDetails); }
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
            DataCollection = new ObservableCollection<ViewCommissionDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList()
                            .Select(x => { x.CompanyName = x.CompanyName.Trim() == "" ? "" : Companies.Where(c => c.FieldCode == x.CompanyName.Trim()).FirstOrDefault().Description; return x; }).ToList());
        }
        public void Save()
        {
            try
            {
                if (DataCollection != null && DataCollection.Count > 0)
                {
                    if (DataCollection.Any(comm => string.IsNullOrEmpty(comm.PolicyNumber))) return;
                    var notExistPolicyNumber = DataCollection.Where(comm => !Policies.Contains(comm.PolicyNumber)).Select(x => x.PolicyNumber).FirstOrDefault();
                    if (notExistPolicyNumber != null)
                    {
                        _notifier.ShowError($@"Policy number ""{notExistPolicyNumber}"" does not exist");
                        return;
                    }
                    DataCollection = new ObservableCollection<ViewCommissionDto>(DataCollection.Select(x => { x.CompanyName = x.CompanyName.Trim() == string.Empty ? string.Empty : Companies.Where(c => c.Description == x.CompanyName.Trim()).FirstOrDefault().FieldCode; return x; }));
                    foreach (ViewCommissionDto commission in DataCollection)
                    {
                        if (commission.CommissionId > 0)
                        {
                            var entity = _mapper.Map<Comm>(commission);
                            entity.Yrmo = $"{SelectedYear.ToString()}{SelectedMonthNumber}";
                            foreach (AgentCommission agentComm in entity.AgentCommissions)
                            {
                                agentComm.Agent = null;
                                _unitOfWork.AgentCommissions.Save(agentComm);
                            }
                            var commissionId = _unitOfWork.Commissions.Save(entity);
                        }
                        else
                        {
                            commission.AgentCommissions = commission.AgentCommissions.Select(agentComm => { agentComm.Agent = null; return agentComm; }).ToList();
                            commission.CommissionId = 0;
                            var entityCommission = _mapper.Map<Comm>(commission);
                            entityCommission.Yrmo = $"{SelectedYear.ToString()}{SelectedMonthNumber}";
                            entityCommission.Commtype = "F";
                            var commissionId = _unitOfWork.Commissions.Add(entityCommission);
                        }
                    }
                    _unitOfWork.Commit();
                    GetCommissions();
                    _notifier.ShowSuccess("Record added/updated successfully");
                }
            }
            catch
            {
                _notifier.ShowError("Error occured while adding/updating record");
            }
        }
        public void Add()
        {
            DataCollection.Add(new ViewCommissionDto() { IsNew = true, IsNotNew = false, CommissionId = --newId });
        }
        public void Delete(object commissionId)
        {
            try
            {
                if (commissionId != null && Convert.ToInt32(commissionId) > 0)
                {
                    var commission = _unitOfWork.Commissions.Find(Convert.ToInt32(commissionId));
                    foreach (var agentComm in commission.AgentCommissions)
                    {
                        _unitOfWork.AgentCommissions.Delete(agentComm);
                    }
                    _unitOfWork.Commissions.Delete(commission);
                    _unitOfWork.Commit();
                }
                DataCollection.Remove(DataCollection.Where(commission => commission.CommissionId == Convert.ToInt32(commissionId)).SingleOrDefault());
                _notifier.ShowSuccess("Record deleted successfully");
            }
            catch
            {
                _notifier.ShowError("Error occured while deleting record");
            }
        }
        public void PolicyDetails(object currentItem)
        {
            if (string.IsNullOrEmpty(((ViewCommissionDto)currentItem).PolicyNumber)) 
            { 
                _notifier.ShowError("Please enter policy number"); 
                return; 
            }
            var policyNumber = ((ViewCommissionDto)currentItem).PolicyNumber;
            var policy = _unitOfWork.Policies.FindByPolicyNumber(policyNumber);
            ViewPolicyDto policyDto;
            if (policy != null)
            {
                policyDto = _mapper.Map<ViewPolicyDto>(policy);
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
                            CompanyName = mappedCurrrentItem.CompanyName.Trim() == "" ? "" : Companies.Where(c => c.FieldCode == mappedCurrrentItem.CompanyName.Trim()).FirstOrDefault().Description,
                            InsuredName = mappedCurrrentItem.InsuredName,
                            CommissionId = mappedCurrrentItem.CommissionId,
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
            else
            {
                _notifier.ShowError($@"Policy number ""{policyNumber}"" does not exist");
            }
        }
        public void Copy(object commissionInput)
        {
            ViewCommissionDto data = commissionInput as ViewCommissionDto;
            List<ViewAgentCommissionDto> agnetCommissions = new List<ViewAgentCommissionDto>();
            data.AgentCommissions.ToList().ForEach(a => {
                agnetCommissions.Add(new ViewAgentCommissionDto
                {
                    Id = a.Id,
                    CommissionId = 0,
                    Commission = a.Commission,
                    Split = a.Split,
                    AgentId = a.AgentId,
                    AgentOrder = a.AgentOrder,
                    CreatedBy = a.CreatedBy.Trim(),
                    CreatedDate = a.CreatedDate,
                    IsDeleted = a.IsDeleted,
                    Agent = a.Agent
                });
            });
            CopiedCommission = new ViewCommissionDto()
            {
                CommissionId = --newId,
                CommissionType = data.CommissionType.Trim(),
                PolicyId = data.PolicyId,
                PolicyNumber = data.PolicyNumber.Trim(),
                PayDate = data.PayDate,
                CompanyName = data.CompanyName.Trim(),
                InsuredName = data.InsuredName.Trim(),
                Renewal = data.Renewal.Trim(),
                AgentCommissions = agnetCommissions,
                TotalAmount = data.TotalAmount,
                YearMonth = data.YearMonth,
                Comment = !string.IsNullOrEmpty(data.Comment) ? data.Comment.Trim() : null
            };

            IsPasteEnabled = true;
        }
        public void Paste(object dataInput)
        {
            ViewCommissionDto data = dataInput as ViewCommissionDto;
            int index = DataCollection.IndexOf(data);
            if (CopiedCommission != null)
            {
                CopiedCommission.AgentCommissions.ToList().ForEach(a => a.Id = 0);
                DataCollection.Insert(index, CopiedCommission);
                CopiedCommission = null;
                IsPasteEnabled = false;
            }
        }

        #region Helper Methods
        private void LoadData()
        {
            GetComboData();
            GetCompanies();
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
        private void GetComboData()
        {
            var combo = _unitOfWork.Combo.All();
            Combo = combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
        }
        private void GetCompanies()
        {
            Companies = Combo.Where(x => x.FieldName.Trim() == "COMPANY").ToList();
        }
        #endregion

        #endregion
    }
}
