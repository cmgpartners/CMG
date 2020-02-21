using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using CMG.Service;
using CMG.Service.Interface;
using Newtonsoft.Json;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;
using ToastNotifications;
using ToastNotifications.Messages;

namespace CMG.Application.ViewModel
{
    public class ConfigurationViewModel : MainViewModel
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public readonly IDialogService _dialogService;
        private readonly Notifier _notifier;
        private const string CompanyFieldName = "COMPANY";
        private const string StatusFieldName = "STATUS";
        private int newId;
        public ConfigurationViewModel(IUnitOfWork unitOfWork, IMapper mapper, IDialogService dialogService = null, Notifier notifier = null)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _dialogService = dialogService;
            _notifier = notifier;
            LoadData();
        }
        #region Properties
        private ObservableCollection<ViewComboDto> _companies;
        public ObservableCollection<ViewComboDto> Companies
        {
            get { return _companies; }
            set { _companies = value; OnPropertyChanged("Companies"); }
        }
        private ObservableCollection<ViewComboDto> _originalCompanies;
        public ObservableCollection<ViewComboDto> OriginalCompanies
        {
            get { return _originalCompanies; }
            set { _originalCompanies = value; OnPropertyChanged("OriginalCompanies"); }
        }

        private ObservableCollection<ViewComboDto> _policyStatus;
        public ObservableCollection<ViewComboDto> PolicyStatus
        {
            get { return _policyStatus; }
            set { _policyStatus = value; OnPropertyChanged("PolicyStatus"); }
        }
        private ObservableCollection<ViewComboDto> _originalPolicyStatus;
        public ObservableCollection<ViewComboDto> OriginalPolicyStatus
        {
            get { return _originalPolicyStatus; }
            set { _originalPolicyStatus = value; OnPropertyChanged("OriginalPolicyStatus"); }
        }
        public ICommand AddCompanyCommand
        {
            get { return CreateCommand(AddCompany); }
        }
        public ICommand DeleteCompanyCommand
        {
            get { return CreateCommand(DeleteCompany); }
        }
        public ICommand SaveCompanyCommand
        {
            get { return CreateCommand(SaveCompany); }
        }
        public ICommand CancelCompanyCommand
        {
            get { return CreateCommand(CancelCompany); }
        }
        public ICommand AddStatusCommand
        {
            get { return CreateCommand(AddStatus); }
        }
        public ICommand DeleteStatusCommand
        {
            get { return CreateCommand(DeleteStatus); }
        }
        public ICommand SaveStatusCommand
        {
            get { return CreateCommand(SaveStatus); }
        }
        public ICommand CancelStatusCommand
        {
            get { return CreateCommand(CancelStatus); }
        }
        #endregion
        private new void LoadData()
        {
            GetCompanies();
            GetPolicyStatus();
        }
        private void GetCompanies()
        {
            var combo = _unitOfWork.Combo.All().Where(x => x.FIELDNAME.Trim() == CompanyFieldName).ToList();
            Companies = new ObservableCollection<ViewComboDto>(combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList());
            OriginalCompanies = new ObservableCollection<ViewComboDto>(combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList());
        }

        private void GetPolicyStatus()
        {
            var combo = _unitOfWork.Combo.All().Where(x => x.FIELDNAME.Trim() == StatusFieldName).ToList();
            PolicyStatus = new ObservableCollection<ViewComboDto>(combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList());
            OriginalPolicyStatus = new ObservableCollection<ViewComboDto>(combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList());
        }
        public void AddCompany()
        {
            Companies.Add(new ViewComboDto() { Id = --newId });
        }
        public void AddStatus()
        {
            PolicyStatus.Add(new ViewComboDto() { Id = --newId });
        }
        public void DeleteCompany(object id)
        {
            DeleteComboItem(id, Companies);
        }
        public void DeleteStatus(object id)
        {
            DeleteComboItem(id, PolicyStatus);
        }
        private void SaveCompany()
        {
            try
            {
                foreach (ViewComboDto comboItem in Companies)
                {
                    if (string.IsNullOrEmpty(comboItem.Description))
                    {
                        _notifier.ShowError("Please enter company name");
                        return;
                    }
                    var originalComboItem = OriginalCompanies?.Where(item => item.Id == comboItem.Id).FirstOrDefault();
                    if (comboItem.Id > 0)
                    {
                        var comboItemJson = JsonConvert.SerializeObject(comboItem);
                        var originalComboItemJson = JsonConvert.SerializeObject(originalComboItem);
                        if (originalComboItem == null || !(comboItemJson == originalComboItemJson))
                        {
                            var entity = _mapper.Map<Combo>(comboItem);
                            entity.Rev_Date = DateTime.Now;
                            entity.Rev_Locn = $"{Environment.UserDomainName}\\{Environment.UserName}";
                            _unitOfWork.Combo.Save(entity);
                        }
                    }
                    else
                    {
                        if (OriginalCompanies.Any(c => c.Description.Trim().ToLower() == comboItem.Description.Trim().ToLower()))
                        {
                            _notifier.ShowError("Company already exist");
                            return;
                        }
                        var entity = _mapper.Map<Combo>(comboItem);
                        string[] splits = entity.DESC_.Split(" ");
                        string code = string.Empty;
                        Random random = new Random();
                        if (splits.Length > 1)
                        {
                            code = $"{splits[0][0]}{splits[1][0]}";
                        }
                        else
                        {
                            code = $"{splits[0][0]}{splits[0][splits[0].Length - 1]}";
                        }
                        while (OriginalCompanies.Any(c => c.FieldCode.ToLower() == code.ToLower()))
                        {
                            code = RandomString(2, random);
                        }
                        entity.Id = 0;
                        entity.FLDCODE = code.ToUpper();
                        entity.FIELDNAME = CompanyFieldName;
                        entity.Rev_Date = DateTime.Now;
                        entity.Rev_Locn = $"{Environment.UserDomainName}\\{Environment.UserName}";
                        _unitOfWork.Combo.Add(entity);
                    }
                }
                _unitOfWork.Commit();
                GetCompanies();
                _notifier.ShowSuccess("Record added/updated successfully");
            }
            catch
            {
                _notifier.ShowError("Error occured while add/update record");
            }
        }
        private void SaveStatus()
        {
            try
            {
                foreach (ViewComboDto comboItem in PolicyStatus)
                {
                    if (string.IsNullOrEmpty(comboItem.Description))
                    {
                        _notifier.ShowError("Please enter status");
                        return;
                    }
                    var originalComboItem = OriginalPolicyStatus?.Where(item => item.Id == comboItem.Id).FirstOrDefault();
                    if (comboItem.Id > 0)
                    {
                        var comboItemJson = JsonConvert.SerializeObject(comboItem);
                        var originalComboItemJson = JsonConvert.SerializeObject(originalComboItem);
                        if (originalComboItem == null || !(comboItemJson == originalComboItemJson))
                        {
                            var entity = _mapper.Map<Combo>(comboItem);
                            entity.Rev_Date = DateTime.Now;
                            entity.Rev_Locn = $"{Environment.UserDomainName}\\{Environment.UserName}";
                            _unitOfWork.Combo.Save(entity);
                        }
                    }
                    else
                    {
                        if (OriginalPolicyStatus.Any(c => c.Description.Trim().ToLower() == comboItem.Description.Trim().ToLower()))
                        {
                            _notifier.ShowError("Status already exist");
                            return;
                        }
                        var entity = _mapper.Map<Combo>(comboItem);
                        string[] splits = entity.DESC_.Split(" ");
                        string code = string.Empty;
                        Random random = new Random();
                        if (splits.Length > 0)
                        {
                            code = $"{splits[0][0]}";
                            while (OriginalPolicyStatus.Any(c => c.FieldCode.ToLower() == code.ToLower()))
                            {
                                code = RandomString(1, random);
                            }
                        }
                        entity.Id = 0;
                        entity.FLDCODE = code.ToUpper();
                        entity.FIELDNAME = StatusFieldName;
                        entity.Rev_Date = DateTime.Now;
                        entity.Rev_Locn = $"{Environment.UserDomainName}\\{Environment.UserName}";
                        _unitOfWork.Combo.Add(entity);
                    }
                }
                _unitOfWork.Commit();
                GetPolicyStatus();
                _notifier.ShowSuccess("Record added/updated successfully");
            }
            catch
            {
                _notifier.ShowError("Error occured while add/update record");
            }
        }
        private void CancelCompany()
        {
            GetCompanies();
        }
        private void CancelStatus()
        {
            GetPolicyStatus();
        }

        #region Helper Methods
        private void DeleteComboItem(object id, ObservableCollection<ViewComboDto> collection)
        {
            try
            {
                var result = _dialogService.ShowMessageBox("Do you really want to delete the record?");
                if (result == DialogServiceLibrary.MessageBoxResult.Yes)
                {
                    if (id != null && Convert.ToInt32(id) > 0)
                    {
                        var comboItem = _unitOfWork.Combo.Find(Convert.ToInt32(id));
                        _unitOfWork.Combo.Delete(comboItem);
                        _unitOfWork.Commit();
                    }
                    collection.Remove(collection.Where(item => item.Id == Convert.ToInt32(id)).SingleOrDefault());
                    _notifier.ShowSuccess("Record deleted successfully");
                }
            }
            catch
            {
                _notifier.ShowError("Error occured while deleting record");
            }
        }
        public static string RandomString(int length, Random random)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
        #endregion
    }
}
