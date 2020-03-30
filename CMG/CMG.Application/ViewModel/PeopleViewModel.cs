using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.IO;
using System.Linq;
using System.Windows.Input;
using ToastNotifications;
using ToastNotifications.Messages;

namespace CMG.Application.ViewModel
{
    public class PeopleViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public readonly IDialogService _dialogService;
        public readonly Notifier _notifier;
        private const string comboFieldNameStatus = "PSTATUS";
        private const string comboFieldNameServiceType = "SVC_TYPE";
        private const string comboFieldNameClientType = "CLIENTTYP";
        private const string comboFieldNameRelationCode = "REL_CODE";

        #endregion

        #region Constructor
        public PeopleViewModel(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, IDialogService dialogService = null, Notifier notifier = null, ViewClientSearchDto selectedClientInput = null)
               : base(unitOfWork, mapper, memoryCache)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            SelectedViewModel = this;
            if (selectedClientInput != null)
            {
                SelectedClient = selectedClientInput;
            }
        }
        #endregion
        #region Properties
        private ViewClientSearchDto _selectedClient;
        public ViewClientSearchDto SelectedClient
        {
            get { return _selectedClient; }
            set
            {
                _selectedClient = value;
                OnPropertyChanged("SelectedClient");
                OnPropertyChanged("IsClientDetailVisible");
                OnPropertyChanged("IsClientSelected");
                IsPhotoInSavedMode = true;
                IsPhotoInEditMode = false;
                GetClientDetails();
            }
        }
        public bool IsClientSelected
        {
            get { return SelectedClient != null ? true : false; }
        }
        public bool IsClientDetailVisible
        {
            get { return SelectedClient == null ? true : false; }
        }
        private ViewPeopleDto _people;
        public ViewPeopleDto People
        {
            get { return _people; }
            set
            {
                _people = value;
                OnPropertyChanged("People");
                OnPropertyChanged("IsPhotoEmpty");
                OnPropertyChanged("NameInitials");
                OnPropertyChanged("IsPhotoOptionEnabled");
            }
        }
        public bool IsPhotoEmpty
        {
            get { return string.IsNullOrEmpty(People?.PhotoPath); }
        }
        public bool _isPhotoInEditMode;
        public bool IsPhotoInEditMode
        {
            get { return _isPhotoInEditMode; }
            set { _isPhotoInEditMode = value; OnPropertyChanged("IsPhotoInEditMode"); }
        }
        public bool _isPhotoInSavedMode = true;
        public bool IsPhotoInSavedMode
        {
            get { return _isPhotoInSavedMode; }
            set { _isPhotoInSavedMode = value; OnPropertyChanged("IsPhotoInSavedMode"); }
        }
        public bool IsPhotoOptionEnabled
        {
            get { return People != null; }
        }

        public string NameInitials
        {
            get { return People != null ? $"{People.CommanName.Trim().Substring(0, 1)}{People.LastName.Trim().Substring(0, 1)}" : string.Empty; }
        }
        public ICommand SavePhotoCommand
        {
            get { return CreateCommand(SavePhoto); }
        }
        public ICommand CancelPhotoCommand
        {
            get { return CreateCommand(CancelPhoto); }
        }
        #endregion
        #region Helper Methods
        private void GetClientDetails()
        {
            if(SelectedClient != null)
            {
                var people = _unitOfWork.People.GetDetails(SelectedClient.Keynump);
                People = _mapper.Map<ViewPeopleDto>(people);
                People.PrimaryBusiness = People.BusinessRelations.Where(b => b.IsPrimary == true).FirstOrDefault()?.Business;
                People.Status = Combo.Where(c => c.FieldName.Trim() == comboFieldNameStatus && c.FieldCode.Trim() == People.Status.Trim()).FirstOrDefault()?.Description;
                People.ServiceType = Combo.Where(c => c.FieldName.Trim() == comboFieldNameServiceType && c.FieldCode.Trim() == People.ServiceType.Trim()).FirstOrDefault()?.Description;
                People.ClientType = Combo.Where(c => c.FieldName.Trim() == comboFieldNameClientType && c.FieldCode.Trim() == People.ClientType.Trim()).FirstOrDefault()?.Description;
                People.Cases = People.Cases.Where(c => c.CaseStage > 0).ToList();
                People.Family = People.PeopleRelations.Where(r => r.RelationGroup.Trim() == "F")
                    .Select(r => new ViewRelPPDto()
                    {
                        RelationDescription = Combo.Where(c => c.FieldName.Trim() == comboFieldNameRelationCode && c.FieldCode.Trim() == r.RelationCode.Trim()).FirstOrDefault()?.Description,
                        RelatedPeople = People.PeopleId == r.People.PeopleId ? r.RelatedPeople : r.People
                    }
                    ).ToList();
                People.KeyAdvisors = People.PeopleRelations.Where(r => r.RelationGroup.Trim() == "A")
                    .Select(r => new ViewRelPPDto()
                    {
                        RelationDescription = Combo.Where(c => c.FieldName.Trim() == comboFieldNameRelationCode && c.FieldCode.Trim() == r.RelationCode.Trim()).FirstOrDefault()?.Description,
                        RelatedPeople = People.PeopleId == r.People.PeopleId ? r.RelatedPeople : r.People
                    }
                    ).ToList();
                People.TotalFaceAmount = People.PeoplePolicies.Select(p => p.Policy.FaceAmount).Sum();
                People.TotalPremiumAmount = People.PeoplePolicies.Select(p => p.Policy.Payment).Sum();
                if(!string.IsNullOrEmpty(People.PhotoPath) && !File.Exists(People.PhotoPath))
                {
                    People.PhotoPath = string.Empty;
                }
                People = People;
            }
        }
        private void SavePhoto()
        {
            try
            {
                var length = new FileInfo(People.PhotoPath).Length;
                if (length > 1000000)
                {
                    _notifier.ShowError("File size should be less than 1 MB");
                    return;
                }
                var people = _unitOfWork.People.GetById(People.PeopleId);
                var fileName = People.PhotoPath.Substring(People.PhotoPath.LastIndexOf("/") + 1);
                var newFileName = $"{People.CommanName.Trim()} {People.LastName.Trim()}{fileName.Substring(fileName.LastIndexOf("."))}";
                var newFilePath = $"L:\\pix\\{newFileName}";
                newFilePath = GetNewFileName(newFilePath, newFilePath.Substring(newFilePath.LastIndexOf(".")), 1);
                File.Copy(People.PhotoPath, newFilePath);
                people.Picpath = newFilePath;
                _unitOfWork.People.Save(people);
                _unitOfWork.Commit();
                IsPhotoInEditMode = false;
                IsPhotoInSavedMode = true;
            }
            catch
            {
                _notifier.ShowError("Error occured while uploading photo");
            }
        }
        private void CancelPhoto()
        {
            var people = _unitOfWork.People.GetById(People.PeopleId);
            People.PhotoPath = people.Picpath;
            if (!string.IsNullOrEmpty(People.PhotoPath) && !File.Exists(People.PhotoPath))
            {
                People.PhotoPath = string.Empty;
            }
            People = People;
            IsPhotoInEditMode = false;
            IsPhotoInSavedMode = true;
        }
        private string GetNewFileName(string fileName, string fileExtension, int i)
        {
            while (File.Exists(fileName))
            {
                fileName = $"L:\\pix\\{People.CommanName}{i}{fileExtension}";
                i++;
                GetNewFileName(fileName, fileName.Substring(fileName.LastIndexOf(".")), i);
            }
            return fileName;
        }
        #endregion
    }
}
