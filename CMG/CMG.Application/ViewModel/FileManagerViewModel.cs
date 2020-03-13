using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using Microsoft.Extensions.Caching.Memory;
using System.IO;
using ToastNotifications;
using System.Collections.Generic;
using System.Linq;
using System.Collections.ObjectModel;

namespace CMG.Application.ViewModel
{
    public class FileManagerViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IDialogService _dialogService;
        public readonly Notifier _notifier;
        #endregion Member variables

        #region Constructor
        public FileManagerViewModel(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, IDialogService dialogService = null, Notifier notifier = null, ViewClientSearchDto selectedClientInput=null)
            :base(unitOfWork, mapper, memoryCache)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            SelectedViewModel = this;
            FilesCollection = new ObservableCollection<ViewFilesDto>();
            if (selectedClientInput != null)
            {
                SelectedClient = selectedClientInput;
            }
        }
        #endregion Constructor

        #region Properties
        public bool IsPolicyDetailVisible
        {
            get { return SelectedClient == null ? true : false; }
        }
        public List<DriveInfo> MappedDrives 
        {
            get 
            {
                return DriveInfo.GetDrives().Where(dr => dr.IsReady == true).ToList(); 
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
                OnPropertyChanged("IsPolicyDetailVisible");
                OnPropertyChanged("IsClientSelected");
            }
        }
        public bool IsClientSelected
        {
            get { return SelectedClient != null ? true : false; }
        }
        
        private ObservableCollection<ViewFilesDto> _filesCollection;
        public ObservableCollection<ViewFilesDto> FilesCollection 
        {
            get { return _filesCollection; }
            set
            {
                _filesCollection = value;
                OnPropertyChanged("FilesCollection");
                OnPropertyChanged("IsNoFile");
            }
        }
        public bool IsNoFile
        {
            get
            {
                return FilesCollection != null && FilesCollection.Count == 0;
            }
        }
        #endregion properties
    }
}
