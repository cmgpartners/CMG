using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
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
        #endregion
    }
}
