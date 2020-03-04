using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using CMG.Service.Interface;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;
using ToastNotifications;
using ToastNotifications.Messages;
using Microsoft.Extensions.Caching.Memory;
using System.Data;
using CMG.Service;
using static CMG.Common.Enums;

namespace CMG.Application.ViewModel
{
    public class PolicyViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public readonly IDialogService _dialogService;
        public readonly Notifier _notifier;

        private const string comboFieldNamePolicyType = "TYPE";
        private const string comboFieldNameFrequency = "FREQUENCY";
        private const string comboFieldNameStatus = "STATUS";
        private const string comboFieldNameCategory = "CATGRY";
        private const string comboFieldNameCurrency = "CURRENCY";
        List<string> agentCategories = AgentCategories.Split(',').Select(x => x.Trim()).ToList();

        #endregion

        #region Constructor
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, IDialogService dialogService = null, Notifier notifier = null)
            : base(unitOfWork, mapper, memoryCache)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            SelectedViewModel = this;
            LoadData();
        }
        
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper, ViewClientSearchDto selectedClientInput, IMemoryCache memoryCache = null, IDialogService dialogService = null, Notifier notifier = null)
               : base(unitOfWork, mapper, memoryCache)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            SelectedViewModel = this;
            LoadData();
            
            if (selectedClientInput != null)
            {
                SelectedClient = selectedClientInput;
                GetPolicyCollection();
            }
        }
        #endregion Constructor

        #region Properties
        private ObservableCollection<ViewPolicyListDto> _policyCollection;
        public ObservableCollection<ViewPolicyListDto> PolicyCollection
        {
            get { return _policyCollection; }
            set
            {
                _policyCollection = value;
                OnPropertyChanged("PolicyCollection");
                OnPropertyChanged("IsNoRecordFound");
            }
        }
        public bool IsNoRecordFound
        {
            get
            {
                return PolicyCollection != null && PolicyCollection.Count == 0;
            }
        }
        public bool IsBusinessRecordFound
        {
            get
            {
                return BusinessRelationshipCollection != null && BusinessRelationshipCollection.Count == 0;
            }
        }
        public bool IsPersonRecordFound
        {
            get
            {
                return PersonRelationshipCollection != null && PersonRelationshipCollection.Count == 0;
            }
        }
        private ObservableCollection<ViewPolicyIllustrationDto> _policyIllustrationCollection;
        public ObservableCollection<ViewPolicyIllustrationDto> PolicyIllustrationCollection
        {
            get { return _policyIllustrationCollection; }
            set
            {
                _policyIllustrationCollection = value;
                OnPropertyChanged("PolicyIllustrationCollection");
            }
        }

        private List<ViewComboDto> _policyTypeCollection;
        public List<ViewComboDto> PolicyTypeCollection
        {
            get { return _policyTypeCollection; }
            set { _policyTypeCollection = value; }
        }

        private List<ViewComboDto> _frequencyTypeCollection;
        public List<ViewComboDto> FrequencyTypeCollection
        {
            get { return _frequencyTypeCollection; }
            set { _frequencyTypeCollection = value; }
        }

        private List<ViewComboDto> _currencyCollection;
        public List<ViewComboDto> CurrencyCollection
        {
            get { return _currencyCollection; }
            set { _currencyCollection = value; }
        }
        private string _relationCommonName;
        public string RelationCommonName 
        {
            get { return _relationCommonName; } 
            set
            {
                _relationCommonName = value;
                OnPropertyChanged("RelationCommonName");
            }
        }
        private string _relationLastName;
        public string RelationLastName
        {
            get { return _relationLastName; }
            set
            {
                _relationLastName = value;
                OnPropertyChanged("RelationLastName");
            }
        }
        private string _relationFirstName;
        public string RelationFirstName
        {
            get { return _relationFirstName; }
            set
            {
                _relationFirstName = value;
                OnPropertyChanged("RelationFirstName");
            }
        }
        private string _relationEntityType;
        public string RelationEntityType
        {
            get { return _relationEntityType; }
            set
            {
                _relationEntityType = value;
                OnPropertyChanged("RelationEntityType");
            }
        }
        private DateTime? _relationBirthDate;
        public DateTime? RelationBirthDate
        {
            get { return _relationBirthDate; }
            set
            {
                _relationBirthDate = value;
                OnPropertyChanged("RelationBirthDate");
            }
        }
        private string _relationBusinessName;
        public string RelationBusinessName
        {
            get { return _relationBusinessName; }
            set
            {
                _relationBusinessName = value;
                OnPropertyChanged("RelationBusinessName");
            }
        }
        private string _relationBusinessStreet;
        public string RelationBusinessStreet
        {
            get { return _relationBusinessStreet; }
            set
            {
                _relationBusinessStreet = value;
                OnPropertyChanged("RelationBusinessStreet");
            }
        }
        private ObservableCollection<ViewBusinessRelationDto> _businessRelationshipCollection;
        public ObservableCollection<ViewBusinessRelationDto> BusinessRelationshipCollection
        {
            get { return _businessRelationshipCollection; }
            set
            {
                _businessRelationshipCollection = value;
                OnPropertyChanged("BusinessRelationshipCollection");
                OnPropertyChanged("IsBusinessRecordFound");
            }
        }
        private ViewBusinessRelationDto _selectedBusinessRelation;
        public ViewBusinessRelationDto SelectedBusinessRelation
        {
            get { return _selectedBusinessRelation; }
            set
            {
                _selectedBusinessRelation = value;
                OnPropertyChanged("SelectedBusinessRelation");
                IsBusinessLinked = true;
                BusinessRelation = string.Empty;
                SelectedBusinessCategory = null;
            }
        }
        private ObservableCollection<ViewClientSearchDto> _personRelationshipCollection;
        public ObservableCollection<ViewClientSearchDto> PersonRelationshipCollection
        {
            get { return _personRelationshipCollection; }
            set 
            { 
                _personRelationshipCollection = value;
                OnPropertyChanged("PersonRelationshipCollection");
                OnPropertyChanged("IsPersonRecordFound");
            }
        }
        private ViewClientSearchDto _selectedPersonRelation;
        public ViewClientSearchDto SelectedPersonRelation
        {
            get { return _selectedPersonRelation; }
            set
            {
                _selectedPersonRelation = value;
                OnPropertyChanged("SelectedPersonRelation");
                IsPersonLinked = true;
                if (SelectedPersonRelation != null)
                {
                    SelectedPersonName = SelectedPersonRelation.CommonName + ", " + SelectedPersonRelation.LastName;
                }
                PersonRelation = string.Empty;
                SelectedPersonCategory = null;
            }
        }
        private string _personRelation;
        public string PersonRelation
        {
            get
            {
                return _personRelation;
            }
            set
            {
                _personRelation = value;
                OnPropertyChanged("PersonRelation");
            }
        }
        private string _businessRelation;
        public string BusinessRelation
        {
            get
            {
                return _businessRelation;
            }
            set
            {
                _businessRelation = value;
                OnPropertyChanged("BusinessRelation");
            }
        }

        private ViewComboDto _selectedPersonCategory;
        public ViewComboDto SelectedPersonCategory
        {
            get { return _selectedPersonCategory; }
            set
            {
                _selectedPersonCategory = value;
                OnPropertyChanged("SelectedPersonCategory");
            }
        }

        private ViewComboDto _selectedBusinessCategory;
        public ViewComboDto SelectedBusinessCategory
        {
            get { return _selectedBusinessCategory; }
            set
            {
                _selectedBusinessCategory = value;
                OnPropertyChanged("SelectedBusinessCategory");
            }
        }
        private bool _isPersonLinked;
        public bool IsPersonLinked
        {
            get
            {
                return _isPersonLinked;
            }
            set
            {
                _isPersonLinked = value;
                OnPropertyChanged("IsPersonLinked");
            }
        }
        private string _selectedPersopnName;
        public string SelectedPersonName 
        {
            get { return _selectedPersopnName; }
            set
            {
                _selectedPersopnName = value;
                OnPropertyChanged("SelectedPersonName");
            }
        }

        private bool _isBusinessLinked;
        public bool IsBusinessLinked
        {
            get
            {
                return _isBusinessLinked;
            }
            set
            {
                _isBusinessLinked = value;
                OnPropertyChanged("IsBusinessLinked");
            }
        }
        private List<ViewComboDto> _statusTypeCollection;
        public List<ViewComboDto> StatusTypeCollection
        {
            get { return _statusTypeCollection; }
            set { _statusTypeCollection = value; }
        }
        private List<ViewComboDto> _categoryCollection;
        public List<ViewComboDto> CategoryCollection
        {
            get { return _categoryCollection; }
            set { _categoryCollection = value; }
        }
        private List<ViewAgentDto> _agentCollection;
        public List<ViewAgentDto> AgentCollection
        {
            get { return _agentCollection; }
            set
            {
                _agentCollection = value;
                OnPropertyChanged("AgentCollection");
            }
        }
        private ViewPolicyListDto _selectedPolicy;
        public ViewPolicyListDto SelectedPolicy
        {
            get { return _selectedPolicy; }
            set
            {
                _selectedPolicy = value;
                OnPropertyChanged("IsAddRelationshipVisible");
                OnPropertyChanged("SelectedPolicy");
                GetSelectedPolicyDropdownData();
                CancelPolicyNotes();
                CancelGeneralNotes();
            }
        }
        private ViewClientSearchDto _selectedClient;
        public ViewClientSearchDto SelectedClient
        {
            get { return _selectedClient; }
            set
            {
                _selectedClient = value;
                OnPropertyChanged("SelectedClient");
                OnPropertyChanged("IsClientSelected");
                OnPropertyChanged("IsPolicyDetailVisible");
                if (SelectedClient != null)
                {
                    GetPolicyCollection();
                }
            }
        }
        public bool IsPolicyDetailVisible
        {
            get { return SelectedClient == null ? true : false; }
        }
        public bool IsClientSelected
        {
            get { return SelectedClient != null ? true : false; }
        }
        private ViewPolicyListDto _savedPolicyDetail;
        public ViewPolicyListDto SavedPolicyDetail
        {
            get { return _savedPolicyDetail; }
            set
            {
                _savedPolicyDetail = value;
                OnPropertyChanged("SavedPolicyDetail");
            }
        }
        private ViewComboDto selectedPolicyStatus;
        public ViewComboDto SelectedPolicyStatus
        {
            get { return selectedPolicyStatus; }
            set
            {
                selectedPolicyStatus = value;
                OnPropertyChanged("SelectedPolicyStatus");
            }
        }

        private ViewComboDto selectedPolicyCurrency;
        public ViewComboDto SelectedPolicyCurrency
        {
            get { return selectedPolicyCurrency; }
            set
            {
                selectedPolicyCurrency = value;
                OnPropertyChanged("SelectedPolicyCurrency");
            }
        }

        private ViewComboDto selectedPolicyFrequencyType;
        public ViewComboDto SelectedPolicyFrequencyType
        {
            get { return selectedPolicyFrequencyType; }
            set
            {
                selectedPolicyFrequencyType = value;
                OnPropertyChanged("SelectedPolicyFrequencyType");
            }
        }
        private ViewPolicyIllustrationDto _selectedIllustration;

        private ViewComboDto selectedPolicyType;
        public ViewComboDto SelectedPolicyType
        {
            get { return selectedPolicyType; }
            set
            {
                selectedPolicyType = value;
                OnPropertyChanged("SelectedPolicyType");
            }
        }

        private ViewComboDto selectedPolicyCompany;
        public ViewComboDto SelectedPolicyCompany
        {
            get { return selectedPolicyCompany; }
            set
            {
                selectedPolicyCompany = value;
                OnPropertyChanged("SelectedPolicyCompany");
            }
        }
        public ViewPolicyIllustrationDto SelectedIllustration
        {
            get { return _selectedIllustration; }
            set
            {
                _selectedIllustration = value;
                OnPropertyChanged("SelectedIllustration");
                CancelClientNotes();
                CancelInternalNotes();
            }
        }
        private bool _isGeneralNotesEditVisible = false;
        public bool IsGeneralNotesEditVisible
        {
            get { return _isGeneralNotesEditVisible; }
            set { _isGeneralNotesEditVisible = value; OnPropertyChanged("IsGeneralNotesEditVisible"); }
        }

        private bool _isGeneralNotesSaveVisible = false;
        public bool IsGeneralNotesSaveVisible
        {
            get { return _isGeneralNotesSaveVisible; }
            set { _isGeneralNotesSaveVisible = value; OnPropertyChanged("IsGeneralNotesSaveVisible"); }
        }
        private bool _isPolicyNotesEditVisible = false;
        public bool IsPolicyNotesEditVisible
        {
            get { return _isPolicyNotesEditVisible; }
            set { _isPolicyNotesEditVisible = value; OnPropertyChanged("IsPolicyNotesEditVisible"); }
        }

        private bool _isPolicyNotesSaveVisible = false;
        public bool IsPolicyNotesSaveVisible
        {
            get { return _isPolicyNotesSaveVisible; }
            set { _isPolicyNotesSaveVisible = value; OnPropertyChanged("IsPolicyNotesSaveVisible"); }
        }
        private bool _isClientNotesEditVisible = false;
        public bool IsClientNotesEditVisible
        {
            get { return _isClientNotesEditVisible; }
            set { _isClientNotesEditVisible = value; OnPropertyChanged("IsClientNotesEditVisible"); }
        }

        private bool _isClientNotesSaveVisible = false;
        public bool IsClientNotesSaveVisible
        {
            get { return _isClientNotesSaveVisible; }
            set { _isClientNotesSaveVisible = value; OnPropertyChanged("IsClientNotesSaveVisible"); }
        }
        private bool _isInternalNotesEditVisible = false;
        public bool IsInternalNotesEditVisible
        {
            get { return _isInternalNotesEditVisible; }
            set { _isInternalNotesEditVisible = value; OnPropertyChanged("IsInternalNotesEditVisible"); }
        }

        private bool _isInternalNotesSaveVisible = false;
        public bool IsInternalNotesSaveVisible
        {
            get { return _isInternalNotesSaveVisible; }
            set { _isInternalNotesSaveVisible = value; OnPropertyChanged("IsInternalNotesSaveVisible"); }
        }

        public bool IsAddRelationshipVisible
        {
            get
            {
                return SelectedPolicy != null;
            }
        }
        private DataTable policyTable;
        public DataTable PolicyTable
        {
            get { return policyTable; }
            set
            {
                policyTable = value;
                OnPropertyChanged("PolicyTable");
            }
        }

        private string _personCommonName;
        public string PersonCommonName
        {
            get { return _personCommonName; }
            set
            {
                _personCommonName = value;
                OnPropertyChanged("PersonCommonName");
            }
        }

        private string _personLastName;
        public string PersonLastName
        {
            get { return _personLastName; }
            set
            {
                _personLastName = value;
                OnPropertyChanged("PersonLastName");
            }
        }
        private string _personFirstName;
        public string PersonFirstName
        {
            get { return _personFirstName; }
            set 
            { 
                _personFirstName = value;
                OnPropertyChanged("PersonFirstName");
            }
        }


        private ObservableCollection<ViewClientSearchDto> _clientCollection;
        public ObservableCollection<ViewClientSearchDto> ClientCollection
        {
            get { return _clientCollection; }
            set
            {
                _clientCollection = value;
                OnPropertyChanged("ClientCollection");
                OnPropertyChanged("IsPaginationVisible");
                OnPropertyChanged("IsNoClientRecord");
            }
        }

        #region command properties
        public ICommand ViewIllustrationCommand
        {
            get { return CreateCommand(ViewIllustration); }
        }
        public ICommand SaveIllustrationCommand
        {
            get { return CreateCommand(SaveIllustration); }
        }
        public ICommand SavePolicyCommand
        {
            get { return CreateCommand(SavePolicy); }
        }
        public ICommand CancelPolicyCommand
        {
            get { return CreateCommand(CancelPolicy); }
        }
        public ICommand EditGeneralNotesCommand
        {
            get { return CreateCommand(EditGeneralNotes); }
        }
        public ICommand SaveGeneralNotesCommand
        {
            get { return CreateCommand(SaveGeneralNotes); }
        }
        public ICommand SearchPeopleRelationshipCommand
        {
            get { return CreateCommand(SearchPeopleRelationship); }
        }
        public ICommand SearchBusinessRelationshipCommand
        {
            get { return CreateCommand(SearchBusinessRelationship); }
        }
        public ICommand AddRelationshipCommand
        {
            get { return CreateCommand(AddRelationship); }
        }
        public ICommand SavePeopleRelationshipCommand
        {
            get { return CreateCommand(SavePeopleRelationship); }
        }
        public ICommand SaveBusinessCommand
        {
            get { return CreateCommand(SaveBusiness); }
        }
        
        public ICommand DeleteRelationshipCommand
        {
            get { return CreateCommand(DeleteRelationship); }
        }
        public ICommand CancelGeneralNotesCommand
        {
            get { return CreateCommand(CancelGeneralNotes); }
        }
        public ICommand EditPolicyNotesCommand
        {
            get { return CreateCommand(EditPolicyNotes); }
        }
        public ICommand SavePolicyNotesCommand
        {
            get { return CreateCommand(SavePolicyNotes); }
        }
        public ICommand CancelPolicyNotesCommand
        {
            get { return CreateCommand(CancelPolicyNotes); }
        }
        public ICommand EditClientNotesCommand
        {
            get { return CreateCommand(EditClientNotes); }
        }
        public ICommand SaveClientNotesCommand
        {
            get { return CreateCommand(SaveClientNotes); }
        }
        public ICommand CancelClientNotesCommand
        {
            get { return CreateCommand(CancelClientNotes); }
        }
        public ICommand EditInternalNotesCommand
        {
            get { return CreateCommand(EditInternalNotes); }
        }
        public ICommand SaveInternalNotesCommand
        {
            get { return CreateCommand(SaveInternalNotes); }
        }
        public ICommand CancelInternalNotesCommand
        {
            get { return CreateCommand(CancelInternalNotes); }
        }
        public ICommand DividentScaleFilterCommand
        {
            get { return CreateCommand(DividentScaleFilter); }
        }        
        #endregion command properties
        #endregion Properties

        #region Methods
        private void GetSelectedPolicyDropdownData()
        {
            if (SelectedPolicy != null)
            {
                SelectedPolicyStatus = StatusTypeCollection.Where(x => x.Description.Trim() == SelectedPolicy.Status.Trim()).FirstOrDefault();
                SelectedPolicyFrequencyType = FrequencyTypeCollection.Where(x => x.Description.Trim() == SelectedPolicy.Frequency.Trim()).FirstOrDefault();
                SelectedPolicyType = PolicyTypeCollection.Where(x => x.Description.Trim() == SelectedPolicy.Type.Trim()).FirstOrDefault();
                SelectedPolicyCompany = CompanyCollection.Where(x => x.Description.Trim() == SelectedPolicy.CompanyName.Trim()).FirstOrDefault();
                SelectedPolicyCurrency = CurrencyCollection.Where(x => x.Description.Trim() == SelectedPolicy.Currency.Trim()).FirstOrDefault();
            }
        }
        private new void GetComboData()
        {
            PolicyTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePolicyType).ToList();
            FrequencyTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameFrequency).ToList();
            StatusTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameStatus).ToList();
            CategoryCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCategory
                                            && !agentCategories.Contains(x.FieldCode)).ToList();
            CurrencyCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCurrency).ToList();
        }
        private void GetAgents()
        {
            var agents = _unitOfWork.Agents.All();
            AgentCollection = agents.Select(a => _mapper.Map<ViewAgentDto>(a)).ToList();
        }
        private new void LoadData()
        {
            GetComboData();
            GetAgents();
        }        
        private void BuildFilterByContains(string property, string value, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.Contains = value;
            searchBy.Add(filterBy);
        }
        private void BuildFilterByEquals(string property, string value, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.Equal = value;
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
        private void GetPolicyCollection()
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            BuildFilterByEquals("keynump", SelectedClient.Keynump.ToString(), searchBy);
            searchQuery.FilterBy = searchBy;

            var dataSearchBy = _unitOfWork.Policies.Find(searchQuery);

            var policyCollection = dataSearchBy.Result.Select(r => _mapper.Map<ViewPolicyListDto>(r));

            PolicyCollection = new ObservableCollection<ViewPolicyListDto>(policyCollection.Select(x =>
            {
                x.Type = string.IsNullOrEmpty(x.Type.Trim()) ? "" : PolicyTypeCollection.Where(c => c.FieldCode == x.Type.Trim()).FirstOrDefault()?.Description;
                x.Frequency = string.IsNullOrEmpty(x.Frequency.Trim()) ? "" : FrequencyTypeCollection.Where(c => c.FieldCode == x.Frequency.Trim()).FirstOrDefault()?.Description;
                x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : StatusTypeCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault()?.Description;
                x.CompanyName = string.IsNullOrEmpty(x.CompanyName.Trim()) ? "" : CompanyCollection.Where(c => c.FieldCode == x.CompanyName.Trim()).FirstOrDefault()?.Description;
                x.Relationships = new ObservableCollection<ViewRelationshipDto>(x.Relationships.Select(
                    p =>
                    {
                        p.Category = string.IsNullOrEmpty(p.Category.Trim()) ? "" : CategoryCollection.Where(c => c.FieldCode == p.Category.Trim()).FirstOrDefault()?.Description;
                        return p;
                    }
                ).ToList());
                x.PolicyAgents = x.PolicyAgents.Select(
                        a =>
                        {
                            var agent = AgentCollection.Where(agent => agent.Keynump == a.PeopleOrBusinessId).FirstOrDefault();
                            if(agent != null)
                            {
                                a.Agent = agent;
                            }
                            else
                            {
                                string[] agentName = a.Name.Split(" ");
                                agentName = agentName.Length > 0 ? agentName[0].Split(",") : default;
                                a.Agent = new ViewAgentDto() { FirstName = agentName.Length > 0 ? agentName[0] : string.Empty, Color = "#D3D3D3" };
                            }
                            return a;
                        }
                    ).ToList();
                return x;
            }).OrderByDescending(o => o.PolicyDate));

            if (PolicyCollection.Count > 0)
            {
                if (SavedPolicyDetail != null
                    && PolicyCollection.Where(x => x.Id == SavedPolicyDetail.Id).FirstOrDefault() != null)
                {
                    SelectedPolicy = PolicyCollection.Where(x => x.Id == SavedPolicyDetail.Id).FirstOrDefault();
                }
            }
        }
        private void ViewIllustration(object dividentScale)
        {
            if (SelectedPolicy != null)
            {
                var policyIllustrations = _unitOfWork.PolicyIllustration.GetPolicyIllustration(SelectedPolicy.Id, Convert.ToInt32(dividentScale));
                PolicyIllustrationCollection = new ObservableCollection<ViewPolicyIllustrationDto>(policyIllustrations.Select(r => _mapper.Map<ViewPolicyIllustrationDto>(r)));
                if (PolicyIllustrationCollection.Count > 0)
                {
                    SelectedIllustration = PolicyIllustrationCollection[0];
                }
            }
        }
        private void SaveIllustration()
        {
            try
            {
                if (SelectedIllustration != null && ValidateIllustration())
                {
                    var entity = _mapper.Map<PolIll>(SelectedIllustration);
                    _unitOfWork.PolicyIllustration.Save(entity);
                    _unitOfWork.Commit();
                    var updatedEntity = _unitOfWork.PolicyIllustration.GetById(entity.Id);
                    SelectedIllustration = _mapper.Map<ViewPolicyIllustrationDto>(updatedEntity);
                    ViewIllustration(0);
                    _notifier.ShowSuccess("Illustration updated successfully");
                }
            }
            catch
            {
                _notifier.ShowError("Error occured while updating policy illustration");
            }
        }
        private void CancelPolicy()
        {
            if (SelectedPolicy != null)
            {
                SavedPolicyDetail = SelectedPolicy;
            }
            if (SelectedClient != null)
            {
                GetPolicyCollection();
            }
        }
        private void SavePolicy()
        {
            if (SelectedPolicy != null
                && IsValidPolicy())
            {
                var originalEntity = _unitOfWork.Policies.GetById(SelectedPolicy.Id);
                var entity = _mapper.Map(SelectedPolicy, originalEntity);
                entity.PolicyAgent = null;
                entity.PolicyAgents = null;
                entity.PeoplePolicys = null;
                entity.BusinessPolicys = null;
                entity.Status = SelectedPolicyStatus != null ? SelectedPolicyStatus.FieldCode.Trim() : string.Empty;
                entity.Frequency = SelectedPolicyFrequencyType != null ? SelectedPolicyFrequencyType.FieldCode.Trim() : string.Empty;
                entity.Type = SelectedPolicyType != null ? SelectedPolicyType.FieldCode.Trim() : string.Empty;
                entity.Company = SelectedPolicyCompany != null ? SelectedPolicyCompany.FieldCode.Trim() : string.Empty;
                entity.Currency = SelectedPolicyCurrency != null ? SelectedPolicyCurrency.FieldCode.Trim() : string.Empty;
                entity.IssueAge = SelectedPolicy.Age.ToString();

                _unitOfWork.Policies.Save(entity);
                _unitOfWork.Commit();

                SelectedPolicy = _mapper.Map<ViewPolicyListDto>(originalEntity);
                SavedPolicyDetail = SelectedPolicy;
                GetPolicyCollection();
                _notifier.ShowSuccess("Policy updated successfully");
            }
        }
        private bool ValidateIllustration()
        {
            if (!decimal.TryParse(SelectedIllustration.AnnualDepositActual.ToString(), out decimal ada))
            {
                _notifier.ShowError("Actual annual deposit value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.CashValueActual.ToString(), out decimal cva))
            {
                _notifier.ShowError("Actual cash value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.DeathBenefitActual.ToString(), out decimal dba))
            {
                _notifier.ShowError("Actual Death Benefit value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.AdjustedCostBaseActual.ToString(), out decimal acba))
            {
                _notifier.ShowError("Actual adjusted cost base value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.NCPIActual.ToString(), out decimal ncpia))
            {
                _notifier.ShowError("Actual NCPI value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.AnnualDepositReprojection.ToString(), out decimal adr))
            {
                _notifier.ShowError("Reprojection annual deposit value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.CashValueReprojection.ToString(), out decimal cvr))
            {
                _notifier.ShowError("Reprojection cash value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.DeathBenefitReprojection.ToString(), out decimal dbr))
            {
                _notifier.ShowError("Reprojection Death Benefit value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.AdjustedCostBaseReprojection.ToString(), out decimal acbr))
            {
                _notifier.ShowError("Reprojection adjusted cost base value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.NCPIReprojection.ToString(), out decimal ncpir))
            {
                _notifier.ShowError("Reprojection NCPI value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.Increasingpay.ToString(), out decimal increasingPay))
            {
                _notifier.ShowError("Increasing Pay value is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedIllustration.Lifepay.ToString(), out decimal lifePay))
            {
                _notifier.ShowError("Life Pay value is invalid");
                return false;
            }
            return true;
        }
        private bool IsValidPolicy()
        {
            DateTime date = new DateTime();
            if (SelectedPolicyCompany == null || (SelectedPolicyCompany != null && SelectedPolicyCompany.Id == 0))
            {
                _notifier.ShowError("Please select company name");
                return false;
            }
            if (!decimal.TryParse(SelectedPolicy.FaceAmount.ToString(), out decimal faceAmount))
            {
                _notifier.ShowError("Faceamount is invalid");
                return false;
            }
            if (!DateTime.TryParse(SelectedPolicy.PolicyDate.ToString(), out DateTime policyDate)
                || policyDate == date)
            {
                _notifier.ShowError("Policy date is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicy.PlanCode.Trim()))
            {
                _notifier.ShowError("Plan code is invalid");
                return false;
            }
            if (!decimal.TryParse(SelectedPolicy.Payment.ToString(), out decimal payment))
            {
                _notifier.ShowError("Payment is invalid");
                return false;
            }
            if(SelectedPolicy.PlacedOn != null 
                &&  !DateTime.TryParse(SelectedPolicy.PlacedOn.ToString(), out DateTime placedOn))
            {
                _notifier.ShowError("Placement date is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicy.Rating.Trim()))
            {
                _notifier.ShowError("Rating is invalid");
                return false;
            }
            if (SelectedPolicyCurrency == null
                || (SelectedPolicyCurrency != null
                    && string.IsNullOrEmpty(SelectedPolicyCurrency.Description.Trim())) )
            {
                _notifier.ShowError("Currency is invalid");
                return false;
            }
            if (SelectedPolicy.ReprojectedOn != null 
                && !DateTime.TryParse(SelectedPolicy.ReprojectedOn.ToString(), out DateTime reprojectedDate))
            {
                _notifier.ShowError("Reprojection date is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicy.Class.Trim()))
            {
                _notifier.ShowError("Class is invalid");
                return false;
            }
            if (SelectedPolicyStatus == null
                || (SelectedPolicyStatus != null
                    && string.IsNullOrEmpty(SelectedPolicyStatus.Description.Trim())) )
            {
                _notifier.ShowError("Policy status is invalid");
                return false;
            }
            if (SelectedPolicyFrequencyType == null
                || (SelectedPolicyFrequencyType != null
                    && string.IsNullOrEmpty(SelectedPolicyFrequencyType.Description.Trim())) )
            {
                _notifier.ShowError("Frequency type is invalid");
                return false;
            }
            if (!int.TryParse(SelectedPolicy.Age.ToString(), out int age))
            {
                _notifier.ShowError("Age is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicy.Type.Trim()))
            {
                _notifier.ShowError("Policy type is invalid");
                return false;
            }
            return true;
        }
        private void EditGeneralNotes()
        {
            IsGeneralNotesEditVisible = false;
            IsGeneralNotesSaveVisible = true;
        }
        private void SaveGeneralNotes()
        {
            try
            {
                IsGeneralNotesEditVisible = true;
                IsGeneralNotesSaveVisible = false;
                if(SelectedClient != null)
                {
                    var entity = _unitOfWork.People.GetById(SelectedClient.Keynump);
                    entity.Pnotes = SelectedClient.GeneralNotes;
                    _unitOfWork.People.Save(entity);
                    _unitOfWork.Commit();
                    _notifier.ShowSuccess("General Notes updated successfully");
                }
            }
            catch
            {
                _notifier.ShowError("Error occured while updating general notes");
            }
        }
        private void DeleteRelationship(object inputParameter)
        {
            SavedPolicyDetail = SelectedPolicy;
            var result = _dialogService.ShowMessageBox("Are you sure you want to delete the record?");
            if (result == DialogServiceLibrary.MessageBoxResult.Yes)
            {
                if (inputParameter != null)
                {
                    ViewRelationshipDto selectedRelationship = SelectedPolicy.Relationships.Where(x => x.RelationshipId == (int)inputParameter).FirstOrDefault();
                    if (selectedRelationship.IsBusiness)
                    {
                        var entity = _unitOfWork.BusinessPolicy.GetById(selectedRelationship.RelationshipId);
                        entity.Del = true;
                        _unitOfWork.BusinessPolicy.Save(entity);
                        _unitOfWork.Commit();
                        GetPolicyCollection();
                    }
                    else
                    {
                        var entity = _unitOfWork.PeoplePolicy.GetById(selectedRelationship.RelationshipId);
                        entity.Del = true;
                        _unitOfWork.PeoplePolicy.Save(entity);
                        _unitOfWork.Commit();
                        var deletedPerson = ClientCollection.Where(x => x.Keynump == selectedRelationship.PeopleOrBusinessId).FirstOrDefault();
                        ClientCollection.Remove(deletedPerson);
                        if (SelectedClient == null)
                        {
                            SelectedClient = ClientCollection[0];
                        }
                        else
                        {
                            GetPolicyCollection();
                        }
                    }
                }
            }
        }
        private void SearchPeopleRelationship()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            if((searchQuery.FilterBy?.Count ?? 0) > 0)
            {
                var people = _unitOfWork.People.Find(searchQuery);
                var dataCollection = new ObservableCollection<ViewClientSearchDto>(people.Result.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());
                PersonRelationshipCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(x =>
                {
                    x.ClientType = string.IsNullOrEmpty(x.ClientType.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.ClientType.Trim()).FirstOrDefault()?.Description;
                    return x;
                }));
            }
        }
        private void SearchBusinessRelationship()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            if ((searchQuery.FilterBy?.Count ?? 0) > 0)
            {
                var business = _unitOfWork.Business.Find(searchQuery);
                var dataCollection = new ObservableCollection<ViewBusinessRelationDto>(business.Result.Select(r => _mapper.Map<ViewBusinessRelationDto>(r)).ToList());
                BusinessRelationshipCollection = new ObservableCollection<ViewBusinessRelationDto>(dataCollection.Select(r => _mapper.Map<ViewBusinessRelationDto>(r)).ToList());
            }
        }
        private SearchQuery BuildSearchQuery()
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            if (!string.IsNullOrEmpty(RelationCommonName))
            {
                BuildFilterByContains("CommonName", RelationCommonName, searchBy);
            }
            if (!string.IsNullOrEmpty(RelationLastName))
            {
                BuildFilterByContains("LastName", RelationLastName, searchBy);
            }
            if (!string.IsNullOrEmpty(RelationFirstName))
            {
                BuildFilterByContains("FirstName", RelationFirstName, searchBy);
            }
            if (!string.IsNullOrEmpty(RelationEntityType))
            {
                var entityTypeCode = ClientTypeCollection.Where(c => c.Description.ToLower() == RelationEntityType.Trim().ToLower()).FirstOrDefault()?.FieldCode;
                if (!string.IsNullOrEmpty(entityTypeCode))
                {
                    BuildFilterByEquals("EntityType", entityTypeCode.Trim(), searchBy);
                }
            }
            if (RelationBirthDate != null && RelationBirthDate != new DateTime())
            {
                BuildFilterByRange("PolicyDate", FromPolicyDate.Value.ToShortDateString(), ToPolicyDate.Value.ToShortDateString(), searchBy);
            }
            if (!string.IsNullOrEmpty(RelationBusinessName))
            {
                BuildFilterByContains("BusinessName", RelationBusinessName, searchBy);
            }
            if (!string.IsNullOrEmpty(RelationBusinessStreet))
            {
                BuildFilterByContains("BusinessAddress", RelationBusinessStreet, searchBy);
            }
            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }
        private void AddRelationship()
        {
            var peopleCollection = _unitOfWork.PeopleRelation.GetById(SelectedClient.Keynump);
            var dataCollection = new ObservableCollection<ViewClientSearchDto>(peopleCollection.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());
            
            PersonRelationshipCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(x => 
            { 
                x.ClientType = string.IsNullOrEmpty(x.ClientType.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.ClientType.Trim()).FirstOrDefault()?.Description;
                return x;
            }));

            var businessCollection = _unitOfWork.BusinessRelation.GetById(SelectedClient.Keynump);
            BusinessRelationshipCollection = new ObservableCollection<ViewBusinessRelationDto>(businessCollection.Select(r => _mapper.Map<ViewBusinessRelationDto>(r)).ToList());
        }
        private void SavePeopleRelationship()
        {
            var entity = _mapper.Map<PeoplePolicys>(SelectedPersonRelation);
            entity.Islinked = IsPersonLinked;
            entity.Hname = SelectedPersonName;
            entity.Catgry = SelectedPersonCategory != null ? SelectedPersonCategory.FieldCode.Trim() : string.Empty;
            entity.Keynumo = SelectedPolicy.Id;
            entity.Keynuml = _unitOfWork.PeoplePolicy.GetMaxKeynuml() + 1;
            entity.Relatn = PersonRelation;
            entity.Bus = false;
            entity.Del = false;

            _unitOfWork.PeoplePolicy.Add(entity);
            _unitOfWork.Commit();
            _notifier.ShowSuccess("Added successfully");
            
            SavedPolicyDetail = SelectedPolicy;
            GetPolicyCollection();
            var personAdded = _unitOfWork.People.GetById(SelectedPersonRelation.Keynump);
            ClientCollection.Add(_mapper.Map<ViewClientSearchDto>(personAdded));
            ClientCollection = new ObservableCollection<ViewClientSearchDto>(ClientCollection.OrderBy(x => x.CommonName).OrderBy(x => x.LastName).OrderBy(x => x.FirstName));
        }
        private void SaveBusiness()
        {
            var entity = _mapper.Map<BusinessPolicys>(SelectedBusinessRelation);
            entity.Islinked = IsBusinessLinked;
            entity.Hname = SelectedBusinessRelation.BusinessName;
            entity.Catgry = SelectedBusinessCategory != null ? SelectedBusinessCategory.FieldCode.Trim() : string.Empty;
            entity.Keynumo = SelectedPolicy.Id;
            entity.Keynum = _unitOfWork.BusinessPolicy.GetMaxKeynum() + 1;
            entity.Relatn = BusinessRelation;
            entity.Bus = true;
            entity.Del = false;

            _unitOfWork.BusinessPolicy.Add(entity);
            _unitOfWork.Commit();
            _notifier.ShowSuccess("Added successfully");
            SavedPolicyDetail = SelectedPolicy;
            GetPolicyCollection();
        }
        private void CancelGeneralNotes()
        {
            IsGeneralNotesEditVisible = true;
            IsGeneralNotesSaveVisible = false;
            var originalClient = _unitOfWork.People.GetById(SelectedClient?.Keynump);
            if (originalClient != null && SelectedClient != null)
                SelectedClient.GeneralNotes = originalClient.Pnotes;
            OnPropertyChanged("SelectedClient");
        }
        private void EditPolicyNotes()
        {
            IsPolicyNotesEditVisible = false;
            IsPolicyNotesSaveVisible = true;
        }
        private void SavePolicyNotes()
        {
            try
            {
                IsPolicyNotesEditVisible = true;
                IsPolicyNotesSaveVisible = false;
                SaveNotes("Policy");
            }
            catch
            {
                _notifier.ShowError("Error occured while updating policy notes");
            }

        }
        private void CancelPolicyNotes()
        {
            IsPolicyNotesEditVisible = true;
            IsPolicyNotesSaveVisible = false;
            var originalPolicy = _unitOfWork.Policies.GetById(SelectedPolicy?.Id);
            if (originalPolicy != null)
                SelectedPolicy.PolicyNotes = originalPolicy.Comment;
            OnPropertyChanged("SelectedPolicy");
        }
        private void EditClientNotes()
        {
            IsClientNotesEditVisible = false;
            IsClientNotesSaveVisible = true;
        }
        private void SaveClientNotes()
        {
            try
            {
                IsClientNotesEditVisible = true;
                IsClientNotesSaveVisible = false;
                SaveNotes("Client");
            }
            catch
            {
                _notifier.ShowError("Error occured while updating policy notes");
            }

        }
        private void CancelClientNotes()
        {
            IsClientNotesEditVisible = true;
            IsClientNotesSaveVisible = false;
            var originalPolicy = _unitOfWork.Policies.GetById(SelectedPolicy?.Id);
            if (originalPolicy != null)
                SelectedPolicy.ClientNotes = originalPolicy.NoteCli;
            OnPropertyChanged("SelectedPolicy");
        }
        private void EditInternalNotes()
        {
            IsInternalNotesEditVisible = false;
            IsInternalNotesSaveVisible = true;
        }
        private void SaveInternalNotes()
        {
            try
            {
                IsInternalNotesEditVisible = true;
                IsInternalNotesSaveVisible = false;
                SaveNotes("Internal");
            }
            catch
            {
                _notifier.ShowError("Error occured while updating policy notes");
            }

        }
        private void CancelInternalNotes()
        {
            IsInternalNotesEditVisible = true;
            IsInternalNotesSaveVisible = false;
            var originalPolicy = _unitOfWork.Policies.GetById(SelectedPolicy?.Id);
            if (originalPolicy != null)
                SelectedPolicy.InternalNotes = originalPolicy.NoteInt;
            OnPropertyChanged("SelectedPolicy");
        }
        private void SaveNotes(string noteType)
        {
            try
            {
                if (SelectedPolicy != null)
                {
                    var entity = _unitOfWork.Policies.GetById(SelectedPolicy.Id);
                    if(noteType == "Client")
                        entity.NoteCli = SelectedPolicy.ClientNotes;
                    else if(noteType == "Policy")
                        entity.Comment = SelectedPolicy.PolicyNotes;
                    else if(noteType == "Internal")
                        entity.NoteInt = SelectedPolicy.InternalNotes;
                    _unitOfWork.Policies.Save(entity);
                    _unitOfWork.Commit();
                    _notifier.ShowSuccess($"{noteType} Notes updated successfully");
                }
            }
            catch
            {
                throw;
            }
        }
        private void DividentScaleFilter(object isDividentScale)
        {
            if (Convert.ToBoolean(isDividentScale))
            {
                ViewIllustration(1);
            }
            else
            {
                ViewIllustration(0);
            }
        }
        public ObservableCollection<ViewPolicyListDto> ReorderColumns(bool isAddColumn, string newColumnName, int columnIndex)
        {
            if(PolicyCollection!= null)
            {
                switch(newColumnName)
                {
                    case "Class":
                        if (!PolicyCollection.Any(x => x.PolicyNotes != null))
                        {
                            for(int i = 0; i < PolicyCollection.Count(); i++)
                            {
                                PolicyCollection[i].PolicyNotes = PolicyCollection[i].PolicyNotes;

                            }
                        }
                        break;
                    default:
                        break;
                }
            }
            return PolicyCollection;
        }
        #endregion Methods
    }
}
