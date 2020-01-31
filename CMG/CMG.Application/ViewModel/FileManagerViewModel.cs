using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Text;
using ToastNotifications;

namespace CMG.Application.ViewModel
{
    public class FileManagerViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDialogService _dialogService;
        private readonly Notifier _notifier;
        #endregion Member variables

        #region Constructor
        public FileManagerViewModel(IUnitOfWork unitOfWork, IMapper mapper, IDialogService dialogService = null, Notifier notifier = null)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
        }
        public FileManagerViewModel(IUnitOfWork unitOfWork, IMapper mapper, ViewClientSearchDto selectedClientInput, IDialogService dialogService = null, Notifier notifier = null)
            :base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            PolicySelectedClient = selectedClientInput;
        }
        #endregion Constructor

        #region Properties
        private ObservableCollection<ViewFileManagerDto> _dataCollection;
        public ObservableCollection<ViewFileManagerDto> DataCollection
        {
            get { return _dataCollection; }
            set
            {
                _dataCollection = value;
                OnPropertyChanged("DataCollection");
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
        #endregion properties

        #region Methods
        #endregion Methods
    }
}
