using AutoMapper;
using CMG.DataAccess.Interface;
using CMG.Service.Interface;
using System;
using System.Collections.Generic;
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
            :base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
        }
        #endregion Constructor

        #region Properties
        #endregion properties

        #region Methods
        #endregion Methods
    }
}
