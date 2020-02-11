using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using Microsoft.Extensions.Caching.Memory;
using System.IO;
using ToastNotifications;
using System.Collections.Generic;
using System.Linq;

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
        public FileManagerViewModel(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, IDialogService dialogService = null, Notifier notifier = null)
            : base(unitOfWork, mapper, memoryCache)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            SelectedViewModel = this;
        }
        public FileManagerViewModel(IUnitOfWork unitOfWork, IMapper mapper, ViewClientSearchDto selectedClientInput, IMemoryCache memoryCache = null, IDialogService dialogService = null, Notifier notifier = null)
            :base(unitOfWork, mapper, memoryCache)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            SelectedViewModel = this;
        }
        #endregion Constructor

        #region Properties        
        public List<DriveInfo> MappedDrives 
        {
            get 
            {
                return DriveInfo.GetDrives().Where(dr => dr.IsReady == true).ToList(); 
            }
        }
        #endregion properties
    }
}
