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
using ToastNotifications;
using ToastNotifications.Messages;

namespace CMG.Application.ViewModel
{
    public class RenewalsViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        private int newId;
        private readonly Notifier _notifier;
        #endregion Member variables

        #region Constructor
        public RenewalsViewModel(IUnitOfWork unitOfWork, IMapper mapper, Notifier notifier = null)
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

        public bool IsNoRecordFound
        {
            get
            {
                return DataCollection != null && DataCollection.Count == 0;
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

        public ICommand ImportCommand
        {
            get { return CreateCommand(Import); }
        }
        public ICommand SaveCommand
        {
            get { return CreateCommand(Save); }
        }
        public ICommand DeleteCommand
        {
            get { return CreateCommand(Delete); }
        }
        public ICommand AddCommand
        {
            get { return CreateCommand(Add); }
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
            SearchQuery searchQuery = BuildRenewalSearchQuery(year, SelectedMonth);
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
            _notifier.ShowSuccess("Records imported successfully");
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
                    if (isImportEnabled)
                    {
                        foreach (ViewCommissionDto commission in DataCollection)
                        {
                            AddCommission(commission);
                        }
                        IsImportEnabled = false;
                    }
                    else
                    {
                        foreach (ViewCommissionDto commission in DataCollection)
                        {
                            if (commission.CommissionId > 0)
                            {
                                var entity = _mapper.Map<Comm>(commission);
                                entity.Yrmo = entity.Paydate?.ToString("yyyyMM");
                                foreach (AgentCommission agentComm in entity.AgentCommissions)
                                {
                                    agentComm.Agent = null;
                                    _unitOfWork.AgentCommissions.Save(agentComm);
                                }
                                var commissionId = _unitOfWork.Commissions.Save(entity);
                                _unitOfWork.Commit();
                            }
                            else
                            {
                                AddCommission(commission);
                            }
                        }

                    }
                    GetCommissions();
                    _notifier.ShowSuccess("Record added/updated successfully");
                }
            }
            catch
            {
                _notifier.ShowError("Error occured while adding/updating record");
            }
        }
        public void Delete(object commissionId)
        {
            try
            {
                if (IsImportEnabled)
                {
                    DataCollection.Remove(DataCollection.Where(commission => commission.CommissionId == Convert.ToInt32(commissionId)).SingleOrDefault());
                }
                else
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
                        GetCommissions();
                    }
                    else
                    {
                        DataCollection.Remove(DataCollection.Where(commission => commission.CommissionId == Convert.ToInt32(commissionId)).SingleOrDefault());
                    }
                }
                _notifier.ShowSuccess("Record deleted successfully");
            }
            catch
            {
                _notifier.ShowError("Error occured while deleting record");
            }
        }
        public void Add()
        {
            DataCollection.Add(new ViewCommissionDto() { IsNew = true, IsNotNew = false, CommissionId = --newId });
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
            else
            {
                _notifier.ShowError($@"Policy number ""{policyNumber}"" does not exist");
            }
        }
        public void Copy(object commissionInput)
        {
            ViewCommissionDto data = commissionInput as ViewCommissionDto;
            List<ViewAgentCommissionDto> agnetCommissions = new List<ViewAgentCommissionDto>();
            data.AgentCommissions.ToList().ForEach(a => { agnetCommissions.Add(new ViewAgentCommissionDto
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
                                                                                    Agent = a.Agent });
                                                                                });
            CopiedCommission = new ViewCommissionDto() {
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
            if(CopiedCommission != null)
            {
                CopiedCommission.AgentCommissions.ToList().ForEach(a => a.Id = 0);
                DataCollection.Insert(index, CopiedCommission);
                CopiedCommission = null;
                IsPasteEnabled = false;
            }
        }
        private void LoadData()
        {
            GetCommissions();
            GetPolicies();
        }
        private SearchQuery BuildRenewalSearchQuery(int year, string month)
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
            filterBy = new FilterBy();
            filterBy.Property = "Renewal";
            filterBy.Equal = "R";
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
                    commission.CreatedDate = null;
                    commission.CreatedBy = null;
                    commission.TotalAmount = 0.0M;
                    commission.AgentCommissions.Select(comm => { comm.Commission = 0.0M; return comm; }).ToList();
                }
            }
        }
        private void GetPolicies()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).AsEnumerable();
        }
        private void AddCommission(ViewCommissionDto commission)
        {
            commission.AgentCommissions = commission.AgentCommissions.Select(agentComm => { agentComm.Agent = null; return agentComm; }).ToList();
            commission.CommissionId = 0;
            var entityCommission = _mapper.Map<Comm>(commission);
            entityCommission.Yrmo = entityCommission.Paydate?.ToString("yyyyMM");
            var commissionId = _unitOfWork.Commissions.Add(entityCommission);
            _unitOfWork.Commit();
        }
        #endregion Methods
    }
}
