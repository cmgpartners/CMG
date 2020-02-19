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
            Companies.Add(new ViewComboDto() { Id  = --newId });
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
            SaveComboItem(Companies, OriginalCompanies);
            GetCompanies();
        }
        private void SaveStatus()
        {
            SaveComboItem(PolicyStatus, OriginalPolicyStatus, StatusFieldName);
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
        private void SaveComboItem(ObservableCollection<ViewComboDto> collection, ObservableCollection<ViewComboDto> originalCollection, string comboItemType = CompanyFieldName)
        {
            try
            {
                foreach (ViewComboDto comboItem in collection)
                {
                    var originalComboItem = originalCollection?.Where(item => item.Id == comboItem.Id).FirstOrDefault();
                    if (comboItem.Id > 0)
                    {
                        var comboItemJson = JsonConvert.SerializeObject(comboItem);
                        var originalComboItemJson = JsonConvert.SerializeObject(originalComboItem);
                        if (originalComboItem == null || !(comboItemJson == originalComboItemJson))
                        {
                            var entity = _mapper.Map<Combo>(comboItem);
                            _unitOfWork.Combo.Save(entity);
                        }
                    }
                    else
                    {
                        var entity = _mapper.Map<Combo>(comboItem);
                        string[] splits = entity.DESC_.Split(" ");
                        if(splits.Length > 1)
                        {

                        }
                        _unitOfWork.Combo.Add(entity);
                    }
                }
                _unitOfWork.Commit();
                _notifier.ShowSuccess("Record added/updated successfully");
            }
            catch
            {
                _notifier.ShowError("Error occured while add/update record");
            }
        }
        #endregion
    }
}
