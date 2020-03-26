using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using ToastNotifications;

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
            }
        }
        public bool IsPhotoEmpty
        {
            get { return string.IsNullOrEmpty(People?.PhotoPath); }
        }
        public string NameInitials
        {
            get { return People != null ? $"{People.CommanName.Trim().Substring(0, 1)}{People.LastName.Trim().Substring(0, 1)}" : string.Empty; }
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
                People = People;
            }
        }
        #endregion
    }
}
