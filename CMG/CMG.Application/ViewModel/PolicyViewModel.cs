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

namespace CMG.Application.ViewModel
{
    public class PolicyViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public readonly IDialogService _dialogService;
        private readonly Notifier _notifier;

        private const string comboFieldNameClientType = "CLIENTTYP";
        private const string comboFieldNamePolicyType = "TYPE";
        private const string comboFieldNameFrequency = "FREQUENCY";
        private const string comboFieldNameStatus = "STATUS";
        private const string comboFieldNameCompany = "COMPANY";
        private const string comboFieldNamePStatus = "PSTATUS";
        private const string comboFieldNameSVCType = "SVC_TYPE";
        private const string comboFieldNameCategory = "CATGRY";
        private const string comboFieldNameCurrency = "CURRENCY";
        #endregion

        #region Constructor
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper, IDialogService dialogService = null, Notifier notifier = null)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            LoadData();
        }
        
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper, ViewClientSearchDto selectedClientInput)
               : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            LoadData();

            if (selectedClientInput != null)
            {
                PolicySelectedClient = selectedClientInput;
                GetPolicyCollection();
            }
        }
        #endregion Constructor

        #region Properties
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

        private List<ViewComboDto> _combo;
        public List<ViewComboDto> Combo
        {
            get { return _combo; }
            set { _combo = value; }
        }

        private List<ViewComboDto> _clientTypeCollection;
        public List<ViewComboDto> ClientTypeCollection
        {
            get { return _clientTypeCollection; }
            set { _clientTypeCollection = value; }
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

        private List<string> _entityTypes;
        public List<string> EntityTypes
        {
            get { return _entityTypes; }
            set
            {
                _entityTypes = value;
                OnPropertyChanged("EntityTypes");
            }
        }

        private ViewClientSearchDto _policySelectedClient;
        public ViewClientSearchDto PolicySelectedClient
        {
            get { return _policySelectedClient; }
            set
            {
                _policySelectedClient = value;
                OnPropertyChanged("PolicySelectedClient");
            }
        }

        private ViewPolicyListDto _selectedPolicy;
        public ViewPolicyListDto SelectedPolicy
        {
            get { return _selectedPolicy; }
            set
            {
                _selectedPolicy = value;
                OnPropertyChanged("SelectedPolicy");
                GetSelectedPolicyDropdownData();
                CancelPolicyNotes();
            }
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
        private void GetComboData()
        {
            var combo = _unitOfWork.Combo.All();
            Combo = combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
            ClientTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameClientType).ToList();
            PolicyTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePolicyType).ToList();
            FrequencyTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameFrequency).ToList();
            StatusTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameStatus).ToList();
            CompanyCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCompany).ToList();
            CompanyNames = CompanyCollection.Select(x => x.Description.Trim()).ToList();
            PersonStatusCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePStatus).ToList();
            SVCTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameSVCType).ToList();
            CategoryCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCategory).ToList();
            CurrencyCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCurrency).ToList();
        }
        private void LoadData()
        {
            GetComboData();
            GetAutoSuggestionLists();
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
        private void GetAutoSuggestionLists()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).ToList();

            EntityTypes = ClientTypeCollection.Select(r => r.Description).ToList();
        }
        private void GetPolicyCollection()
        {
            if (PolicySelectedClient != null)
            {
                SearchQuery searchQuery = new SearchQuery();
                List<FilterBy> searchBy = new List<FilterBy>();
                BuildFilterByEquals("keynump", PolicySelectedClient.Keynump.ToString(), searchBy);
                searchQuery.FilterBy = searchBy;

                var dataSearchBy = _unitOfWork.Policies.Find(searchQuery);

                var policyCollection = (dataSearchBy.Result.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList());
                
                PolicyCollection = new ObservableCollection<ViewPolicyListDto>(policyCollection.Select(x =>
                {
                    x.Type = string.IsNullOrEmpty(x.Type.Trim()) ? "" : PolicyTypeCollection.Where(c => c.FieldCode == x.Type.Trim()).FirstOrDefault()?.Description;
                    x.Frequency = string.IsNullOrEmpty(x.Frequency.Trim()) ? "" : FrequencyTypeCollection.Where(c => c.FieldCode == x.Frequency.Trim()).FirstOrDefault()?.Description;
                    x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : StatusTypeCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault()?.Description;
                    x.CompanyName = string.IsNullOrEmpty(x.CompanyName.Trim()) ? "" : CompanyCollection.Where(c => c.FieldCode == x.CompanyName.Trim()).FirstOrDefault()?.Description;
                    x.PeoplePolicy = x.PeoplePolicy.Select(
                        p =>
                        {
                            p.Category = string.IsNullOrEmpty(p.Category.Trim()) ? "" : CategoryCollection.Where(c => c.FieldCode == p.Category.Trim()).FirstOrDefault()?.Description;
                            return p;
                        }
                    ).ToList();
                    return x;
                }));

                if (PolicyCollection.Count > 0)
                {
                    if (SavedPolicyDetail != null
                        && PolicyCollection.Where(x => x.Id == SavedPolicyDetail.Id).FirstOrDefault() != null)
                    {
                        SelectedPolicy = PolicyCollection.Where(x => x.Id == SavedPolicyDetail.Id).FirstOrDefault();
                    }
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
            PolicySelectedClient = SelectedClient;
            if (SelectedPolicy != null)
            {
                SavedPolicyDetail = SelectedPolicy;
            }
            if (PolicySelectedClient != null)
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
                originalEntity.PolicyAgent = null;
                SelectedPolicy.PolicyAgent = null;
                var entity = _mapper.Map(SelectedPolicy, originalEntity);
                entity.PeoplePolicys = null;
                entity.Status = SelectedPolicyStatus != null ? SelectedPolicyStatus.FieldCode.Trim() : SelectedPolicy.Status.Substring(0, 1);
                entity.Frequency = SelectedPolicyFrequencyType != null ? SelectedPolicyFrequencyType.FieldCode.Trim() : SelectedPolicy.Frequency.Substring(0, 1);
                entity.Type = SelectedPolicyType != null ? SelectedPolicyType.FieldCode.Trim() : SelectedPolicy.Type.Substring(0, 1);
                entity.Company = SelectedPolicyCompany != null ? SelectedPolicyCompany.FieldCode.Trim() : SelectedPolicy.CompanyName.Substring(0, 1);
                entity.Currency = SelectedPolicyCurrency != null ? SelectedPolicyCurrency.FieldCode.Trim() : SelectedPolicy.Currency.Substring(0, 3);
                entity.IssueAge = SelectedPolicy.Age.ToString();

                _unitOfWork.Policies.Save(entity);
                _unitOfWork.Commit();

                var updatedEntity = _unitOfWork.Policies.GetById(entity.Keynumo);
                SelectedPolicy = _mapper.Map<ViewPolicyListDto>(updatedEntity);
                SavedPolicyDetail = SelectedPolicy;
                PolicySelectedClient = SelectedClient;
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
            if (string.IsNullOrEmpty(SelectedPolicy.CompanyName.Trim()))
            {
                _notifier.ShowError("Company name is invalid");
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
            if(!DateTime.TryParse(SelectedPolicy.PlacedOn.ToString(), out DateTime placedOn)
                || placedOn == date)
            {
                _notifier.ShowError("Placement date is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicy.Rating.Trim()))
            {
                _notifier.ShowError("Rating is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicyCurrency.Description.Trim()))
            {
                _notifier.ShowError("Currency is invalid");
                return false;
            }
            if (!DateTime.TryParse(SelectedPolicy.ReprojectedOn.ToString(), out DateTime reprojectedDate)
                || reprojectedDate == date)
            {
                _notifier.ShowError("Reprojection date is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicy.Class.Trim()))
            {
                _notifier.ShowError("Class is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicyStatus.Description.Trim()))
            {
                _notifier.ShowError("Policy status is invalid");
                return false;
            }
            if (string.IsNullOrEmpty(SelectedPolicyFrequencyType.Description.Trim()))
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
                if (SelectedPolicy != null)
                {
                    SelectedPolicy.PeoplePolicy = null;
                    SelectedPolicy.PolicyAgent = null;
                    var originalPolicy = _unitOfWork.Policies.GetById(SelectedPolicy.Id);
                    var entity = _mapper.Map(SelectedPolicy, originalPolicy);
                    _unitOfWork.Policies.Save(entity);
                    _unitOfWork.Commit();
                    _notifier.ShowSuccess("Policy Notes updated successfully");
                }
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
                if (SelectedPolicy != null)
                {
                    SelectedPolicy.PeoplePolicy = null;
                    SelectedPolicy.PolicyAgent = null;
                    var originalPolicy = _unitOfWork.Policies.GetById(SelectedPolicy.Id);
                    var entity = _mapper.Map(SelectedPolicy, originalPolicy);
                    _unitOfWork.Policies.Save(entity);
                    _unitOfWork.Commit();
                    _notifier.ShowSuccess("Policy Notes updated successfully");
                }
            }
            catch (Exception ex)
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
                if (SelectedPolicy != null)
                {
                    SelectedPolicy.PeoplePolicy = null;
                    SelectedPolicy.PolicyAgent = null;
                    var originalPolicy = _unitOfWork.Policies.GetById(SelectedPolicy.Id);
                    var entity = _mapper.Map(SelectedPolicy, originalPolicy);
                    _unitOfWork.Policies.Save(entity);
                    _unitOfWork.Commit();
                    _notifier.ShowSuccess("Policy Notes updated successfully");
                }
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
        #endregion Methods
    }
}
